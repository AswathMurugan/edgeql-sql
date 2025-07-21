package com.example.jsontosql.service;

import com.example.jsontosql.exception.QueryTranslationException;
import com.example.jsontosql.schema.SchemaReader;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.test.context.junit.jupiter.SpringJUnitConfig;

import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

@ExtendWith(MockitoExtension.class)
@SpringJUnitConfig
class JsonToSqlTranslatorServiceTest {

    private JsonToSqlTranslatorService translatorService;
    private ObjectMapper objectMapper;
    private SchemaReader schemaReader;

    @BeforeEach
    void setUp() {
        schemaReader = new SchemaReader();
        translatorService = new JsonToSqlTranslatorService(schemaReader);
        objectMapper = new ObjectMapper();
    }

    @Test
    void testSimpleSelectQuery() throws Exception {
        String jsonQuery = """
            {
              "Account": {
                "select": {
                  "id": true,
                  "accountNumber": true
                }
              }
            }
            """;

        JsonNode queryNode = objectMapper.readTree(jsonQuery);
        String sql = translatorService.translateToSql(queryNode, "POSTGRESQL");

        assertNotNull(sql);
        assertTrue(sql.contains("SELECT"));
        assertTrue(sql.contains("Account"));
        assertTrue(sql.contains("id") || sql.contains("Account_id"));
        assertTrue(sql.contains("accountNumber"));
    }

    @Test
    void testSelectWithJoinQuery() throws Exception {
        String jsonQuery = """
            {
              "Account": {
                "select": {
                  "id": true,
                  "accountNumber": true,
                  "primaryOwner": {
                    "select": {
                      "firstName": true,
                      "lastName": true
                    }
                  }
                }
              }
            }
            """;

        JsonNode queryNode = objectMapper.readTree(jsonQuery);
        String sql = translatorService.translateToSql(queryNode, "POSTGRESQL");

        assertNotNull(sql);
        assertTrue(sql.contains("SELECT"));
        assertTrue(sql.contains("JOIN") || sql.contains("INNER JOIN"));
        assertTrue(sql.contains("Account"));
        assertTrue(sql.contains("primaryOwner"));
        assertTrue(sql.contains("firstName") || sql.contains("primaryOwner_firstName"));
        assertTrue(sql.contains("lastName") || sql.contains("primaryOwner_lastName"));
    }

    @Test
    void testSelectWithFilterQuery() throws Exception {
        String jsonQuery = """
            {
              "Account": {
                "select": {
                  "id": true,
                  "accountNumber": true,
                  "balance": true
                },
                "filter": ["accountNumber == '1234'"]
              }
            }
            """;

        JsonNode queryNode = objectMapper.readTree(jsonQuery);
        String sql = translatorService.translateToSql(queryNode, "POSTGRESQL");

        assertNotNull(sql);
        assertTrue(sql.contains("SELECT"));
        assertTrue(sql.contains("WHERE"));
        assertTrue(sql.contains("accountNumber"));
        assertTrue(sql.contains("1234"));
        assertTrue(sql.contains("="));
    }

    @Test
    void testSelectWithMultipleFilters() throws Exception {
        String jsonQuery = """
            {
              "Account": {
                "select": {
                  "id": true,
                  "accountNumber": true,
                  "balance": true
                },
                "filter": ["accountNumber == '1234'", "balance >= 10000"]
              }
            }
            """;

        JsonNode queryNode = objectMapper.readTree(jsonQuery);
        String sql = translatorService.translateToSql(queryNode, "POSTGRESQL");

        assertNotNull(sql);
        assertTrue(sql.contains("SELECT"));
        assertTrue(sql.contains("WHERE"));
        assertTrue(sql.contains("accountNumber"));
        assertTrue(sql.contains("balance"));
        assertTrue(sql.contains("1234"));
        assertTrue(sql.contains("10000"));
        assertTrue(sql.contains("AND"));
    }

    @Test
    void testSelectWithOrderBy() throws Exception {
        String jsonQuery = """
            {
              "Account": {
                "select": {
                  "id": true,
                  "accountNumber": true,
                  "balance": true
                },
                "orderBy": ["accountNumber", "desc(balance)"]
              }
            }
            """;

        JsonNode queryNode = objectMapper.readTree(jsonQuery);
        String sql = translatorService.translateToSql(queryNode, "POSTGRESQL");

        assertNotNull(sql);
        assertTrue(sql.contains("SELECT"));
        assertTrue(sql.contains("ORDER BY"));
        assertTrue(sql.contains("accountNumber"));
        assertTrue(sql.contains("balance"));
        assertTrue(sql.contains("DESC"));
    }

