# EdgeQL to SQL Translator

A Spring Boot application that translates JSON-based queries to PostgreSQL SQL statements using Apache Calcite. The service supports EdgeQL schema definitions and generates case-sensitive PostgreSQL queries with proper JOIN operations.


## API Usage

### Basic Query
```bash
curl -X POST http://localhost:8088/api/v1/translate \
  -H "Content-Type: application/json" \
  -d '{
    "query": {
      "Person": {
        "select": {
          "id": true,
          "perNumber": true
        }
      }
    },
     "schema": "domain"
  }'
```

