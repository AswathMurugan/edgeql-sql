# EdgeQL to SQL Translator

A Spring Boot application that translates JSON-based queries to PostgreSQL SQL statements using Apache Calcite. The service supports EdgeQL schema definitions and generates case-sensitive PostgreSQL queries with proper JOIN operations.

## API Usage

### Query with Schema Path Variable
```bash
curl -X POST http://localhost:8088/api/v1/translate/wealthdomain \
  -H "Content-Type: application/json" \
  -d '{
    "query": {
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
        },
        "filter": ["id == '\''0b501512-5eff-11f0-8a34-0b17db5d73a1'\''"]
      }
    }
  }'
```

**Generated SQL:**
```sql
SELECT * FROM (
  SELECT "Account"."id", "Account"."accountNumber", "Person"."firstName", "Person"."lastName" 
  FROM "wealthdomain"."Account" 
  INNER JOIN "wealthdomain"."Person" ON "Account"."primaryOwner_id" = "Person"."id"
) AS "t" 
WHERE "t"."id" = '0b501512-5eff-11f0-8a34-0b17db5d73a1'
```

### Simple Query without Joins
```bash
curl -X POST http://localhost:8088/api/v1/translate/wealthdomain \
  -H "Content-Type: application/json" \
  -d '{
    "query": {
      "Account": {
        "select": {
          "id": true,
          "accountNumber": true,
          "balance": true
        }
      }
    }
  }'
```

**Generated SQL:**
```sql
SELECT "Account"."id", "Account"."accountNumber", "Account"."balance" 
FROM "wealthdomain"."Account"
```

### Query with Default Schema (public)
```bash
curl -X POST http://localhost:8088/api/v1/translate \
  -H "Content-Type: application/json" \
  -d '{
    "query": {
      "Person": {
        "select": {
          "id": true,
          "firstName": true,
          "lastName": true
        }
      }
    }
  }'
```

**Generated SQL:**
```sql
SELECT "Person"."id", "Person"."firstName", "Person"."lastName" 
FROM "public"."Person"
```

