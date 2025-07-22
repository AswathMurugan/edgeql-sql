package com.example.jsontosql.service;

import com.example.jsontosql.exception.QueryTranslationException;
import com.example.jsontosql.schema.SchemaReader;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.calcite.jdbc.CalciteConnection;
import org.apache.calcite.plan.RelOptUtil;
import org.apache.calcite.rel.RelNode;
import org.apache.calcite.rel.core.JoinRelType;
import org.apache.calcite.rel.rel2sql.RelToSqlConverter;
import org.apache.calcite.rel.type.RelDataType;
import org.apache.calcite.rel.type.RelDataTypeFactory;
import org.apache.calcite.rex.RexBuilder;
import org.apache.calcite.rex.RexNode;
import org.apache.calcite.schema.SchemaPlus;
import org.apache.calcite.schema.impl.AbstractSchema;
import org.apache.calcite.schema.impl.AbstractTable;
import org.apache.calcite.sql.SqlDialect;
import org.apache.calcite.sql.dialect.PostgresqlSqlDialect;
import org.apache.calcite.sql.fun.SqlStdOperatorTable;
import org.apache.calcite.sql.type.SqlTypeName;
import org.apache.calcite.tools.FrameworkConfig;
import org.apache.calcite.tools.Frameworks;
import org.apache.calcite.tools.RelBuilder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.sql.DriverManager;
import java.util.*;

@Service
public class JsonToSqlTranslatorService {

    private static final Logger logger = LoggerFactory.getLogger(JsonToSqlTranslatorService.class);
    public static final String SELECT = "select";
    private final ObjectMapper objectMapper = new ObjectMapper();
    private final SchemaReader schemaReader;
    
    // Constructor injection for the schema reader (supports both EdgeQL and JSON)
    public JsonToSqlTranslatorService(SchemaReader schemaReader) {
        this.schemaReader = schemaReader;
    }
    
    public String translateToSql(JsonNode queryNode) {
        return translateToSql(queryNode, "public");
    }
    
    public String translateToSql(JsonNode queryNode, String schemaName) {
        logger.info("Starting JSON to SQL translation");
        
        if (queryNode == null) {
            throw new QueryTranslationException("Query node cannot be null");
        }
        
        logger.info("Input Query: {}", queryNode.toString());
        logger.info("Target Dialect: POSTGRESQL");
        
        try {
            SqlDialect dialect = PostgresqlSqlDialect.DEFAULT;
            logger.info("Using SQL Dialect: {}", dialect.getClass().getSimpleName());
            
            logger.info("STEP 1: Creating Calcite Schema");
            SchemaPlus rootSchema = Frameworks.createRootSchema(true);
            
            // Get the root table name from JSON
            Iterator<String> rootTableNames = queryNode.fieldNames();
            String rootTableName = rootTableNames.hasNext() ? rootTableNames.next() : "DefaultTable";
            logger.info("Root table identified: {}", rootTableName);
            
            // Create an empty schema container that will hold our tables
            // This provides a namespace for organizing tables (e.g., "public"."Account" or "wealthdomain"."Account")
            SchemaPlus schema = rootSchema.add(schemaName, new AbstractSchema());
            
            logger.info("STEP 2: Adding Tables to Schema");
            addTablesToSchema(schema, queryNode, rootTableName);
            logger.info("Available tables: {}", schema.getTableNames());
            
            // NOTE: CalciteConnection setup - currently not actively used in our RelBuilder approach
            // This connection would be useful if we needed to:
            // 1. Execute SQL queries directly against Calcite's JDBC interface
            // 2. Use Calcite's SQL parser for parsing existing SQL statements  
            // 3. Access schema metadata through JDBC DatabaseMetaData
            // 4. Run SQL queries like: connection.createStatement().executeQuery("SELECT * FROM Account")
            //
            // Since we're using RelBuilder API directly for programmatic query construction,
            // this JDBC connection is redundant. We could remove it to simplify the code.
            Properties info = new Properties();
            info.setProperty("caseSensitive", "true");  // Make SQL identifiers case-sensitive
            // CalciteConnection connection = (CalciteConnection) DriverManager.getConnection("jdbc:calcite:", info);
            
            logger.info("STEP 3: Creating Calcite Framework Configuration");
            FrameworkConfig config = Frameworks.newConfigBuilder()
                    .defaultSchema(schema)
                    .build();
            
            RelBuilder builder = RelBuilder.create(config);
            logger.debug("RelBuilder created successfully");
            logger.info("STEP 4: Building Relational Algebra");
            RelNode relNode = buildRelationalAlgebra(builder, queryNode, rootTableName, schemaName);
            logger.info("Relational plan created: {}", relNode.getClass().getSimpleName());
            logger.debug("Relational plan details:\n{}", RelOptUtil.toString(relNode));
            
            logger.info("STEP 5: Converting to SQL");
            String sql = new RelToSqlConverter(dialect).visitRoot(relNode).asStatement().toSqlString(dialect).getSql();
            
            // Post-process SQL to add case-sensitive table name quoting
            sql = makeSqlCaseSensitive(sql, queryNode);
            logger.info("Generated SQL: {}", sql);
            
            // connection.close();  // Commented out since CalciteConnection is not being used
            logger.info("Translation completed successfully");
            return sql;
            
        } catch (Exception e) {
            logger.error("Translation failed: {}", e.getMessage(), e);
            throw new QueryTranslationException("Failed to translate JSON to SQL: " + e.getMessage(), e);
        }
    }
    
