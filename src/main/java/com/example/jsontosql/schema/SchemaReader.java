package com.example.jsontosql.schema;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import org.apache.calcite.schema.impl.AbstractTable;
import org.apache.calcite.sql.type.SqlTypeName;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Schema reader that loads table definitions from a single comprehensive schema.json file.
 * This file contains all entity definitions in a unified format.
 */
@Component
public class SchemaReader {
    
    private static final Logger logger = LoggerFactory.getLogger(SchemaReader.class);
    private final ObjectMapper objectMapper = new ObjectMapper();
    
    // Cache for loaded schemas to avoid repeated file reads and parsing
    private final Map<String, JsonNode> schemaCache = new ConcurrentHashMap<>();
    
    // Cache for the main schema array to avoid repeated parsing
    private ArrayNode mainSchemaArray = null;
    
    /**
     * Creates a Calcite table from unified schema configuration.
     * Supports both EdgeQL and JSON formats with automatic fallback.
     */
    public AbstractTable createTable(String tableName, JsonNode queryNode) {
        return new CustomTable(tableName, queryNode, this);
    }
    
    /**
     * Loads schema configuration from the unified schema.json file.
     * 
     * @param tableName Name of the table to load schema for
     * @return JsonNode containing the schema configuration
     */
    public JsonNode loadTableSchema(String tableName) {
        return schemaCache.computeIfAbsent(tableName, this::loadSchemaFromUnifiedFile);
    }
    
    /**
     * Loads schema from the unified schema.json file.
     */
    private JsonNode loadSchemaFromUnifiedFile(String tableName) {
        try {
            if (mainSchemaArray == null) {
                loadMainSchemaArray();
            }
            
            if (mainSchemaArray != null) {
                // Search for the table definition in the schema array
                for (JsonNode entityNode : mainSchemaArray) {
                    if (entityNode.has("name") && tableName.equals(entityNode.get("name").asText())) {
                        JsonNode convertedSchema = convertToStandardFormat(entityNode, tableName);
                        logger.info("Loaded schema for table '{}' from unified schema.json", tableName);
                        return convertedSchema;
                    }
                }
            }
            
            logger.warn("No schema definition found for table '{}' in schema.json, using minimal schema", tableName);
            return createMinimalSchema(tableName);
            
        } catch (Exception e) {
            logger.error("Error loading schema for table '{}': {}", tableName, e.getMessage());
            return createMinimalSchema(tableName);
        }
    }
    
    /**
     * Loads the main schema array from schema.json file.
     */
    private void loadMainSchemaArray() {
        try {
            ClassPathResource schemaResource = new ClassPathResource("schemas/schema.json");
            if (schemaResource.exists()) {
                try (InputStream inputStream = schemaResource.getInputStream()) {
                    JsonNode rootNode = objectMapper.readTree(inputStream);
                    if (rootNode.isArray()) {
                        mainSchemaArray = (ArrayNode) rootNode;
                        logger.info("Loaded unified schema.json with {} entities", mainSchemaArray.size());
                    } else {
                        logger.error("Expected schema.json to contain an array of entities");
                    }
                }
            } else {
                logger.error("schema.json file not found in schemas/ directory");
            }
        } catch (IOException e) {
            logger.error("Error loading schema.json: {}", e.getMessage());
        }
    }
    