    @Test
    void testComplexQueryWithJoinFilterAndOrderBy() throws Exception {
        String jsonQuery = """
            {
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
            }
            """;

        JsonNode queryNode = objectMapper.readTree(jsonQuery);
        String sql = translatorService.translateToSql(queryNode, "POSTGRESQL");

        assertNotNull(sql);
        assertTrue(sql.contains("SELECT"));
        assertTrue(sql.contains("JOIN") || sql.contains("INNER JOIN"));
        assertTrue(sql.contains("WHERE"));
        assertTrue(sql.contains("ORDER BY"));
        assertTrue(sql.contains("Account"));
        assertTrue(sql.contains("primaryOwner"));
        assertTrue(sql.contains("accountNumber"));
        assertTrue(sql.contains("balance"));
        assertTrue(sql.contains("firstName") || sql.contains("primaryOwner_firstName"));
        assertTrue(sql.contains("lastName") || sql.contains("primaryOwner_lastName"));
        assertTrue(sql.contains("1234"));
        assertTrue(sql.contains("10000"));
        assertTrue(sql.contains("DESC"));
    }

    @Test
    void testMySQLDialect() throws Exception {
        String jsonQuery = """
            {
              "Account": {
                "select": {
                  "id": true,
                  "accountNumber": true
                }
              }
            }
            """;

        JsonNode queryNode = objectMapper.readTree(jsonQuery);
        String sql = translatorService.translateToSql(queryNode, "MYSQL");

        assertNotNull(sql);
        assertTrue(sql.contains("SELECT"));
        assertTrue(sql.contains("Account"));
    }

    @Test
    void testSnowflakeDialect() throws Exception {
        String jsonQuery = """
            {
              "Account": {
                "select": {
                  "id": true,
                  "accountNumber": true
                }
              }
            }
            """;

        JsonNode queryNode = objectMapper.readTree(jsonQuery);
        String sql = translatorService.translateToSql(queryNode, "SNOWFLAKE");

        assertNotNull(sql);
        assertTrue(sql.contains("SELECT"));
        assertTrue(sql.contains("Account"));
    }

    @Test
    void testDefaultDialect() throws Exception {
        String jsonQuery = """
            {
              "Account": {
                "select": {
                  "id": true,
                  "accountNumber": true
                }
              }
            }
            """;

        JsonNode queryNode = objectMapper.readTree(jsonQuery);
        String sql = translatorService.translateToSql(queryNode, "UNKNOWN");

        assertNotNull(sql);
        assertTrue(sql.contains("SELECT"));
        assertTrue(sql.contains("Account"));
    }

    @Test
    void testEmptySelectQuery() throws Exception {
        String jsonQuery = """
            {
              "Account": {
                "select": {}
              }
            }
            """;

        JsonNode queryNode = objectMapper.readTree(jsonQuery);
        String sql = translatorService.translateToSql(queryNode, "POSTGRESQL");

        assertNotNull(sql);
        assertTrue(sql.contains("SELECT"));
        assertTrue(sql.contains("Account"));
    }

    @Test
    void testQueryWithoutSelect() throws Exception {
        String jsonQuery = """
            {
              "Account": {
                "filter": ["id == 1"]
              }
            }
            """;

        JsonNode queryNode = objectMapper.readTree(jsonQuery);
        String sql = translatorService.translateToSql(queryNode, "POSTGRESQL");

        assertNotNull(sql);
        assertTrue(sql.contains("SELECT"));
        assertTrue(sql.contains("Account"));
    }

    @Test
    void testGreaterThanEqualFilter() throws Exception {
        String jsonQuery = """
            {
              "Account": {
                "select": {
                  "id": true,
                  "balance": true
                },
                "filter": ["balance >= 5000"]
              }
            }
            """;

        JsonNode queryNode = objectMapper.readTree(jsonQuery);
        String sql = translatorService.translateToSql(queryNode, "POSTGRESQL");

        assertNotNull(sql);
        assertTrue(sql.contains("WHERE"));
        assertTrue(sql.contains("balance"));
        assertTrue(sql.contains("5000"));
        assertTrue(sql.contains(">="));
    }