    /**
     * Post-process the generated SQL to ensure proper case-sensitive table name quoting
     */
    private String makeSqlCaseSensitive(String sql, JsonNode queryNode) {
        Set<String> tableNames = extractTableNames(queryNode);
        
        for (String tableName : tableNames) {
            // Replace table name patterns in FROM and JOIN clauses
            // Pattern: schema.table or just table (avoiding already quoted names)
            sql = sql.replaceAll("(?<!\")" + tableName + "(?!\")", "\"" + tableName + "\"");
        }
        
        return sql;
    }
    
    /**
     * Extract all table names from the JSON query
     */
    private Set<String> extractTableNames(JsonNode queryNode) {
        Set<String> tableNames = new HashSet<>();
        extractTableNamesRecursive(queryNode, tableNames);
        return tableNames;
    }
    
    private void extractTableNamesRecursive(JsonNode node, Set<String> tableNames) {
        if (node.isObject()) {
            Iterator<String> fieldNames = node.fieldNames();
            while (fieldNames.hasNext()) {
                String fieldName = fieldNames.next();
                JsonNode fieldNode = node.get(fieldName);
                
                // If this field represents a table (has a select clause)
                if (fieldNode.isObject() && fieldNode.has(SELECT)) {
                    // Add both the link name and the target table name for proper quoting
                    tableNames.add(fieldName);
                    String targetTableName = mapLinkToTargetTable(fieldName);
                    if (!targetTableName.equals(fieldName)) {
                        tableNames.add(targetTableName);
                    }
                    extractTableNamesRecursive(fieldNode, tableNames);
                } else if (fieldNode.isObject()) {
                    extractTableNamesRecursive(fieldNode, tableNames);
                }
            }
        }
    }
    
    private void addTablesToSchema(SchemaPlus schema, JsonNode queryNode, String rootTableName) {
        Iterator<String> tableNames = queryNode.fieldNames();
        while (tableNames.hasNext()) {
            String tableName = tableNames.next();
            JsonNode tableNode = queryNode.get(tableName);
            
            logger.debug("Adding table '{}' to schema", tableName);
            // Use schema reader (supports both EdgeQL and JSON formats)
            AbstractTable table = schemaReader.createTable(tableName, tableNode);
            schema.add(tableName, table);
            
            addNestedTables(schema, tableNode);
        }
    }
    
    private void addNestedTables(SchemaPlus schema, JsonNode tableNode) {
        if (tableNode.has(SELECT)) {
            JsonNode selectNode = tableNode.get(SELECT);
            Iterator<String> fieldNames = selectNode.fieldNames();
            
            while (fieldNames.hasNext()) {
                String fieldName = fieldNames.next();
                JsonNode fieldNode = selectNode.get(fieldName);
                
                if (fieldNode.isObject() && fieldNode.has(SELECT)) {
                    String targetTableName = mapLinkToTargetTable(fieldName);
                    if (!schema.getTableNames().contains(targetTableName)) {
                        logger.debug("Adding nested table '{}' -> '{}' to schema", fieldName, targetTableName);
                        // Use schema reader for nested tables with the correct target table name
                        AbstractTable table = schemaReader.createTable(targetTableName, fieldNode);
                        schema.add(targetTableName, table);
                    }
                    addNestedTables(schema, fieldNode);
                }
            }
        }
    }
    
    // NOTE: Table creation is now handled by SchemaReader
    // which loads schema definitions from EdgeQL (.txt) or JSON (.json) configuration files
    // located in src/main/resources/schemas/ with EdgeQL taking priority
    
