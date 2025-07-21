package com.example.jsontosql.schema;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import org.apache.calcite.schema.impl.AbstractTable;
import org.apache.calcite.sql.type.SqlTypeName;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Schema reader that supports both EdgeQL (.txt) and JSON (.json) schema formats.
 * 
 * Loading priority:
 * 1. Try EdgeQL format from schemas/{tableName}.txt or schema_sample.txt
 * 2. Fall back to JSON format from schemas/{tableName}.json  
 * 3. Fall back to schemas/default.json
 * 4. Generate minimal schema dynamically from query
 * 
 * EdgeQL is used by default with JSON as fallback for maximum compatibility.
 */
@Component
public class SchemaReader {
    
    private static final Logger logger = LoggerFactory.getLogger(SchemaReader.class);
    private final ObjectMapper objectMapper = new ObjectMapper();
    
    // Cache for loaded schemas to avoid repeated file reads and parsing
    private final Map<String, JsonNode> schemaCache = new ConcurrentHashMap<>();
    
    // EdgeQL parsing patterns - improved to handle nested braces
    private static final Pattern TYPE_PATTERN = Pattern.compile(
        "type\\s+(\\w+)\\s*\\{", 
        Pattern.DOTALL | Pattern.MULTILINE
    );
    private static final Pattern PROPERTY_PATTERN = Pattern.compile(
        "property\\s+(\\w+):\\s*([^;\\{]+)(?:\\s*\\{([^}]*)\\})?;",
        Pattern.DOTALL
    );
    private static final Pattern LINK_PATTERN = Pattern.compile(
        "(?:multi\\s+)?link\\s+(\\w+):\\s*([^;\\{]+)(?:\\s*\\{([^}]*)\\})?;",
        Pattern.DOTALL
    );
    private static final Pattern CONSTRAINT_PATTERN = Pattern.compile(
        "constraint\\s+std::(\\w+)\\(([^)]+)\\)",
        Pattern.DOTALL
    );
    
    /**
     * Creates a Calcite table from unified schema configuration.
     * Supports both EdgeQL and JSON formats with automatic fallback.
     */
    public AbstractTable createTable(String tableName, JsonNode queryNode) {
        return new CustomTable(tableName, queryNode, this);
    }
    
    /**
     * Loads schema configuration with hybrid format support.
     * 
     * @param tableName Name of the table to load schema for
     * @return JsonNode containing the schema configuration (converted from EdgeQL if needed)
     */
    public JsonNode loadTableSchema(String tableName) {
        return schemaCache.computeIfAbsent(tableName, this::loadSchemaFromFiles);
    }
    
    /**
     * Loads schema from files with format detection and priority handling.
     */
    private JsonNode loadSchemaFromFiles(String tableName) {
        try {
            // PRIORITY 1: Try EdgeQL format - specific table file
            String edgeQLPath = "schemas/" + tableName + ".txt";
            ClassPathResource edgeQLResource = new ClassPathResource(edgeQLPath);
            
            if (edgeQLResource.exists()) {
                JsonNode schema = loadFromEdgeQL(edgeQLResource, tableName);
                if (schema != null) {
                    logger.info("Loaded schema for table '{}' from EdgeQL file: {}", tableName, edgeQLPath);
                    return schema;
                }
            }
            
            // PRIORITY 2: Try EdgeQL format - main schema_sample.txt file
            ClassPathResource mainEdgeQLResource = new ClassPathResource("schemas/schema_sample.txt");
            if (mainEdgeQLResource.exists()) {
                JsonNode schema = loadFromEdgeQL(mainEdgeQLResource, tableName);
                if (schema != null) {
                    logger.info("Loaded schema for table '{}' from main EdgeQL file: schema_sample.txt", tableName);
                    return schema;
                }
            }
            
            // PRIORITY 3: Try JSON format - specific table file
            String jsonPath = "schemas/" + tableName + ".json";
            ClassPathResource jsonResource = new ClassPathResource(jsonPath);
            
            if (jsonResource.exists()) {
                try (InputStream inputStream = jsonResource.getInputStream()) {
                    JsonNode schema = objectMapper.readTree(inputStream);
                    logger.info("Loaded schema for table '{}' from JSON file: {}", tableName, jsonPath);
                    return schema;
                }
            }
            
            // PRIORITY 4: Try JSON format - default fallback
            ClassPathResource defaultJsonResource = new ClassPathResource("schemas/default.json");
            if (defaultJsonResource.exists()) {
                try (InputStream inputStream = defaultJsonResource.getInputStream()) {
                    JsonNode schema = objectMapper.readTree(inputStream);
                    logger.info("Using default JSON schema for table '{}'", tableName);
                    return schema;
                }
            }
            
            // PRIORITY 5: No schema files found
            logger.warn("No schema configuration found for table '{}', using minimal schema", tableName);
            return objectMapper.createObjectNode();
            
        } catch (IOException e) {
            logger.error("Error loading schema for table '{}': {}", tableName, e.getMessage());
            return objectMapper.createObjectNode();
        }
    }
    
