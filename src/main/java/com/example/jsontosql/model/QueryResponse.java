package com.example.jsontosql.model;

public class QueryResponse {
    
    private String sql;
    private String dialect;
    private boolean success;
    private String error;
    
    public QueryResponse() {}
    
    public QueryResponse(String sql, String dialect) {
        this.sql = sql;
        this.dialect = dialect;
        this.success = true;
    }
    
    public QueryResponse(String error) {
        this.error = error;
        this.success = false;
    }
    
    public String getSql() {
        return sql;
    }
    
    public void setSql(String sql) {
        this.sql = sql;
    }
    
    public String getDialect() {
        return dialect;
    }
    
    public void setDialect(String dialect) {
        this.dialect = dialect;
    }
    
    public boolean isSuccess() {
        return success;
    }
    
    public void setSuccess(boolean success) {
        this.success = success;
    }
    
    public String getError() {
        return error;
    }
    
    public void setError(String error) {
        this.error = error;
    }
}