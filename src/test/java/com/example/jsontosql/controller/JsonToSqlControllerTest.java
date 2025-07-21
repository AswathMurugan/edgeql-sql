package com.example.jsontosql.controller;

import com.example.jsontosql.exception.GlobalExceptionHandler;
import com.example.jsontosql.exception.QueryTranslationException;
import com.example.jsontosql.service.JsonToSqlTranslatorService;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@ExtendWith(MockitoExtension.class)
class JsonToSqlControllerTest {

    @Mock
    private JsonToSqlTranslatorService translatorService;

    @InjectMocks
    private JsonToSqlController controller;

    private MockMvc mockMvc;
    private ObjectMapper objectMapper;

    @BeforeEach
    void setUp() {
        mockMvc = MockMvcBuilders.standaloneSetup(controller)
                .setControllerAdvice(new GlobalExceptionHandler())
                .build();
        objectMapper = new ObjectMapper();
    }

    @Test
    void testTranslateQuerySuccess() throws Exception {
        String jsonQuery = """
            {
              "query": {
                "Account": {
                  "select": {
                    "id": true,
                    "accountNumber": true
                  }
                }
              },
              "dialect": "POSTGRESQL"
            }
            """;

        String expectedSql = "SELECT Account_id, accountNumber FROM Account";
        
        when(translatorService.translateToSql(any(JsonNode.class), eq("POSTGRESQL")))
                .thenReturn(expectedSql);

        mockMvc.perform(post("/api/v1/translate")
                .contentType(MediaType.APPLICATION_JSON)
                .content(jsonQuery))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true))
                .andExpect(jsonPath("$.sql").value(expectedSql))
                .andExpect(jsonPath("$.dialect").value("POSTGRESQL"));
    }

    @Test
    void testTranslateQueryWithDefaultDialect() throws Exception {
        String jsonQuery = """
            {
              "query": {
                "Account": {
                  "select": {
                    "id": true,
                    "accountNumber": true
                  }
                }
              }
            }
            """;

        String expectedSql = "SELECT Account_id, accountNumber FROM Account";
        
        when(translatorService.translateToSql(any(JsonNode.class), eq("POSTGRESQL")))
                .thenReturn(expectedSql);

        mockMvc.perform(post("/api/v1/translate")
                .contentType(MediaType.APPLICATION_JSON)
                .content(jsonQuery))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true))
                .andExpect(jsonPath("$.sql").value(expectedSql))
                .andExpect(jsonPath("$.dialect").value("POSTGRESQL"));
    }

    @Test
    void testTranslateQueryWithTranslationException() throws Exception {
        String jsonQuery = """
            {
              "query": {
                "Account": {
                  "select": {
                    "id": true,
                    "accountNumber": true
                  }
                }
              },
              "dialect": "POSTGRESQL"
            }
            """;

        when(translatorService.translateToSql(any(JsonNode.class), eq("POSTGRESQL")))
                .thenThrow(new QueryTranslationException("Translation failed"));

        mockMvc.perform(post("/api/v1/translate")
                .contentType(MediaType.APPLICATION_JSON)
                .content(jsonQuery))
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.success").value(false))
                .andExpect(jsonPath("$.error").value("Translation failed"));
    }

    @Test
    void testTranslateQueryWithGenericException() throws Exception {
        String jsonQuery = """
            {
              "query": {
                "Account": {
                  "select": {
                    "id": true,
                    "accountNumber": true
                  }
                }
              },
              "dialect": "POSTGRESQL"
            }
            """;

        when(translatorService.translateToSql(any(JsonNode.class), eq("POSTGRESQL")))
                .thenThrow(new RuntimeException("Unexpected error"));

        mockMvc.perform(post("/api/v1/translate")
                .contentType(MediaType.APPLICATION_JSON)
                .content(jsonQuery))
                .andExpect(status().isInternalServerError())
                .andExpect(jsonPath("$.success").value(false))
                .andExpect(jsonPath("$.error").value("An unexpected error occurred: Unexpected error"));
    }

    @Test
    void testTranslateQueryWithInvalidJson() throws Exception {
        String invalidJson = "{ invalid json }";

        mockMvc.perform(post("/api/v1/translate")
                .contentType(MediaType.APPLICATION_JSON)
                .content(invalidJson))
                .andExpect(status().isBadRequest());
    }

    @Test
    void testTranslateQueryWithMissingQuery() throws Exception {
        String jsonQuery = """
            {
              "dialect": "POSTGRESQL"
            }
            """;

        mockMvc.perform(post("/api/v1/translate")
                .contentType(MediaType.APPLICATION_JSON)
                .content(jsonQuery))
                .andExpect(status().isBadRequest());
    }

    @Test
    void testTranslateQueryWithComplexQuery() throws Exception {
        String jsonQuery = """
            {
              "query": {
                "Account": {
                  "select": {
                    "id": true,
                    "accountNumber": true,
                    "balance": true,
                    "primaryOwner": {
                      "select": {
                        "firstName": true,
                        "lastName": true
                      }
                    }
                  },
                  "filter": ["accountNumber == '1234'", "balance >= 10000"],
                  "orderBy": ["desc(accountNumber)", "balance"]
                }
              },
              "dialect": "MYSQL"
            }
            """;

        String expectedSql = "SELECT Account_id, accountNumber, balance, primaryOwner_firstName, primaryOwner_lastName FROM Account INNER JOIN primaryOwner ON Account.primaryOwnerId = primaryOwner.id WHERE accountNumber = '1234' AND balance >= 10000 ORDER BY accountNumber DESC, balance";
        
        when(translatorService.translateToSql(any(JsonNode.class), eq("MYSQL")))
                .thenReturn(expectedSql);

        mockMvc.perform(post("/api/v1/translate")
                .contentType(MediaType.APPLICATION_JSON)
                .content(jsonQuery))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true))
                .andExpect(jsonPath("$.sql").value(expectedSql))
                .andExpect(jsonPath("$.dialect").value("MYSQL"));
    }

    @Test
    void testHealthEndpoint() throws Exception {
        mockMvc.perform(get("/api/v1/translate/health"))
                .andExpect(status().isOk())
                .andExpect(content().string("JSON to SQL Translator Service is running"));
    }

    @Test
    void testTranslateQueryWithDifferentDialects() throws Exception {
        String jsonQuery = """
            {
              "query": {
                "Account": {
                  "select": {
                    "id": true,
                    "accountNumber": true
                  }
                }
              },
              "dialect": "SNOWFLAKE"
            }
            """;

        String expectedSql = "SELECT Account_id, accountNumber FROM Account";
        
        when(translatorService.translateToSql(any(JsonNode.class), eq("SNOWFLAKE")))
                .thenReturn(expectedSql);

        mockMvc.perform(post("/api/v1/translate")
                .contentType(MediaType.APPLICATION_JSON)
                .content(jsonQuery))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true))
                .andExpect(jsonPath("$.sql").value(expectedSql))
                .andExpect(jsonPath("$.dialect").value("SNOWFLAKE"));
    }

    @Test
    void testTranslateQueryWithEmptySelectFields() throws Exception {
        String jsonQuery = """
            {
              "query": {
                "Account": {
                  "select": {}
                }
              },
              "dialect": "POSTGRESQL"
            }
            """;

        String expectedSql = "SELECT * FROM Account";
        
        when(translatorService.translateToSql(any(JsonNode.class), eq("POSTGRESQL")))
                .thenReturn(expectedSql);

        mockMvc.perform(post("/api/v1/translate")
                .contentType(MediaType.APPLICATION_JSON)
                .content(jsonQuery))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true))
                .andExpect(jsonPath("$.sql").value(expectedSql))
                .andExpect(jsonPath("$.dialect").value("POSTGRESQL"));
    }

    @Test
    void testTranslateQueryWithOnlyFilters() throws Exception {
        String jsonQuery = """
            {
              "query": {
                "Account": {
                  "filter": ["id == 1", "accountNumber == 'ABC123'"]
                }
              },
              "dialect": "POSTGRESQL"
            }
            """;

        String expectedSql = "SELECT * FROM Account WHERE id = 1 AND accountNumber = 'ABC123'";
        
        when(translatorService.translateToSql(any(JsonNode.class), eq("POSTGRESQL")))
                .thenReturn(expectedSql);

        mockMvc.perform(post("/api/v1/translate")
                .contentType(MediaType.APPLICATION_JSON)
                .content(jsonQuery))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true))
                .andExpect(jsonPath("$.sql").value(expectedSql))
                .andExpect(jsonPath("$.dialect").value("POSTGRESQL"));
    }
}