    @Test
    void testMultipleNestedJoins() throws Exception {
        String jsonQuery = """
            {
              "Account": {
                "select": {
                  "id": true,
                  "accountNumber": true,
                  "primaryOwner": {
                    "select": {
                      "firstName": true,
                      "address": {
                        "select": {
                          "street": true,
                          "city": true
                        }
                      }
                    }
                  }
                }
              }
            }
            """;

        JsonNode queryNode = objectMapper.readTree(jsonQuery);
        String sql = translatorService.translateToSql(queryNode, "POSTGRESQL");

        assertNotNull(sql);
        assertTrue(sql.contains("SELECT"));
        assertTrue(sql.contains("JOIN") || sql.contains("INNER JOIN"));
        assertTrue(sql.contains("Account"));
        assertTrue(sql.contains("primaryOwner"));
        assertTrue(sql.contains("address"));
        assertTrue(sql.contains("firstName") || sql.contains("primaryOwner_firstName"));
        assertTrue(sql.contains("street") || sql.contains("address_street"));
        assertTrue(sql.contains("city") || sql.contains("address_city"));
    }

    @Test
    void testInvalidJsonStructure() {
        assertThrows(QueryTranslationException.class, () -> {
            JsonNode queryNode = objectMapper.readTree("{}");
            translatorService.translateToSql(queryNode, "POSTGRESQL");
        });
    }

    @Test
    void testNullQueryNode() {
        assertThrows(QueryTranslationException.class, () -> {
            translatorService.translateToSql(null, "POSTGRESQL");
        });
    }

    @Test
    void testNullDialect() throws Exception {
        String jsonQuery = """
            {
              "Account": {
                "select": {
                  "id": true
                }
              }
            }
            """;

        JsonNode queryNode = objectMapper.readTree(jsonQuery);
        String sql = translatorService.translateToSql(queryNode, null);

        assertNotNull(sql);
        assertTrue(sql.contains("SELECT"));
        assertTrue(sql.contains("Account"));
    }

    @Test
    void testCaseInsensitiveDialect() throws Exception {
        String jsonQuery = """
            {
              "Account": {
                "select": {
                  "id": true,
                  "accountNumber": true
                }
              }
            }
            """;

        JsonNode queryNode = objectMapper.readTree(jsonQuery);
        
        String sql1 = translatorService.translateToSql(queryNode, "postgresql");
        String sql2 = translatorService.translateToSql(queryNode, "POSTGRESQL");
        String sql3 = translatorService.translateToSql(queryNode, "postgres");

        assertNotNull(sql1);
        assertNotNull(sql2);
        assertNotNull(sql3);
        assertTrue(sql1.contains("SELECT"));
        assertTrue(sql2.contains("SELECT"));
        assertTrue(sql3.contains("SELECT"));
    }

    @Test
    void testLargeQuery() throws Exception {
        String jsonQuery = """
            {
              "Customer": {
                "select": {
                  "id": true,
                  "name": true,
                  "email": true,
                  "orders": {
                    "select": {
                      "id": true,
                      "orderDate": true,
                      "total": true,
                      "items": {
                        "select": {
                          "productName": true,
                          "quantity": true,
                          "price": true
                        }
                      }
                    }
                  }
                },
                "filter": ["name == 'John Doe'", "email == 'john@example.com'"],
                "orderBy": ["desc(name)", "email"]
              }
            }
            """;

        JsonNode queryNode = objectMapper.readTree(jsonQuery);
        String sql = translatorService.translateToSql(queryNode, "POSTGRESQL");

        assertNotNull(sql);
        assertTrue(sql.contains("SELECT"));
        assertTrue(sql.contains("JOIN") || sql.contains("INNER JOIN"));
        assertTrue(sql.contains("WHERE"));
        assertTrue(sql.contains("ORDER BY"));
        assertTrue(sql.contains("Customer"));
        assertTrue(sql.contains("orders"));
        assertTrue(sql.contains("items"));
        assertTrue(sql.contains("John Doe"));
        assertTrue(sql.contains("john@example.com"));
        assertTrue(sql.contains("DESC"));
    }
}