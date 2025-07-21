# JsonToSqlTranslatorService - Detailed Technical Documentation

## Overview

The `JsonToSqlTranslatorService` is a Spring Boot service that translates JSON query structures into SQL using Apache Calcite's relational algebra framework. It builds an Abstract Syntax Tree (AST) from JSON input and converts it to SQL through Calcite's RelNode system.

## Architecture Flow

```
JSON Input → JSON AST → Calcite Schema → RelBuilder → RelNode AST → SQL Output
```

## 1. JSON Input Structure & AST Parsing

### Example Input JSON:
```json
{
    "query": {
        "Account": {
            "select": {
                "id": true,
                "accountNumber": true,
                "primaryOwner": {
                    "select": {
                        "firstName": true,
                        "lastName": true
                    }
                }
            },
            "filter": [
                "accountNumber == '1234'",
                "balance >= 10000"
            ],
            "orderBy": [
                "desc(accountNumber)",
                "balance"
            ]
        }
    },
    "dialect": "POSTGRESQL"
}
```

### JSON AST Structure:
The service uses Jackson's `JsonNode` to parse the input into a tree structure:

```
JsonNode (root)
├── "query" → JsonNode
│   └── "Account" → JsonNode (mainTableNode)
│       ├── "select" → JsonNode (selectNode)
│       │   ├── "id" → BooleanNode(true)
│       │   ├── "accountNumber" → BooleanNode(true)
│       │   └── "primaryOwner" → ObjectNode
│       │       └── "select" → JsonNode
│       │           ├── "firstName" → BooleanNode(true)
│       │           └── "lastName" → BooleanNode(true)
│       ├── "filter" → ArrayNode
│       │   ├── TextNode("accountNumber == '1234'")
│       │   └── TextNode("balance >= 10000")
│       └── "orderBy" → ArrayNode
│           ├── TextNode("desc(accountNumber)")
│           └── TextNode("balance")
└── "dialect" → TextNode("POSTGRESQL")
```

## 2. Schema Creation Phase

### Step 1: Extract Root Table Name
```java
Iterator<String> rootTableNames = queryNode.fieldNames();
String rootTableName = rootTableNames.hasNext() ? rootTableNames.next() : "DefaultTable";
// Result: rootTableName = "Account"
```

### Step 2: Create Calcite Schema
The service creates a Calcite schema and adds tables based on the JSON structure:

```java
SchemaPlus rootSchema = Frameworks.createRootSchema(true);
SchemaPlus schema = rootSchema.add(rootTableName, new AbstractSchema());
```

### Step 3: Table Definition
For each table found in the JSON, it creates a Calcite table with inferred types:

```java
// Account table schema
RelDataTypeFactory.Builder builder = typeFactory.builder();
builder.add("id", SqlTypeName.INTEGER);           // Auto-added
builder.add("accountNumber", SqlTypeName.VARCHAR); // From select
builder.add("primaryOwnerId", SqlTypeName.INTEGER); // Foreign key for join
builder.add("balance", SqlTypeName.DECIMAL);       // Added for filters

// primaryOwner table schema  
builder.add("id", SqlTypeName.INTEGER);
builder.add("firstName", SqlTypeName.VARCHAR);
builder.add("lastName", SqlTypeName.VARCHAR);
```

**Type Inference Logic:**
- Fields containing "id", "count" → INTEGER
- Fields containing "balance", "amount", "price" → DECIMAL  
- Fields containing "date", "time" → TIMESTAMP
- Fields containing "active", "enabled", "flag" → BOOLEAN
- All others → VARCHAR

## 3. Relational Algebra AST Construction

### Step 1: Table Scanning
```java
builder.scan(rootTableName, mainTableName); // Scan Account table
```

**Calcite RelNode AST:**
```
LogicalTableScan(table=[[Account]])
```

### Step 2: Join Construction
When a nested object is found in select (like `primaryOwner`), it creates a join:

```java
builder.scan(rootTableName, fieldName); // Scan primaryOwner table
RexNode joinCondition = rexBuilder.makeCall(
    SqlStdOperatorTable.EQUALS,
    rexBuilder.makeInputRef(leftFieldType, leftFieldIndex),   // Account.primaryOwnerId
    rexBuilder.makeInputRef(rightFieldType, rightFieldIndex) // primaryOwner.id
);
builder.join(JoinRelType.INNER, joinCondition);
```

