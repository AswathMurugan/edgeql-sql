package com.example.jsontosql.schema;

import com.fasterxml.jackson.databind.JsonNode;
import org.apache.calcite.rel.type.RelDataType;
import org.apache.calcite.rel.type.RelDataTypeFactory;
import org.apache.calcite.schema.impl.AbstractTable;
import org.apache.calcite.sql.type.SqlTypeName;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Iterator;
import java.util.Map;

/**
 * Calcite table implementation that uses schema configuration.
 * 
 * This class extends AbstractTable and provides schema information by loading
 * table definitions from EdgeQL (.txt) or JSON (.json) files through SchemaReader.
 */
public class CustomTable extends AbstractTable {
    
    private static final Logger logger = LoggerFactory.getLogger(CustomTable.class);
    
    private final String tableName;
    private final JsonNode queryNode;
    private final SchemaReader schemaReader;
    
    public CustomTable(String tableName, JsonNode queryNode, SchemaReader schemaReader) {
        this.tableName = tableName;
        this.queryNode = queryNode;
        this.schemaReader = schemaReader;
    }
    
    @Override
    public RelDataType getRowType(RelDataTypeFactory typeFactory) {
        RelDataTypeFactory.Builder builder = typeFactory.builder();
        
        // Load schema configuration from JSON
        JsonNode schema = schemaReader.loadTableSchema(tableName);
        
        if (schema.has("fields")) {
            // Build schema from JSON configuration
            buildSchemaFromJson(builder, schema.get("fields"), typeFactory);
        } else {
            // Fall back to dynamic schema generation from query
            buildSchemaFromQuery(builder, queryNode);
        }
        
        RelDataType rowType = builder.build();
        logger.debug("Created schema for table '{}' with {} fields: {}", 
                    tableName, rowType.getFieldCount(), rowType.getFieldNames());
        
        return rowType;
    }
    
    /**
     * Builds table schema from JSON field definitions.
     */
    private void buildSchemaFromJson(RelDataTypeFactory.Builder builder, JsonNode fields, RelDataTypeFactory typeFactory) {
        Iterator<Map.Entry<String, JsonNode>> fieldIterator = fields.fields();
        
        while (fieldIterator.hasNext()) {
            Map.Entry<String, JsonNode> field = fieldIterator.next();
            String fieldName = field.getKey();
            JsonNode fieldDef = field.getValue();
            
            SqlTypeName sqlType = schemaReader.parseFieldType(fieldDef);
            
            // Handle nullable fields
            boolean nullable = fieldDef.path("nullable").asBoolean(true);
            
            // Create RelDataType based on field definition
            RelDataType relDataType;
            
            // Handle field length/precision for VARCHAR and DECIMAL
            if (sqlType == SqlTypeName.VARCHAR && fieldDef.has("length")) {
                int length = fieldDef.get("length").asInt();
                relDataType = typeFactory.createSqlType(sqlType, length);
            } else if (sqlType == SqlTypeName.DECIMAL && fieldDef.has("precision")) {
                int precision = fieldDef.get("precision").asInt();
                int scale = fieldDef.path("scale").asInt(0);
                relDataType = typeFactory.createSqlType(sqlType, precision, scale);
            } else {
                relDataType = typeFactory.createSqlType(sqlType);
            }
            
            // Apply nullable constraint if specified
            if (!nullable) {
                relDataType = typeFactory.createTypeWithNullability(relDataType, false);
            }
            
            builder.add(fieldName, relDataType);
            
            logger.trace("Added field from JSON config: {} ({}, nullable: {})", fieldName, sqlType, nullable);
        }
    }
    
    /**
     * Falls back to dynamic schema generation when no JSON config is available.
     */
    private void buildSchemaFromQuery(RelDataTypeFactory.Builder builder, JsonNode queryNode) {
        // Add basic id field
        builder.add("id", SqlTypeName.INTEGER);
        
        // Add fields from select clause if available
        if (queryNode.has("select")) {
            JsonNode selectNode = queryNode.get("select");
            Iterator<String> fieldNames = selectNode.fieldNames();
            
            while (fieldNames.hasNext()) {
                String fieldName = fieldNames.next();
                JsonNode fieldNode = selectNode.get(fieldName);
                
                if (fieldNode.isBoolean() && fieldNode.asBoolean()) {
                    SqlTypeName inferredType = inferTypeFromName(fieldName);
                    builder.add(fieldName, inferredType);
                    logger.trace("Added dynamic field: {} ({})", fieldName, inferredType);
                }
            }
        }
        
        logger.info("Generated dynamic schema for table '{}' from query", tableName);
    }
    
    /**
     * Simple type inference based on field name patterns.
     */
    private SqlTypeName inferTypeFromName(String fieldName) {
        String lower = fieldName.toLowerCase();
        
        if (lower.contains("id") || lower.contains("count")) {
            return SqlTypeName.INTEGER;
        } else if (lower.contains("balance") || lower.contains("amount") || lower.contains("price")) {
            return SqlTypeName.DECIMAL;
        } else if (lower.contains("date") || lower.contains("time")) {
            return SqlTypeName.TIMESTAMP;
        } else if (lower.contains("active") || lower.contains("enabled")) {
            return SqlTypeName.BOOLEAN;
        } else {
            return SqlTypeName.VARCHAR;
        }
    }
}