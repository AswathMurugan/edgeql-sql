package com.example.jsontosql;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureWebMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest
@AutoConfigureWebMvc
class JsonToSqlIntegrationTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private ObjectMapper objectMapper;

    @Test
    void testCompleteJsonToSqlTranslationFlow() throws Exception {
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
              "dialect": "POSTGRESQL"
            }
            """;

        mockMvc.perform(post("/api/v1/translate")
                .contentType(MediaType.APPLICATION_JSON)
                .content(jsonQuery))
                .andDo(print())
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true))
                .andExpect(jsonPath("$.sql").exists())
                .andExpect(jsonPath("$.sql").isNotEmpty())
                .andExpect(jsonPath("$.dialect").value("POSTGRESQL"))
                .andExpect(jsonPath("$.sql").value(org.hamcrest.Matchers.containsString("SELECT")))
                .andExpect(jsonPath("$.sql").value(org.hamcrest.Matchers.containsString("JOIN")))
                .andExpect(jsonPath("$.sql").value(org.hamcrest.Matchers.containsString("WHERE")))
                .andExpect(jsonPath("$.sql").value(org.hamcrest.Matchers.containsString("ORDER BY")));
    }

    @Test
    void testSimpleQueryTranslation() throws Exception {
        String jsonQuery = """
            {
              "query": {
                "User": {
                  "select": {
                    "id": true,
                    "name": true,
                    "email": true
                  }
                }
              },
              "dialect": "MYSQL"
            }
            """;

        mockMvc.perform(post("/api/v1/translate")
                .contentType(MediaType.APPLICATION_JSON)
                .content(jsonQuery))
                .andDo(print())
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true))
                .andExpect(jsonPath("$.sql").exists())
                .andExpect(jsonPath("$.dialect").value("MYSQL"))
                .andExpect(jsonPath("$.sql").value(org.hamcrest.Matchers.containsString("SELECT")))
                .andExpect(jsonPath("$.sql").value(org.hamcrest.Matchers.containsString("User")));
    }

    @Test
    void testQueryWithFiltersOnly() throws Exception {
        String jsonQuery = """
            {
              "query": {
                "Product": {
                  "select": {
                    "id": true,
                    "name": true,
                    "price": true
                  },
                  "filter": ["price >= 100", "name == 'Laptop'"]
                }
              },
              "dialect": "SNOWFLAKE"
            }
            """;

        mockMvc.perform(post("/api/v1/translate")
                .contentType(MediaType.APPLICATION_JSON)
                .content(jsonQuery))
                .andDo(print())
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true))
                .andExpect(jsonPath("$.sql").exists())
                .andExpect(jsonPath("$.dialect").value("SNOWFLAKE"))
                .andExpect(jsonPath("$.sql").value(org.hamcrest.Matchers.containsString("SELECT")))
                .andExpect(jsonPath("$.sql").value(org.hamcrest.Matchers.containsString("WHERE")))
                .andExpect(jsonPath("$.sql").value(org.hamcrest.Matchers.containsString("price")))
                .andExpect(jsonPath("$.sql").value(org.hamcrest.Matchers.containsString("100")))
                .andExpect(jsonPath("$.sql").value(org.hamcrest.Matchers.containsString("Laptop")));
    }

    @Test
    void testQueryWithOrderByOnly() throws Exception {
        String jsonQuery = """
            {
              "query": {
                "Order": {
                  "select": {
                    "id": true,
                    "orderDate": true,
                    "total": true
                  },
                  "orderBy": ["desc(orderDate)", "total"]
                }
              }
            }
            """;

        mockMvc.perform(post("/api/v1/translate")
                .contentType(MediaType.APPLICATION_JSON)
                .content(jsonQuery))
                .andDo(print())
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true))
                .andExpect(jsonPath("$.sql").exists())
                .andExpect(jsonPath("$.dialect").value("POSTGRESQL"))
                .andExpect(jsonPath("$.sql").value(org.hamcrest.Matchers.containsString("SELECT")))
                .andExpect(jsonPath("$.sql").value(org.hamcrest.Matchers.containsString("ORDER BY")))
                .andExpect(jsonPath("$.sql").value(org.hamcrest.Matchers.containsString("DESC")));
    }

    @Test
    void testMultiLevelJoinQuery() throws Exception {
        String jsonQuery = """
            {
              "query": {
                "Customer": {
                  "select": {
                    "id": true,
                    "name": true,
                    "orders": {
                      "select": {
                        "id": true,
                        "orderDate": true,
                        "items": {
                          "select": {
                            "productName": true,
                            "quantity": true
                          }
                        }
                      }
                    }
                  }
                }
              },
              "dialect": "POSTGRESQL"
            }
            """;

        mockMvc.perform(post("/api/v1/translate")
                .contentType(MediaType.APPLICATION_JSON)
                .content(jsonQuery))
                .andDo(print())
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true))
                .andExpect(jsonPath("$.sql").exists())
                .andExpect(jsonPath("$.dialect").value("POSTGRESQL"))
                .andExpect(jsonPath("$.sql").value(org.hamcrest.Matchers.containsString("SELECT")))
                .andExpect(jsonPath("$.sql").value(org.hamcrest.Matchers.containsString("JOIN")))
                .andExpect(jsonPath("$.sql").value(org.hamcrest.Matchers.containsString("Customer")))
                .andExpect(jsonPath("$.sql").value(org.hamcrest.Matchers.containsString("orders")))
                .andExpect(jsonPath("$.sql").value(org.hamcrest.Matchers.containsString("items")));
    }

    @Test
    void testHealthEndpoint() throws Exception {
        mockMvc.perform(get("/api/v1/translate/health"))
                .andDo(print())
                .andExpect(status().isOk())
                .andExpect(content().string("JSON to SQL Translator Service is running"));
    }

    @Test
    void testInvalidJsonQueryStructure() throws Exception {
        String invalidJson = """
            {
              "query": {
                "invalidStructure": "notAnObject"
              },
              "dialect": "POSTGRESQL"
            }
            """;

        mockMvc.perform(post("/api/v1/translate")
                .contentType(MediaType.APPLICATION_JSON)
                .content(invalidJson))
                .andDo(print())
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.success").value(false))
                .andExpect(jsonPath("$.error").exists());
    }

    @Test
    void testMissingQueryField() throws Exception {
        String jsonQuery = """
            {
              "dialect": "POSTGRESQL"
            }
            """;

        mockMvc.perform(post("/api/v1/translate")
                .contentType(MediaType.APPLICATION_JSON)
                .content(jsonQuery))
                .andDo(print())
                .andExpect(status().isBadRequest());
    }

    @Test
    void testEmptyQueryObject() throws Exception {
        String jsonQuery = """
            {
              "query": {},
              "dialect": "POSTGRESQL"
            }
            """;

        mockMvc.perform(post("/api/v1/translate")
                .contentType(MediaType.APPLICATION_JSON)
                .content(jsonQuery))
                .andDo(print())
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.success").value(false))
                .andExpect(jsonPath("$.error").exists());
    }

    @Test
    void testDefaultDialectBehavior() throws Exception {
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

        mockMvc.perform(post("/api/v1/translate")
                .contentType(MediaType.APPLICATION_JSON)
                .content(jsonQuery))
                .andDo(print())
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true))
                .andExpect(jsonPath("$.sql").exists())
                .andExpect(jsonPath("$.dialect").value("POSTGRESQL"));
    }

    @Test
    void testLargeComplexQuery() throws Exception {
        String jsonQuery = """
            {
              "query": {
                "Organization": {
                  "select": {
                    "id": true,
                    "name": true,
                    "departments": {
                      "select": {
                        "id": true,
                        "name": true,
                        "employees": {
                          "select": {
                            "id": true,
                            "firstName": true,
                            "lastName": true,
                            "salary": true,
                            "projects": {
                              "select": {
                                "name": true,
                                "status": true
                              }
                            }
                          }
                        }
                      }
                    }
                  },
                  "filter": ["name == 'TechCorp'"],
                  "orderBy": ["name"]
                }
              },
              "dialect": "POSTGRESQL"
            }
            """;

        mockMvc.perform(post("/api/v1/translate")
                .contentType(MediaType.APPLICATION_JSON)
                .content(jsonQuery))
                .andDo(print())
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true))
                .andExpect(jsonPath("$.sql").exists())
                .andExpect(jsonPath("$.dialect").value("POSTGRESQL"))
                .andExpect(jsonPath("$.sql").value(org.hamcrest.Matchers.containsString("SELECT")))
                .andExpect(jsonPath("$.sql").value(org.hamcrest.Matchers.containsString("JOIN")))
                .andExpect(jsonPath("$.sql").value(org.hamcrest.Matchers.containsString("WHERE")))
                .andExpect(jsonPath("$.sql").value(org.hamcrest.Matchers.containsString("ORDER BY")))
                .andExpect(jsonPath("$.sql").value(org.hamcrest.Matchers.containsString("TechCorp")));
    }
}