**Updated RelNode AST:**
```
LogicalJoin(condition=[=($3, $0)], joinType=[inner])
├── LogicalTableScan(table=[[Account]])
└── LogicalTableScan(table=[[primaryOwner]])
```

**Field Layout After Join:**
```
Index | Field Name        | Source Table  | Type
------|------------------|---------------|--------
0     | id               | Account       | INTEGER
1     | id0              | Account       | INTEGER (duplicate)
2     | accountNumber    | Account       | VARCHAR
3     | primaryOwnerId   | Account       | INTEGER
4     | id1              | primaryOwner  | INTEGER
5     | firstName        | primaryOwner  | VARCHAR
6     | lastName         | primaryOwner  | VARCHAR
```

### Step 3: Projection (SELECT clause)
The service builds projections with aliases:

```java
List<RexNode> projects = new ArrayList<>();
List<String> aliases = new ArrayList<>();

// For each selected field
projects.add(rexBuilder.makeInputRef(fieldType, fieldIndex));
aliases.add(tableName + "_" + fieldName);
```

**Projection Mapping:**
```
Field Selection:           Index:  Alias:
Account.id            →    0    → "Account_id"
Account.accountNumber →    2    → "Account_accountNumber"  
primaryOwner.firstName→    5    → "primaryOwner_firstName"
primaryOwner.lastName →    6    → "primaryOwner_lastName"
```

**RelNode AST After Projection:**
```
LogicalProject(Account_id=[$0], Account_accountNumber=[$2], 
               primaryOwner_firstName=[$5], primaryOwner_lastName=[$6])
└── LogicalJoin(condition=[=($3, $4)], joinType=[inner])
    ├── LogicalTableScan(table=[[Account]])
    └── LogicalTableScan(table=[[primaryOwner]])
```

### Step 4: Filter Construction
Filters are parsed and converted to RexNode conditions:

```java
// Parse "accountNumber == '1234'"
String[] parts = filterStr.split("==");
String field = parts[0].trim();           // "accountNumber"  
String value = parts[1].trim();           // "'1234'"

// Find field index in aliases
int fieldIndex = getFieldIndexByName(rowType, field, aliases);
// fieldIndex = 1 (Account_accountNumber position in projection)

RexNode condition = rexBuilder.makeCall(
    SqlStdOperatorTable.EQUALS,
    rexBuilder.makeInputRef(fieldType, fieldIndex),
    rexBuilder.makeLiteral(value)
);
```

**RelNode AST After Filter:**
```
LogicalFilter(condition=[=($1, '1234')])
└── LogicalProject(Account_id=[$0], Account_accountNumber=[$2], 
                   primaryOwner_firstName=[$5], primaryOwner_lastName=[$6])
    └── LogicalJoin(condition=[=($3, $4)], joinType=[inner])
        ├── LogicalTableScan(table=[[Account]])
        └── LogicalTableScan(table=[[primaryOwner]])
```

### Step 5: Order By Construction
```java
// Parse "desc(accountNumber)"
String field = orderStr.substring(5, orderStr.length() - 1); // "accountNumber"
int fieldIndex = getFieldIndexByName(rowType, field, aliases); // 1

RexNode sortExpr = rexBuilder.makeCall(
    SqlStdOperatorTable.DESC,
    rexBuilder.makeInputRef(fieldType, fieldIndex)
);
```

**Final RelNode AST:**
```
LogicalSort(sort0=[$1], dir0=[DESC])
└── LogicalFilter(condition=[=($1, '1234')])
    └── LogicalProject(Account_id=[$0], Account_accountNumber=[$2], 
                       primaryOwner_firstName=[$5], primaryOwner_lastName=[$6])
        └── LogicalJoin(condition=[=($3, $4)], joinType=[inner])
            ├── LogicalTableScan(table=[[Account]])
            └── LogicalTableScan(table=[[primaryOwner]])
```

## 4. SQL Generation

### RelToSqlConverter Process
Calcite's `RelToSqlConverter` traverses the RelNode AST and generates SQL:

```java
SqlDialect dialect = getDialect(dialectName);
String sql = new RelToSqlConverter(dialect)
    .visitRoot(relNode)
    .asStatement()
    .toSqlString(dialect)
    .getSql();
```