    /**
     * Converts entity definition from unified schema format to our standard format.
     */
    private JsonNode convertToStandardFormat(JsonNode entityNode, String tableName) {
        ObjectNode standardSchema = objectMapper.createObjectNode();
        standardSchema.put("tableName", tableName);
        standardSchema.put("description", entityNode.path("description").asText(tableName));
        standardSchema.put("version", "1.0");
        standardSchema.put("sourceFormat", "UnifiedSchema");
        
        ObjectNode fieldsNode = objectMapper.createObjectNode();
        
        // Add implicit ID field (all entities have an ID)
        ObjectNode idField = objectMapper.createObjectNode();
        idField.put("type", "VARCHAR"); // UUIDs are typically VARCHAR
        idField.put("nullable", false);
        idField.put("primaryKey", true);
        idField.put("description", "Unique entity identifier");
        fieldsNode.set("id", idField);
        
        // Process fields from the entity definition
        if (entityNode.has("fields") && entityNode.get("fields").isArray()) {
            for (JsonNode fieldNode : entityNode.get("fields")) {
                String fieldName = fieldNode.path("name").asText();
                if (!fieldName.isEmpty() && !"id".equals(fieldName)) { // Skip duplicate id field
                    ObjectNode convertedField = convertFieldToStandardFormat(fieldNode);
                    
                    // If this is a link field, also create the foreign key field
                    if (fieldNode.has("Type") && fieldNode.get("Type").has("Link")) {
                        String linkForeignKeyField = fieldName + "_id";
                        ObjectNode foreignKeyField = objectMapper.createObjectNode();
                        foreignKeyField.put("type", "VARCHAR");
                        foreignKeyField.put("nullable", true);
                        foreignKeyField.put("description", "Foreign key for " + fieldName + " relationship");
                        
                        // Add foreign key reference information
                        JsonNode linkNode = fieldNode.get("Type").get("Link");
                        if (linkNode.has("name")) {
                            ObjectNode foreignKey = objectMapper.createObjectNode();
                            foreignKey.put("table", linkNode.get("name").asText());
                            foreignKey.put("field", "id");
                            foreignKeyField.set("foreignKey", foreignKey);
                        }
                        
                        fieldsNode.set(linkForeignKeyField, foreignKeyField);
                        logger.debug("Added foreign key field '{}' for link '{}'", linkForeignKeyField, fieldName);
                    }
                    
                    fieldsNode.set(fieldName, convertedField);
                }
            }
        }
        
        standardSchema.set("fields", fieldsNode);
        return standardSchema;
    }
    
    /**
     * Converts a field definition from unified schema format to standard format.
     */
    private ObjectNode convertFieldToStandardFormat(JsonNode fieldNode) {
        ObjectNode standardField = objectMapper.createObjectNode();
        
        if (fieldNode.has("Type")) {
            JsonNode typeNode = fieldNode.get("Type");
            
            if (typeNode.has("Property")) {
                // Handle property types
                JsonNode propertyNode = typeNode.get("Property");
                if (propertyNode.has("type") && propertyNode.get("type").has("name")) {
                    String typeName = propertyNode.get("type").get("name").asText();
                    String sqlType = convertUnifiedTypeToSQL(typeName);
                    standardField.put("type", sqlType);
                }
                
                // Handle constraints
                if (propertyNode.has("constraints")) {
                    parseUnifiedConstraints(propertyNode.get("constraints"), standardField);
                }
            } else if (typeNode.has("Link")) {
                // Handle link types (foreign keys)
                JsonNode linkNode = typeNode.get("Link");
                standardField.put("type", "VARCHAR"); // Links are typically UUID references
                standardField.put("nullable", true);
                
                if (linkNode.has("name")) {
                    ObjectNode foreignKey = objectMapper.createObjectNode();
                    foreignKey.put("table", linkNode.get("name").asText());
                    foreignKey.put("field", "id");
                    standardField.set("foreignKey", foreignKey);
                }
                
                standardField.put("description", "Foreign key reference");
            }
        }
        
        // Default values if not set
        if (!standardField.has("type")) {
            standardField.put("type", "VARCHAR");
        }
        if (!standardField.has("nullable")) {
            standardField.put("nullable", true);
        }
        
        return standardField;
    }
    