    /**
     * Loads and parses EdgeQL schema file, converting to JSON format.
     */
    private JsonNode loadFromEdgeQL(ClassPathResource resource, String tableName) {
        try (InputStream inputStream = resource.getInputStream()) {
            String edgeQLContent = new String(inputStream.readAllBytes(), StandardCharsets.UTF_8);
            return parseEdgeQLToJson(edgeQLContent, tableName);
        } catch (IOException e) {
            logger.error("Error reading EdgeQL file: {}", e.getMessage());
            return null;
        }
    }
    
    /**
     * Parses EdgeQL schema content and converts to JSON format.
     * 
     * @param edgeQLContent Full EdgeQL schema content
     * @param tableName Specific table name to extract
     * @return JsonNode in our standard JSON schema format
     */
    private JsonNode parseEdgeQLToJson(String edgeQLContent, String tableName) {
        try {
            ObjectNode schemaNode = objectMapper.createObjectNode();
            schemaNode.put("tableName", tableName);
            schemaNode.put("description", "Schema converted from EdgeQL format");
            schemaNode.put("version", "1.0");
            schemaNode.put("sourceFormat", "EdgeQL");
            
            ObjectNode fieldsNode = objectMapper.createObjectNode();
            
            // Find the type definition for the requested table using improved parsing
            String typeBody = extractTypeBody(edgeQLContent, tableName);
            
            if (typeBody != null) {
                parseEdgeQLTypeBody(typeBody, fieldsNode);
                logger.debug("Found and parsed EdgeQL type '{}' with {} fields", tableName, fieldsNode.size());
            } else {
                logger.warn("No type definition found for '{}' in EdgeQL schema", tableName);
            }
            
            // Add implicit ID field for EdgeQL types (EdgeDB tables have implicit IDs)
            if (typeBody != null && !fieldsNode.has("id")) {
                logger.debug("Adding implicit ID field for EdgeQL table '{}'", tableName);
                ObjectNode idField = objectMapper.createObjectNode();
                idField.put("type", "INTEGER");
                idField.put("nullable", false);
                idField.put("primaryKey", true);
                idField.put("description", "Implicit EdgeDB ID field");
                fieldsNode.set("id", idField);
            }
            
            // If no fields were found at all, add a basic ID field as fallback
            if (fieldsNode.size() == 0) {
                logger.warn("Adding basic ID field as fallback for table '{}'", tableName);
                ObjectNode idField = objectMapper.createObjectNode();
                idField.put("type", "INTEGER");
                idField.put("nullable", false);
                idField.put("primaryKey", true);
                fieldsNode.set("id", idField);
            }
            
            schemaNode.set("fields", fieldsNode);
            
            logger.debug("Converted EdgeQL type '{}' to JSON schema with {} fields", tableName, fieldsNode.size());
            return schemaNode;
            
        } catch (Exception e) {
            logger.error("Error parsing EdgeQL content for table '{}': {}", tableName, e.getMessage());
            return null;
        }
    }
    
    /**
     * Extracts the body of a specific type definition from EdgeQL content.
     * Handles nested braces correctly by counting brace depth.
     */
    private String extractTypeBody(String edgeQLContent, String typeName) {
        // Find the start of the type definition
        Pattern typeStartPattern = Pattern.compile("type\\s+" + typeName + "\\s*\\{", Pattern.CASE_INSENSITIVE);
        Matcher matcher = typeStartPattern.matcher(edgeQLContent);
        
        if (!matcher.find()) {
            return null;
        }
        
        int startPos = matcher.end() - 1; // Position of the opening brace
        int braceDepth = 0;
        int endPos = startPos;
        
        // Count braces to find the matching closing brace
        for (int i = startPos; i < edgeQLContent.length(); i++) {
            char c = edgeQLContent.charAt(i);
            if (c == '{') {
                braceDepth++;
            } else if (c == '}') {
                braceDepth--;
                if (braceDepth == 0) {
                    endPos = i;
                    break;
                }
            }
        }
        
        if (braceDepth == 0 && endPos > startPos) {
            // Extract the content between the braces (excluding the braces themselves)
            return edgeQLContent.substring(startPos + 1, endPos);
        }
        
        return null;
    }
    
