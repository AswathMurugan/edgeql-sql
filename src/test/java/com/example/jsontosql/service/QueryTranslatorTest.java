package com.example.jsontosql.service;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

class QueryTranslatorTest {

    private QueryTranslator queryTranslator;

    @BeforeEach
    void setUp() {
        queryTranslator = new QueryTranslator();
    }

    @Test
    void testTranslateQuery() throws Exception {
        String sql = queryTranslator.translateQuery();
        
        assertNotNull(sql);
        assertTrue(sql.contains("SELECT"));
        assertTrue(sql.contains("Account"));
        assertTrue(sql.contains("primaryOwner"));
        assertTrue(sql.contains("JOIN"));
        assertTrue(sql.contains("WHERE"));
        assertTrue(sql.contains("ORDER BY"));
        
        System.out.println("Generated SQL:");
        System.out.println(sql);
    }
}