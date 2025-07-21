package com.example.jsontosql.model;

import com.fasterxml.jackson.databind.JsonNode;
import jakarta.validation.constraints.NotNull;

public class QueryRequest {
    
    @NotNull
    private JsonNode query;
    
    private String schema = "public";
    
    public QueryRequest() {}
    
    public QueryRequest(JsonNode query) {
        this.query = query;
    }
    
    public QueryRequest(JsonNode query, String schema) {
        this.query = query;
        this.schema = schema;
    }
    
    public JsonNode getQuery() {
        return query;
    }
    
    public void setQuery(JsonNode query) {
        this.query = query;
    }
    
    public String getSchema() {
        return schema;
    }
    
    public void setSchema(String schema) {
        this.schema = schema;
    }
}