    private SqlTypeName inferSqlType(String fieldName) {
        String lowerFieldName = fieldName.toLowerCase();
        
        if (lowerFieldName.contains("id") || lowerFieldName.contains("count")) {
            return SqlTypeName.INTEGER;
        } else if (lowerFieldName.contains("balance") || lowerFieldName.contains("amount") || 
                   lowerFieldName.contains("price") || lowerFieldName.contains("total")) {
            return SqlTypeName.DECIMAL;
        } else if (lowerFieldName.contains("date") || lowerFieldName.contains("time")) {
            return SqlTypeName.TIMESTAMP;
        } else if (lowerFieldName.contains("active") || lowerFieldName.contains("enabled") || 
                   lowerFieldName.contains("flag")) {
            return SqlTypeName.BOOLEAN;
        } else {
            return SqlTypeName.VARCHAR;
        }
    }
    
    private boolean hasField(JsonNode selectNode, String fieldName) {
        Iterator<String> fieldNames = selectNode.fieldNames();
        while (fieldNames.hasNext()) {
            if (fieldNames.next().equals(fieldName)) {
                return true;
            }
        }
        return false;
    }
    
    private RelNode buildRelationalAlgebra(RelBuilder builder, JsonNode queryNode, String rootTableName, String schemaName) {
        Iterator<String> tableNames = queryNode.fieldNames();
        String mainTableName = tableNames.next();
        JsonNode mainTableNode = queryNode.get(mainTableName);
        
        logger.info("Starting with main table: {}", mainTableName);
        
        // Create the initial table scan operation in the relational algebra tree
        // This is equivalent to "FROM tableName" in SQL
        // Parameters:
        //   - schemaName: Schema name (e.g., "public", "wealthdomain") 
        //   - mainTableName: Table name within schema (e.g., "Account")
        // Creates: LogicalTableScan node representing "FROM schema.table"
        // Example: scan("wealthdomain", "Account") → FROM "wealthdomain"."Account"
        builder.scan(schemaName, mainTableName);
        
        logger.debug("Scanned table: {}", mainTableName);
        
        buildJoins(builder, mainTableNode, mainTableName, schemaName);
        
        // =============================================================================
        // PROJECTION BUILDING PHASE - Creating SELECT clause components
        // =============================================================================
        // These two parallel lists work together to build the SELECT clause:
        // 1. 'projects' - Contains RexNode expressions representing field references
        // 2. 'aliases' - Contains corresponding alias names for each field
        //
        // Example transformation:
        // JSON: { "select": { "id": true, "accountNumber": true } }
        // 
        // Results in:
        // projects[0] = RexInputRef(Account.id, index=0)     → aliases[0] = "Account_id"  
        // projects[1] = RexInputRef(Account.accountNumber, index=2) → aliases[1] = "Account_accountNumber"
        //
        // Final SQL: SELECT "Account"."id" AS "Account_id", "Account"."accountNumber" AS "Account_accountNumber"
        // =============================================================================
        
        // List to store RexNode expressions representing the SELECT clause projections
        // Each RexNode corresponds to a field/column that will be selected in the final SQL
        // For example: rexBuilder.makeInputRef(fieldType, fieldIndex) for "Account.id"
        List<RexNode> projects = new ArrayList<>();
        
        // List to store the corresponding alias names for each projection
        // These aliases will appear in the SQL AS clauses (e.g., "Account_id", "primaryOwner_firstName")
        // Must maintain same order as 'projects' list for proper field-to-alias mapping
        List<String> aliases = new ArrayList<>();
        
        buildProjections(builder, mainTableNode, mainTableName, projects, aliases);
        
        // Apply the projections to create the SELECT clause in the relational algebra
        if (!projects.isEmpty()) {
            // The builder.project() method creates a LogicalProject node in the RelNode tree
            // This represents the SELECT clause with field references and their aliases
            // 
            // Example output SQL:
            // SELECT "Account"."id" AS "Account_id", 
            //        "Account"."accountNumber" AS "Account_accountNumber",
            //        "primaryOwner"."firstName" AS "primaryOwner_firstName"
            // FROM ...
            builder.project(projects, aliases);
        }
        
        buildFilters(builder, mainTableNode, aliases);
        
        buildOrderBy(builder, mainTableNode, aliases);
        
        RelNode finalNode = builder.build();
        logger.info("Relational Algebra construction completed");
        return finalNode;
    }
    
