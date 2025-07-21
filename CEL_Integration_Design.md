# CEL-Java Integration with JsonToSqlTranslatorService

## Overview

CEL-Java is a powerful expression language implementation that can significantly enhance the JSON to SQL translator by providing advanced filtering, validation, and expression evaluation capabilities. This document outlines how to integrate CEL-Java as a dependency and leverage its features.

## What is CEL-Java?

CEL (Common Expression Language) is Google's safe, fast expression language that:
- **Evaluates in linear time** - Not Turing-complete by design
- **Is mutation-free** - No side effects during evaluation  
- **Provides extensible context** - Custom functions and data providers
- **Supports rich data types** - Strings, numbers, booleans, arrays, maps, dates, durations

## Current CEL-Java Features

### 1. **Expression Evaluation**
```java
// Basic expressions
Evaluator eval = new Evaluator(jsonData);
eval.evaluate("pets[0].type == 'dog'");  // Returns BooleanLiteral(true)
eval.evaluate("name.address.coordinates.latitude > 40.0");
```

### 2. **Complex Data Navigation**
```java
// Array operations
eval.evaluate("pets.map(p, p.type).filter(t, t == 'dog')");

// Map operations  
eval.evaluate("others.ary1.sum()");
```

### 3. **Built-in Functions**
- **Date/Time**: `now()`, `today()`, `timeNow()`
- **Math**: Standard arithmetic operations
- **String**: Concatenation, comparison, regex
- **Array**: `map()`, `filter()`, `reduce()`, `exists()`
- **Validation**: Custom validation blocks

### 4. **Type System**
- `IntLiteral`, `DoubleLiteral`, `StringLiteral`
- `BooleanLiteral`, `NullLiteral`
- `ArrayLiteral`, `MapLiteral`
- `DateLiteral`, `DateTimeLiteral`, `DurationLiteral`

## Integration Strategy

### Phase 1: Add CEL-Java as Dependency

#### Update pom.xml:
```xml
<dependency>
    <groupId>ai.jiffy</groupId>
    <artifactId>cel-java</artifactId>
    <version>2.0.83-SNAPSHOT</version>
</dependency>
```

### Phase 2: Enhanced Filter Processing

#### Current Filter Limitation:
```json
{
    "filter": ["accountNumber == '1234'", "balance >= 10000"]
}
```

#### CEL-Enhanced Filters:
```json
{
    "filter": [
        "accountNumber == '1234'",
        "balance >= 10000 && balance <= 50000",
        "primaryOwner.firstName.startsWith('John')",
        "createdDate >= today() - duration('30d')",
        "tags.exists(t, t == 'premium')"
    ]
}
```

### Phase 3: Custom Schema with CEL Integration

#### JiffyCelSchema Implementation:
```java
public class JiffyCelSchema extends AbstractSchema {
    private final CELEvaluator celEvaluator;
    
    @Override
    public Table getTable(String name) {
        return new JiffyCelTable(name, celEvaluator);
    }
}

public class JiffyCelTable extends AbstractTable {
    private final String tableName;
    private final CELEvaluator evaluator;
    
    // Smart field inference using CEL expressions
    // Dynamic relationship detection
    // Computed columns support
}
```

### Phase 4: CEL-Powered Filter Translator

#### Implementation Approach:
```java
public class CelFilterTranslator {
    private final ExpressionEvaluator celEvaluator;
    
    public RexNode translateCelFilter(String celExpression, RelBuilder builder) {
        // 1. Parse CEL expression into AST
        Expression celAst = new Parser().parseExpression(celExpression);
        
        // 2. Convert CEL AST to Calcite RexNode
        return convertToRexNode(celAst, builder);
    }
    
    private RexNode convertToRexNode(Expression celExpr, RelBuilder builder) {
        // Convert CEL operations to SQL operations
        // Handle complex expressions like array operations
        // Map CEL functions to SQL functions
    }
}
```

## Advanced Use Cases

### 1. **Dynamic Field Selection**
```json
{
    "select": {
        "computed_fields": [
            "fullName: firstName + ' ' + lastName",
            "accountAge: now() - createdDate",
            "isActive: balance > 0 && lastActivity >= today() - duration('90d')"
        ]
    }
}
```

### 2. **Conditional Joins**
```json
{
    "joins": [{
        "table": "primaryOwner",
        "condition": "Account.primaryOwnerId == primaryOwner.id",
        "when": "Account.accountType == 'personal'"
    }]
}
```

### 3. **Advanced Aggregations**
```json
{
    "aggregations": {
        "totalBalance": "accounts.filter(a, a.isActive).map(a, a.balance).sum()",
        "averageAge": "customers.map(c, now() - c.birthDate).average()"
    }
}
```

### 4. **Validation Rules**
```json
{
    "validations": [
        "ensure balance >= 0 : 'Account balance cannot be negative'",
        "ensure email.matches('[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}') : 'Invalid email format'"
    ]
}
```

## Technical Implementation Details

### 1. **CEL Expression to SQL Mapping**

