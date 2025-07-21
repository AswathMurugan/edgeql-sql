package com.example.jsontosql.exception;

public class QueryTranslationException extends RuntimeException {
    
    public QueryTranslationException(String message) {
        super(message);
    }
    
    public QueryTranslationException(String message, Throwable cause) {
        super(message, cause);
    }
}