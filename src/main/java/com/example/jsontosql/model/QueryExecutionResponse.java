package com.example.jsontosql.model;

import com.fasterxml.jackson.annotation.JsonInclude;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

@JsonInclude(JsonInclude.Include.NON_NULL)
public class QueryExecutionResponse {
    
    private String generatedSql;
    private List<Map<String, Object>> data;
    private QueryMetadata metadata;
    private String error;
    private boolean success;
    private LocalDateTime executedAt;
    
    // Constructors
    public QueryExecutionResponse() {
        this.executedAt = LocalDateTime.now();
    }
    
    public QueryExecutionResponse(String generatedSql, List<Map<String, Object>> data, QueryMetadata metadata) {
        this();
        this.generatedSql = generatedSql;
        this.data = data;
        this.metadata = metadata;
        this.success = true;
    }
    
    public QueryExecutionResponse(String error) {
        this();
        this.error = error;
        this.success = false;
    }
    
    public QueryExecutionResponse(String generatedSql, String error) {
        this();
        this.generatedSql = generatedSql;
        this.error = error;
        this.success = false;
    }
    
    // Getters and setters
    public String getGeneratedSql() {
        return generatedSql;
    }
    
    public void setGeneratedSql(String generatedSql) {
        this.generatedSql = generatedSql;
    }
    
    public List<Map<String, Object>> getData() {
        return data;
    }
    
    public void setData(List<Map<String, Object>> data) {
        this.data = data;
    }
    
    public QueryMetadata getMetadata() {
        return metadata;
    }
    
    public void setMetadata(QueryMetadata metadata) {
        this.metadata = metadata;
    }
    
    public String getError() {
        return error;
    }
    
    public void setError(String error) {
        this.error = error;
    }
    
    public boolean isSuccess() {
        return success;
    }
    
    public void setSuccess(boolean success) {
        this.success = success;
    }
    
    public LocalDateTime getExecutedAt() {
        return executedAt;
    }
    
    public void setExecutedAt(LocalDateTime executedAt) {
        this.executedAt = executedAt;
    }
    
    // Inner class for query metadata
    public static class QueryMetadata {
        private int rowCount;
        private int columnCount;
        private long executionTimeMs;
        private List<ColumnInfo> columns;
        private String database;
        private String schema;
        
        public QueryMetadata() {}
        
        public QueryMetadata(int rowCount, int columnCount, long executionTimeMs) {
            this.rowCount = rowCount;
            this.columnCount = columnCount;
            this.executionTimeMs = executionTimeMs;
        }
        
        // Getters and setters
        public int getRowCount() {
            return rowCount;
        }
        
        public void setRowCount(int rowCount) {
            this.rowCount = rowCount;
        }
        
        public int getColumnCount() {
            return columnCount;
        }
        
        public void setColumnCount(int columnCount) {
            this.columnCount = columnCount;
        }
        
        public long getExecutionTimeMs() {
            return executionTimeMs;
        }
        
        public void setExecutionTimeMs(long executionTimeMs) {
            this.executionTimeMs = executionTimeMs;
        }
        
        public List<ColumnInfo> getColumns() {
            return columns;
        }
        
        public void setColumns(List<ColumnInfo> columns) {
            this.columns = columns;
        }
        
        public String getDatabase() {
            return database;
        }
        
        public void setDatabase(String database) {
            this.database = database;
        }
        
        public String getSchema() {
            return schema;
        }
        
        public void setSchema(String schema) {
            this.schema = schema;
        }
    }
    
    // Inner class for column information
    public static class ColumnInfo {
        private String name;
        private String type;
        private boolean nullable;
        
        public ColumnInfo() {}
        
        public ColumnInfo(String name, String type, boolean nullable) {
            this.name = name;
            this.type = type;
            this.nullable = nullable;
        }
        
        // Getters and setters
        public String getName() {
            return name;
        }
        
        public void setName(String name) {
            this.name = name;
        }
        
        public String getType() {
            return type;
        }
        
        public void setType(String type) {
            this.type = type;
        }
        
        public boolean isNullable() {
            return nullable;
        }
        
        public void setNullable(boolean nullable) {
            this.nullable = nullable;
        }
    }
}