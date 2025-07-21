package com.example.jsontosql.controller;

import com.example.jsontosql.exception.QueryTranslationException;
import com.example.jsontosql.model.QueryRequest;
import com.example.jsontosql.model.QueryResponse;
import com.example.jsontosql.service.JsonToSqlTranslatorService;
import com.example.jsontosql.service.QueryTranslator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import jakarta.validation.Valid;

@RestController
@RequestMapping("/api/v1/translate")
@CrossOrigin(origins = "*")
public class JsonToSqlController {

    @Autowired
    private JsonToSqlTranslatorService translatorService;
    
    @Autowired
    private QueryTranslator queryTranslator;

    @PostMapping
    public ResponseEntity<QueryResponse> translateQuery(@Valid @RequestBody QueryRequest request) {
        try {
            String sql = translatorService.translateToSql(request.getQuery(), request.getSchema());
            QueryResponse response = new QueryResponse(sql, "POSTGRESQL");
            return ResponseEntity.ok(response);
        } catch (QueryTranslationException e) {
            QueryResponse response = new QueryResponse(e.getMessage());
            return ResponseEntity.badRequest().body(response);
        } catch (Exception e) {
            QueryResponse response = new QueryResponse("An unexpected error occurred: " + e.getMessage());
            return ResponseEntity.internalServerError().body(response);
        }
    }

    @GetMapping("/health")
    public ResponseEntity<String> health() {
        return ResponseEntity.ok("JSON to SQL Translator Service is running");
    }
    
    @GetMapping("/sample")
    public ResponseEntity<QueryResponse> translateSampleQuery() {
        try {
            String sql = queryTranslator.translateQuery();
            QueryResponse response = new QueryResponse(sql, "SNOWFLAKE");
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            QueryResponse response = new QueryResponse("Failed to translate sample query: " + e.getMessage());
            return ResponseEntity.internalServerError().body(response);
        }
    }
}