    /**
     * Converts unified schema types to SQL types.
     */
    private String convertUnifiedTypeToSQL(String unifiedType) {
        return switch (unifiedType.toLowerCase()) {
            case "std::str" -> "VARCHAR";
            case "std::uuid" -> "VARCHAR";
            case "std::int16" -> "SMALLINT";
            case "std::int32" -> "INTEGER";
            case "std::int64" -> "BIGINT";
            case "std::float32" -> "REAL";
            case "std::float64" -> "DOUBLE";
            case "std::bool" -> "BOOLEAN";
            case "std::datetime" -> "TIMESTAMP";
            case "std::date" -> "DATE";
            case "std::time" -> "TIME";
            case "std::decimal" -> "DECIMAL";
            case "std::bytes" -> "BINARY";
            case "std::json" -> "VARCHAR";
            default -> {
                logger.debug("Unknown unified type '{}', defaulting to VARCHAR", unifiedType);
                yield "VARCHAR";
            }
        };
    }
    
    /**
     * Parses constraints from unified schema format.
     */
    private void parseUnifiedConstraints(JsonNode constraintsNode, ObjectNode standardField) {
        if (constraintsNode.isArray()) {
            for (JsonNode constraintNode : constraintsNode) {
                if (constraintNode.has("Constraint")) {
                    JsonNode constraint = constraintNode.get("Constraint");
                    
                    if (constraint.has("MaxLength")) {
                        int maxLength = constraint.get("MaxLength").path("value").asInt(255);
                        standardField.put("length", maxLength);
                    }
                    
                    if (constraint.has("MinLength")) {
                        // If MinLength exists, field is typically not nullable
                        standardField.put("nullable", false);
                    }
                    
                    if (constraint.has("Exclusive")) {
                        standardField.put("unique", true);
                    }
                }
            }
        }
    }
    
    /**
     * Creates a minimal schema when no definition is found.
     */
    private JsonNode createMinimalSchema(String tableName) {
        ObjectNode minimalSchema = objectMapper.createObjectNode();
        minimalSchema.put("tableName", tableName);
        minimalSchema.put("description", "Minimal schema for " + tableName);
        minimalSchema.put("version", "1.0");
        
        ObjectNode fieldsNode = objectMapper.createObjectNode();
        ObjectNode idField = objectMapper.createObjectNode();
        idField.put("type", "VARCHAR");
        idField.put("nullable", false);
        idField.put("primaryKey", true);
        idField.put("description", "Unique identifier");
        fieldsNode.set("id", idField);
        
        minimalSchema.set("fields", fieldsNode);
        return minimalSchema;
    }
    
    
    /**
     * Converts JSON field definition to Calcite SqlTypeName.
     * This method delegates to the existing logic for compatibility.
     */
    public SqlTypeName parseFieldType(JsonNode fieldDef) {
        String typeStr = fieldDef.path("type").asText("VARCHAR").toUpperCase();
        
        return switch (typeStr) {
            case "INTEGER", "INT" -> SqlTypeName.INTEGER;
            case "BIGINT", "LONG" -> SqlTypeName.BIGINT;
            case "SMALLINT", "SHORT" -> SqlTypeName.SMALLINT;
            case "DECIMAL", "NUMERIC" -> SqlTypeName.DECIMAL;
            case "DOUBLE", "FLOAT64" -> SqlTypeName.DOUBLE;
            case "REAL", "FLOAT32" -> SqlTypeName.REAL;
            case "BOOLEAN", "BOOL" -> SqlTypeName.BOOLEAN;
            case "DATE" -> SqlTypeName.DATE;
            case "TIME" -> SqlTypeName.TIME;
            case "TIMESTAMP", "DATETIME" -> SqlTypeName.TIMESTAMP;
            case "VARCHAR", "STRING", "TEXT" -> SqlTypeName.VARCHAR;
            case "CHAR" -> SqlTypeName.CHAR;
            case "BINARY" -> SqlTypeName.BINARY;
            case "VARBINARY" -> SqlTypeName.VARBINARY;
            default -> {
                logger.warn("Unknown field type '{}', defaulting to VARCHAR", typeStr);
                yield SqlTypeName.VARCHAR;
            }
        };
    }
}