    private void buildJoins(RelBuilder builder, JsonNode tableNode, String tableName, String schemaName) {
        if (tableNode.has(SELECT)) {
            JsonNode selectNode = tableNode.get(SELECT);
            Iterator<String> fieldNames = selectNode.fieldNames();
            
            while (fieldNames.hasNext()) {
                String fieldName = fieldNames.next();
                JsonNode fieldNode = selectNode.get(fieldName);
                
                if (fieldNode.isObject() && fieldNode.has(SELECT)) {
                    // Map link names to actual target table names
                    String targetTableName = mapLinkToTargetTable(fieldName);
                    logger.info("Creating JOIN with table: {} -> {}", fieldName, targetTableName);
                    builder.scan(schemaName, targetTableName);
                    
                    RexBuilder rexBuilder = builder.getRexBuilder();
                    String joinFieldName = fieldName + "_id";
                    
                    // Get field indices for JOIN condition
                    // builder.peek(1) = left table (Account), builder.peek(0) = right table (primaryOwner)
                    logger.debug("Looking for join field '{}' in left table. Available fields: {}", 
                               joinFieldName, builder.peek(1).getRowType().getFieldNames());
                    logger.debug("Looking for 'id' field in right table. Available fields: {}", 
                               builder.peek(0).getRowType().getFieldNames());
                    
                    int leftFieldIndex = getFieldIndex(builder.peek(1).getRowType(), joinFieldName);
                    int rightFieldIndex = getFieldIndex(builder.peek(0).getRowType(), "id");
                    
                    if (leftFieldIndex >= 0 && rightFieldIndex >= 0) {
                        RelDataType leftFieldType = builder.peek(1).getRowType().getFieldList().get(leftFieldIndex).getType();
                        RelDataType rightFieldType = builder.peek(0).getRowType().getFieldList().get(rightFieldIndex).getType();
                        
                        // Create JOIN condition: Account.primaryOwnerId = primaryOwner.id
                        // Note: leftFieldIndex references the left table (Account), rightFieldIndex references the right table (primaryOwner)
                        RexNode joinCondition = rexBuilder.makeCall(
                                SqlStdOperatorTable.EQUALS,
                                rexBuilder.makeInputRef(leftFieldType, leftFieldIndex),
                                rexBuilder.makeInputRef(rightFieldType, rightFieldIndex + builder.peek(1).getRowType().getFieldCount())
                        );
                        
                        logger.debug("Creating join condition: {} = {} (left index: {}, right index adjusted: {})", 
                                   joinFieldName, "id", leftFieldIndex, rightFieldIndex + builder.peek(1).getRowType().getFieldCount());
                        
                        builder.join(JoinRelType.INNER, joinCondition);
                    } else {
                        logger.error("Cannot create join condition - field indices not found: {} ({}), id ({})", 
                                   joinFieldName, leftFieldIndex, rightFieldIndex);
                        throw new QueryTranslationException("Cannot create join condition for field: " + joinFieldName);
                    }
                    
                    logger.debug("Recursively building joins for nested table: {} -> {}", fieldName, targetTableName);
                    buildJoins(builder, fieldNode, targetTableName, schemaName);
                }
            }
        }
    }
    
    /**
     * Maps EdgeQL link names to their actual target table names.
     * This handles cases where the JSON uses the link name (e.g., "primaryOwner") 
     * but the actual target table is different (e.g., "Person").
     */
    private String mapLinkToTargetTable(String linkName) {
        // Map common EdgeQL links to their target table names
        switch (linkName) {
            case "primaryOwner":
                return "Person";
            case "secondaryOwners": 
                return "Person";
            case "branch":
                return "Branch";
            case "client":
                return "Client";
            case "custodian":
                return "Custodian";
            // Add more mappings as needed based on your EdgeQL schema
            default:
                // If no specific mapping found, use the link name as-is
                return linkName;
        }
    }
    