### AST to SQL Mapping:

1. **LogicalSort** → `ORDER BY "accountNumber" DESC`
2. **LogicalFilter** → `WHERE "t"."Account_accountNumber" = '1234'`  
3. **LogicalProject** → `SELECT "Account"."id" AS "Account_id", ...`
4. **LogicalJoin** → `INNER JOIN "primaryOwner" ON ...`
5. **LogicalTableScan** → `FROM "Account"`

### Final SQL Output:
```sql
SELECT "Account"."id" AS "Account_id", 
       "Account"."accountNumber" AS "Account_accountNumber", 
       "primaryOwner"."firstName" AS "primaryOwner_firstName", 
       "primaryOwner"."lastName" AS "primaryOwner_lastName"
FROM "Account"
INNER JOIN "primaryOwner" ON "Account"."primaryOwnerId" = "primaryOwner"."id"
WHERE "Account_accountNumber" = '1234'
ORDER BY "Account_accountNumber" DESC
```

## 5. Key Components Deep Dive

### A. Field Index Resolution
The service maintains two mapping systems:

1. **Row Type Fields** - Physical field positions in joined tables
2. **Alias List** - Logical field names for projections

```java
private int getFieldIndexByName(RelDataType rowType, String fieldName, List<String> aliases) {
    // 1. Try exact match in aliases
    int aliasIndex = aliases.indexOf(fieldName);
    
    // 2. Try prefix match (accountNumber → Account_accountNumber)  
    for (int i = 0; i < aliases.size(); i++) {
        if (aliases.get(i).endsWith("_" + fieldName)) {
            return i;
        }
    }
    
    // 3. Fallback to row type lookup
    return getFieldIndex(rowType, fieldName);
}
```

### B. Type System Integration
Calcite uses a strong type system. Each RexNode has an associated RelDataType:

```java
RelDataType fieldType = builder.peek().getRowType().getFieldList().get(fieldIndex).getType();
RexNode inputRef = rexBuilder.makeInputRef(fieldType, fieldIndex);
```

### C. Schema Evolution
The service dynamically adds fields that might be needed for filters/ordering even if not selected:

```java
if (tableName.equals("Account")) {
    if (!hasField(selectNode, "balance")) {
        builder.add("balance", SqlTypeName.DECIMAL);
    }
}
```

## 6. Error Handling & Edge Cases

### Common Issues:
1. **Field Not Found**: When filter/orderBy references non-existent fields
2. **Type Mismatches**: When comparing incompatible types
3. **Join Failures**: When foreign key relationships are incorrect

### Resolution Strategy:
- Extensive logging at TRACE/DEBUG levels
- Graceful fallbacks for field resolution
- Type inference based on field naming patterns

## 7. Performance Considerations

### Optimization Techniques:
1. **Lazy Schema Creation** - Tables created only when referenced
2. **Index Caching** - Field positions cached during projection building
3. **Type Inference** - Reduces explicit type declarations

### Memory Usage:
- JsonNode tree: ~1-2KB per query
- RelNode AST: ~5-10KB per query  
- Calcite metadata: ~50-100KB (cached globally)

## 8. Extension Points

### Adding New Operators:
```java
// In parseFilterCondition()
else if (filterStr.contains("LIKE")) {
    // Add LIKE operator support
    return rexBuilder.makeCall(SqlStdOperatorTable.LIKE, ...);
}
```

### Custom Type Inference:
```java
// In inferSqlType()
if (fieldName.matches(".*_uuid$")) {
    return SqlTypeName.CHAR; // UUID fields
}
```

### Dialect-Specific Features:
```java
// In RelToSqlConverter
if (dialect instanceof PostgresqlSqlDialect) {
    // Add PostgreSQL-specific optimizations
}
```

## Conclusion

The JsonToSqlTranslatorService demonstrates a sophisticated use of Apache Calcite's relational algebra framework to convert JSON queries into SQL. The AST-based approach provides flexibility, type safety, and extensibility while maintaining performance through careful field resolution and caching strategies.

The key insight is that JSON structure maps naturally to relational operations:
- Objects → Tables
- Nested objects → Joins  
- Arrays → Filters/Sorts
- Primitives → Field selections

This mapping, combined with Calcite's powerful optimization and SQL generation capabilities, creates a robust query translation system.