#### CEL Function → SQL Function Mapping:
```java
Map<String, String> celToSqlFunctions = Map.of(
    "startsWith", "LIKE",           // str.startsWith('x') → str LIKE 'x%'
    "endsWith", "LIKE",             // str.endsWith('x') → str LIKE '%x'  
    "contains", "LIKE",             // str.contains('x') → str LIKE '%x%'
    "size", "LENGTH",               // str.size() → LENGTH(str)
    "now", "CURRENT_TIMESTAMP",     // now() → CURRENT_TIMESTAMP
    "today", "CURRENT_DATE"         // today() → CURRENT_DATE
);
```

#### Array Operations to SQL:
```java
// CEL: accounts.filter(a, a.balance > 1000).map(a, a.id)
// SQL: SELECT a.id FROM accounts a WHERE a.balance > 1000

// CEL: accounts.exists(a, a.status == 'active')  
// SQL: EXISTS(SELECT 1 FROM accounts a WHERE a.status = 'active')
```

### 2. **Type Conversion System**
```java
public class CelToCalciteConverter {
    public RelDataType convertCelType(Literal celLiteral) {
        return switch (celLiteral) {
            case IntLiteral il -> typeFactory.createSqlType(SqlTypeName.INTEGER);
            case StringLiteral sl -> typeFactory.createSqlType(SqlTypeName.VARCHAR);
            case BooleanLiteral bl -> typeFactory.createSqlType(SqlTypeName.BOOLEAN);
            case DateLiteral dl -> typeFactory.createSqlType(SqlTypeName.DATE);
            case ArrayLiteral al -> typeFactory.createArrayType(inferElementType(al), -1);
            // ... handle other types
        };
    }
}
```

### 3. **Context-Aware Evaluation**
```java
public class JiffyCelEvaluator extends ExpressionEvaluator {
    private final Map<String, Object> context;
    private final SchemaMetadata schema;
    
    @Override
    public Literal getIdentifierValue(IdentifierLiteral literal) {
        // 1. Check if it's a table field
        // 2. Check if it's a computed field
        // 3. Check if it's a context variable
        // 4. Return appropriate literal
    }
    
    @Override
    public Literal callFunction(IdentifierLiteral literal) {
        // Custom functions for SQL context
        // Database-specific function mappings
        // Performance optimizations
    }
}
```

## Performance Considerations

### 1. **Expression Caching**
```java
private final Map<String, Expression> parsedExpressions = new ConcurrentHashMap<>();

public Expression parseWithCache(String celExpression) {
    return parsedExpressions.computeIfAbsent(celExpression, 
        expr -> new Parser().parseExpression(expr));
}
```

### 2. **Lazy Evaluation**
- Only evaluate CEL expressions when necessary
- Cache intermediate results
- Use Calcite's optimization passes

### 3. **Memory Management**
- Limit expression complexity
- Set timeouts for evaluation
- Monitor heap usage for large datasets

## Security Considerations

### 1. **Sandboxing**
- CEL is designed to be safe by default
- No arbitrary code execution
- Limited recursion depth
- No file system access

### 2. **Input Validation**
```java
public class SecureCelValidator {
    private static final int MAX_EXPRESSION_LENGTH = 1000;
    private static final int MAX_NESTING_DEPTH = 10;
    
    public void validateExpression(String expression) {
        if (expression.length() > MAX_EXPRESSION_LENGTH) {
            throw new SecurityException("Expression too long");
        }
        // Check for dangerous patterns
        // Validate nesting depth
        // Ensure no resource exhaustion
    }
}
```

## Migration Strategy

### Step 1: **Basic Integration**
- Add CEL-Java dependency
- Create wrapper for simple expressions
- Test with existing filter patterns

### Step 2: **Enhanced Filters**
- Replace string-based filters with CEL expressions
- Add support for complex conditions
- Implement function mapping

### Step 3: **Advanced Features**
- Add computed fields
- Implement validation rules
- Support for aggregations

### Step 4: **Optimization**
- Performance tuning
- Caching strategies
- Memory optimization

## Benefits of Integration

1. **Enhanced Expressiveness**: Complex business logic in filters
2. **Type Safety**: Strong typing with automatic conversions
3. **Performance**: Linear time evaluation, optimized for speed
4. **Extensibility**: Easy to add custom functions and operators
5. **Security**: Safe expression evaluation without side effects
6. **Maintainability**: Clear separation of business logic and SQL generation

## Example Integration

```java
@Service
public class CelEnhancedTranslatorService extends JsonToSqlTranslatorService {
    private final CelFilterTranslator celTranslator;
    
    @Override
    protected RexNode parseFilterCondition(RexBuilder rexBuilder, RelBuilder builder, 
                                         String filterStr, List<String> aliases) {
        if (isCelExpression(filterStr)) {
            return celTranslator.translateCelFilter(filterStr, builder);
        }
        return super.parseFilterCondition(rexBuilder, builder, filterStr, aliases);
    }
    
    private boolean isCelExpression(String filter) {
        // Detect CEL-specific syntax patterns
        return filter.contains(".") || filter.contains("(") || 
               filter.contains("map") || filter.contains("filter");
    }
}
```

This integration would transform the JSON to SQL translator from a simple field mapper into a powerful, expression-aware query engine capable of handling complex business logic while maintaining type safety and performance.