    /**
     * Builds the projection list (SELECT clause) by processing JSON select specifications
     * and converting them to Calcite RexNode expressions with corresponding aliases.
     *
     * @param builder    The Calcite RelBuilder for creating relational expressions
     * @param tableNode  JSON node containing the table's select specification
     * @param tableName  Name of the current table being processed (for alias prefixing)
     * @param projects   Output list of RexNode expressions for SELECT clause
     * @param aliases    Output list of alias names corresponding to each projection
     */
    private void buildProjections(RelBuilder builder, JsonNode tableNode, String tableName, 
                                 List<RexNode> projects, List<String> aliases) {
        if (tableNode.has(SELECT)) {
            JsonNode selectNode = tableNode.get(SELECT);
            Iterator<String> fieldNames = selectNode.fieldNames();
            
            // Process each field specified in the JSON select clause
            while (fieldNames.hasNext()) {
                String fieldName = fieldNames.next();
                JsonNode fieldNode = selectNode.get(fieldName);
                
                // Handle simple field selection (e.g., "id": true, "accountNumber": true)
                if (fieldNode.isBoolean() && fieldNode.asBoolean()) {
                    RexBuilder rexBuilder = builder.getRexBuilder();
                    
                    // Find the field's position in the current row type (after any joins)
                    // This accounts for field positions after table joins have been applied
                    // 
                    // IMPORTANT: builder.peek().getRowType() returns the COMPLETE table schema,
                    // not just the selected fields from JSON. This is why you see more fields
                    // than what's in your JSON query - it's the full table definition!
                    //
                    // For example, even if JSON only has: { "select": { "id": true, "accountNumber": true } }
                    // The rowType still contains: [id, id, accountNumber, balance] (4 fields total)
                    // because that's the complete schema definition for the Account table
                    int fieldIndex = getFieldIndex(builder.peek().getRowType(), fieldName);
                    
                    if (fieldIndex >= 0) {
                        // Get the field's data type for type-safe RexNode creation
                        RelDataType fieldType = builder.peek().getRowType().getFieldList().get(fieldIndex).getType();
                        
                        // Create RexInputRef pointing to the field at the specified index
                        // This represents a column reference in the relational algebra
                        // Example: Account.id becomes RexInputRef(INTEGER, index=0)
                        projects.add(rexBuilder.makeInputRef(fieldType, fieldIndex));
                        
                        // Use the column name itself as the alias
                        // Example: "id" instead of "Account_id"
                        String aliasName = fieldName;
                        aliases.add(aliasName);
                        
                        logger.debug("Added projection: {} -> {}", fieldName, aliasName);
                    } else {
                        logger.warn("Skipping field '{}' - not found in row type", fieldName);
                    }
                    
                // Handle nested object selection (represents joins with related tables)
                // Example: "primaryOwner": { "select": { "firstName": true, "lastName": true } }
                } else if (fieldNode.isObject() && fieldNode.has(SELECT)) {
                    // Recursively process nested table projections
                    // This handles joined tables and their field selections
                    buildProjections(builder, fieldNode, fieldName, projects, aliases);
                }
            }
        }
    }
    
    private void buildFilters(RelBuilder builder, JsonNode tableNode, List<String> aliases) {
        if (tableNode.has("filter")) {
            JsonNode filterNode = tableNode.get("filter");
            List<RexNode> conditions = new ArrayList<>();
            RexBuilder rexBuilder = builder.getRexBuilder();
            
            for (JsonNode filter : filterNode) {
                String filterStr = filter.asText();
                RexNode condition = parseFilterCondition(rexBuilder, builder, filterStr, aliases);
                if (condition != null) {
                    conditions.add(condition);
                }
            }
            
            if (!conditions.isEmpty()) {
                RexNode combinedCondition = conditions.size() == 1 ? 
                        conditions.get(0) : 
                        rexBuilder.makeCall(SqlStdOperatorTable.AND, conditions);
                builder.filter(combinedCondition);
            }
        }
    }
    
    private RexNode parseFilterCondition(RexBuilder rexBuilder, RelBuilder builder, String filterStr, List<String> aliases) {
        if (filterStr.contains("==")) {
            String[] parts = filterStr.split("==");
            String field = parts[0].trim();
            String value = parts[1].trim().replace("'", "");
            
            int fieldIndex = getFieldIndexByName(builder.peek().getRowType(), field, aliases);
            if (fieldIndex >= 0) {
                RelDataType fieldType = builder.peek().getRowType().getFieldList().get(fieldIndex).getType();
                logger.debug("Creating equals condition: {} = {}", field, value);
                return rexBuilder.makeCall(
                        SqlStdOperatorTable.EQUALS,
                        rexBuilder.makeInputRef(fieldType, fieldIndex),
                        rexBuilder.makeLiteral(value)
                );
            }
        } else if (filterStr.contains(">=")) {
            String[] parts = filterStr.split(">=");
            String field = parts[0].trim();
            String value = parts[1].trim().replace("'", "");
            
            int fieldIndex = getFieldIndexByName(builder.peek().getRowType(), field, aliases);
            if (fieldIndex >= 0) {
                RelDataType fieldType = builder.peek().getRowType().getFieldList().get(fieldIndex).getType();
                logger.debug("Creating >= condition: {} >= {}", field, value);
                return rexBuilder.makeCall(
                        SqlStdOperatorTable.GREATER_THAN_OR_EQUAL,
                        rexBuilder.makeInputRef(fieldType, fieldIndex),
                        rexBuilder.makeLiteral(new BigDecimal(value), builder.getTypeFactory().createSqlType(SqlTypeName.DECIMAL))
                );
            }
        }
        return null;
    }
    