    /**
     * Parses the body of an EdgeQL type definition and extracts field information.
     */
    private void parseEdgeQLTypeBody(String typeBody, ObjectNode fieldsNode) {
        // Parse property definitions
        Matcher propertyMatcher = PROPERTY_PATTERN.matcher(typeBody);
        while (propertyMatcher.find()) {
            String propertyName = propertyMatcher.group(1);
            String propertyType = propertyMatcher.group(2).trim();
            String constraints = propertyMatcher.group(3);
            
            ObjectNode fieldNode = createFieldFromEdgeQLProperty(propertyType, constraints);
            fieldsNode.set(propertyName, fieldNode);
            
            logger.trace("Converted EdgeQL property: {} -> {}", propertyName, propertyType);
        }
        
        // Parse link definitions (relationships)
        Matcher linkMatcher = LINK_PATTERN.matcher(typeBody);
        while (linkMatcher.find()) {
            String linkName = linkMatcher.group(1);
            String linkType = linkMatcher.group(2).trim();
            String constraints = linkMatcher.group(3);
            
            // Convert links to foreign key fields
            ObjectNode fieldNode = createFieldFromEdgeQLLink(linkType, constraints);
            String fieldName = linkName.endsWith("Id") ? linkName : linkName + "Id";
            fieldsNode.set(fieldName, fieldNode);
            
            logger.trace("Converted EdgeQL link: {} -> {} (as {})", linkName, linkType, fieldName);
        }
    }
    
    /**
     * Creates a JSON field definition from EdgeQL property information.
     */
    private ObjectNode createFieldFromEdgeQLProperty(String edgeQLType, String constraints) {
        ObjectNode fieldNode = objectMapper.createObjectNode();
        
        // Convert EdgeQL type to SQL type
        String sqlType = convertEdgeQLTypeToSQL(edgeQLType);
        fieldNode.put("type", sqlType);
        
        // Parse constraints if present
        if (constraints != null && !constraints.trim().isEmpty()) {
            parseConstraintsToJson(constraints, fieldNode);
        }
        
        // Default to nullable unless specified otherwise
        if (!fieldNode.has("nullable")) {
            fieldNode.put("nullable", true);
        }
        
        return fieldNode;
    }
    
    /**
     * Creates a JSON field definition from EdgeQL link information.
     */
    private ObjectNode createFieldFromEdgeQLLink(String linkType, String constraints) {
        ObjectNode fieldNode = objectMapper.createObjectNode();
        
        // Links are typically foreign keys (INTEGER)
        fieldNode.put("type", "INTEGER");
        fieldNode.put("nullable", true);
        
        // Add foreign key reference information
        if (linkType.contains("::")) {
            String[] parts = linkType.split("::");
            if (parts.length == 2) {
                ObjectNode foreignKey = objectMapper.createObjectNode();
                foreignKey.put("table", parts[1]);
                foreignKey.put("field", "id");
                fieldNode.set("foreignKey", foreignKey);
            }
        }
        
        fieldNode.put("description", "Foreign key reference to " + linkType);
        
        return fieldNode;
    }
    
    /**
     * Converts EdgeQL data types to SQL data types.
     */
    private String convertEdgeQLTypeToSQL(String edgeQLType) {
        return switch (edgeQLType.toLowerCase().trim()) {
            case "std::str" -> "VARCHAR";
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
            case "std::uuid" -> "VARCHAR";
            case "std::bytes" -> "BINARY";
            case "std::json" -> "VARCHAR";
            default -> {
                logger.warn("Unknown EdgeQL type '{}', defaulting to VARCHAR", edgeQLType);
                yield "VARCHAR";
            }
        };
    }
    
    /**
     * Parses EdgeQL constraints and converts them to JSON field properties.
     */
    private void parseConstraintsToJson(String constraints, ObjectNode fieldNode) {
        Matcher constraintMatcher = CONSTRAINT_PATTERN.matcher(constraints);
        
        while (constraintMatcher.find()) {
            String constraintType = constraintMatcher.group(1);
            String constraintValue = constraintMatcher.group(2);
            
            switch (constraintType) {
                case "max_len_value" -> {
                    try {
                        int maxLength = Integer.parseInt(constraintValue);
                        fieldNode.put("length", maxLength);
                    } catch (NumberFormatException e) {
                        logger.warn("Invalid max_len_value constraint: {}", constraintValue);
                    }
                }
                case "min_len_value" -> {
                    try {
                        int minLength = Integer.parseInt(constraintValue);
                        if (minLength > 0) {
                            fieldNode.put("nullable", false);
                        }
                    } catch (NumberFormatException e) {
                        logger.warn("Invalid min_len_value constraint: {}", constraintValue);
                    }
                }
                case "max_value" -> {
                    fieldNode.put("maxValue", constraintValue);
                }
                case "min_value" -> {
                    fieldNode.put("minValue", constraintValue);
                }
                case "exclusive" -> {
                    fieldNode.put("unique", true);
                }
                default -> {
                    logger.debug("Unhandled constraint type: {}", constraintType);
                }
            }
        }
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