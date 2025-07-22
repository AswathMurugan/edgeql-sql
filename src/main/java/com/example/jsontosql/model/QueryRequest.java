package com.example.jsontosql.model;

import com.fasterxml.jackson.databind.JsonNode;
import jakarta.validation.constraints.NotNull;

public class QueryRequest {
    
    @NotNull
    private JsonNode query;
    
    public QueryRequest() {}
    
    public QueryRequest(JsonNode query) {
        this.query = query;
    }
    
    public JsonNode getQuery() {
        return query;
    }
    
    public void setQuery(JsonNode query) {
        this.query = query;
    }
}