    private void buildOrderBy(RelBuilder builder, JsonNode tableNode, List<String> aliases) {
        if (tableNode.has("orderBy")) {
            JsonNode orderByNode = tableNode.get("orderBy");
            List<RexNode> sorts = new ArrayList<>();
            RexBuilder rexBuilder = builder.getRexBuilder();
            
            for (JsonNode order : orderByNode) {
                String orderStr = order.asText();
                
                if (orderStr.startsWith("desc(")) {
                    String field = orderStr.substring(5, orderStr.length() - 1);
                    int fieldIndex = getFieldIndexByName(builder.peek().getRowType(), field, aliases);
                    if (fieldIndex >= 0) {
                        RelDataType fieldType = builder.peek().getRowType().getFieldList().get(fieldIndex).getType();
                        logger.debug("Adding DESC sort on field: {}", field);
                        sorts.add(rexBuilder.makeCall(
                                SqlStdOperatorTable.DESC,
                                rexBuilder.makeInputRef(fieldType, fieldIndex)
                        ));
                    }
                } else {
                    int fieldIndex = getFieldIndexByName(builder.peek().getRowType(), orderStr, aliases);
                    if (fieldIndex >= 0) {
                        RelDataType fieldType = builder.peek().getRowType().getFieldList().get(fieldIndex).getType();
                        logger.debug("Adding ASC sort on field: {}", orderStr);
                        sorts.add(rexBuilder.makeInputRef(fieldType, fieldIndex));
                    }
                }
            }
            
            if (!sorts.isEmpty()) {
                builder.sort(sorts);
            }
        }
    }
    
    private int getFieldIndex(RelDataType rowType, String fieldName) {
        logger.trace("Looking for field '{}' in row type with fields: {}", fieldName, 
                    rowType.getFieldNames());
        
        for (int i = 0; i < rowType.getFieldList().size(); i++) {
            if (rowType.getFieldList().get(i).getName().equals(fieldName)) {
                logger.trace("Found field '{}' at index {}", fieldName, i);
                return i;
            }
        }
        
        logger.warn("Field '{}' not found in row type. Available fields: {}", fieldName, 
                   rowType.getFieldNames());
        return -1;
    }
    
    private int getFieldIndexByName(RelDataType rowType, String fieldName, List<String> aliases) {
        logger.trace("Looking for field '{}' in aliases: {}", fieldName, aliases);
        
        // First try exact match in aliases
        int aliasIndex = aliases.indexOf(fieldName);
        if (aliasIndex >= 0) {
            logger.trace("Found field '{}' in aliases at index {}", fieldName, aliasIndex);
            return aliasIndex;
        }
        
        // Try to match with table prefixed aliases (e.g., "accountNumber" should match "Account_accountNumber")
        for (int i = 0; i < aliases.size(); i++) {
            String alias = aliases.get(i);
            if (alias.endsWith("_" + fieldName)) {
                logger.trace("Found field '{}' in aliases with prefix at index {}", fieldName, i);
                return i;
            }
        }
        
        // Fallback to row type field lookup
        int index = getFieldIndex(rowType, fieldName);
        if (index == -1) {
            logger.warn("Field '{}' not found in aliases or row type", fieldName);
        }
        return index;
    }

    /**
     * Converts camelCase field names to snake_case format for database compatibility.
     * Examples: "primaryOwner" -> "primary_owner", "accountNumber" -> "account_number"
     */
    private String convertToSnakeCase(String camelCase) {
        if (camelCase == null || camelCase.isEmpty()) {
            return camelCase;
        }
        
        StringBuilder result = new StringBuilder();
        for (int i = 0; i < camelCase.length(); i++) {
            char c = camelCase.charAt(i);
            if (Character.isUpperCase(c) && i > 0) {
                result.append('_');
                result.append(Character.toLowerCase(c));
            } else {
                result.append(Character.toLowerCase(c));
            }
        }
        return result.toString();
    }
}