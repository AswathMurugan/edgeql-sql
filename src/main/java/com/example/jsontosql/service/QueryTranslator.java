package com.example.jsontosql.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.calcite.jdbc.CalciteConnection;
import org.apache.calcite.rel.RelNode;
import org.apache.calcite.rel.core.JoinRelType;
import org.apache.calcite.rel.rel2sql.RelToSqlConverter;
import org.apache.calcite.rel.type.RelDataType;
import org.apache.calcite.rel.type.RelDataTypeFactory;
import org.apache.calcite.rex.RexBuilder;
import org.apache.calcite.rex.RexNode;
import org.apache.calcite.schema.SchemaPlus;
import org.apache.calcite.schema.impl.AbstractSchema;
import org.apache.calcite.schema.impl.AbstractTable;
import org.apache.calcite.sql.SqlDialect;
import org.apache.calcite.sql.dialect.SnowflakeSqlDialect;
import org.apache.calcite.sql.fun.SqlStdOperatorTable;
import org.apache.calcite.sql.type.SqlTypeName;
import org.apache.calcite.tools.FrameworkConfig;
import org.apache.calcite.tools.Frameworks;
import org.apache.calcite.tools.RelBuilder;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.sql.DriverManager;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

@Service
public class QueryTranslator {

    private static final ObjectMapper mapper = new ObjectMapper();

    public static void main(String[] args) throws Exception {
        System.out.println(translateQuery());
    }


    public static  String translateQuery() throws Exception {
        // Input JSON query
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
            },
            "filter": ["accountNumber == '1234'", "balance >= 10000"],
            "orderBy": ["desc(accountNumber)", "balance"]
          }
        }
        """;
        //, "balance"
        //, "balance >= '10000'"
        // Parse JSON
        JsonNode queryNode = mapper.readTree(jsonQuery);

        // Define schema
        SchemaPlus rootSchema = Frameworks.createRootSchema(true);
        SchemaPlus schema = rootSchema.add("test", new AbstractSchema());

        // Define Account table
        schema.add("Account", new AbstractTable() {
            @Override
            public RelDataType getRowType(RelDataTypeFactory typeFactory) {
                RelDataTypeFactory.Builder builder = typeFactory.builder();
                builder.add("id", SqlTypeName.INTEGER);
                builder.add("accountNumber", SqlTypeName.VARCHAR);
                builder.add("balance", SqlTypeName.DECIMAL);
                builder.add("primaryOwnerId", SqlTypeName.INTEGER);

                return builder.build();
            }
        });

        // Define primaryOwner table
        schema.add("primaryOwner", new AbstractTable() {
            @Override
            public RelDataType getRowType(RelDataTypeFactory typeFactory) {
                RelDataTypeFactory.Builder builder = typeFactory.builder();
                builder.add("id", SqlTypeName.INTEGER);
                builder.add("firstName", SqlTypeName.VARCHAR);
                builder.add("lastName", SqlTypeName.VARCHAR);
                return builder.build();
            }
        });

        // Create Calcite connection
        Properties info = new Properties();
        info.setProperty("caseSensitive", "false");
        CalciteConnection connection = (CalciteConnection) DriverManager.getConnection("jdbc:calcite:", info);
        FrameworkConfig config = Frameworks.newConfigBuilder()
                .defaultSchema(schema)
                .build();

        // Create RelBuilder
        RelBuilder builder = RelBuilder.create(config);
        RexBuilder rexBuilder = builder.getRexBuilder();

        // Parse query and build relational algebra
        JsonNode accountNode = queryNode.get("Account");
        JsonNode selectNode = accountNode.get("select");
        JsonNode filterNode = accountNode.get("filter");
        JsonNode orderByNode = accountNode.get("orderBy");

        // Scan Account table
        builder.scan("test", "Account");

        // Join with primaryOwner
        builder.scan("test", "primaryOwner");
        RexNode joinCondition = rexBuilder.makeCall(
                SqlStdOperatorTable.EQUALS,
                rexBuilder.makeInputRef(builder.peek(1).getRowType().getField("primaryOwnerId", false, false).getType(), 3), // Account.primaryOwnerId
                rexBuilder.makeInputRef(builder.peek(0).getRowType().getField("id", false, false).getType(), 0) // primaryOwner.id
        );
        builder.join(JoinRelType.INNER, joinCondition);

        // Select fields - Get correct field indices from joined row type
        List<RexNode> projects = new ArrayList<>();
        List<String> aliases = new ArrayList<>();
        
        RelDataType joinedRowType = builder.peek().getRowType();
        
        // Account fields (first table in join)
        projects.add(rexBuilder.makeInputRef(joinedRowType.getFieldList().get(0).getType(), 0)); // id
        aliases.add("Account_id");
        projects.add(rexBuilder.makeInputRef(joinedRowType.getFieldList().get(1).getType(), 1)); // accountNumber  
        aliases.add("accountNumber");
        projects.add(rexBuilder.makeInputRef(joinedRowType.getFieldList().get(2).getType(), 2)); // balance
        aliases.add("balance");
        
        // primaryOwner fields (second table in join) - after Account fields
        projects.add(rexBuilder.makeInputRef(joinedRowType.getFieldList().get(5).getType(), 5)); // firstName
        aliases.add("primaryOwner_firstName");
        projects.add(rexBuilder.makeInputRef(joinedRowType.getFieldList().get(6).getType(), 6)); // lastName
        aliases.add("primaryOwner_lastName");
        
        builder.project(projects, aliases);

        // Apply filters
        List<RexNode> conditions = new ArrayList<>();
        for (JsonNode filter : filterNode) {
            String filterStr = filter.asText();
            if (filterStr.contains("==")) {
                String[] parts = filterStr.split("==");
                String field = parts[0].trim();
                String value = parts[1].trim().replace("'", "");
                RexNode condition = rexBuilder.makeCall(
                        SqlStdOperatorTable.EQUALS,
                        rexBuilder.makeInputRef(builder.peek().getRowType().getField(field, false, false).getType(), aliases.indexOf(field)),
                        rexBuilder.makeLiteral(value)
                );
                conditions.add(condition);
            } else if (filterStr.contains(">=")) {
                String[] parts = filterStr.split(">=");
                String field = parts[0].trim();
                String value = parts[1].trim().replace("'", "");
                RexNode condition = rexBuilder.makeCall(
                        SqlStdOperatorTable.GREATER_THAN_OR_EQUAL,
                        rexBuilder.makeInputRef(builder.peek().getRowType().getField(field, false, false).getType(), aliases.indexOf(field)),
                        rexBuilder.makeLiteral(new BigDecimal(value), builder.getTypeFactory().createSqlType(SqlTypeName.DECIMAL))
                );
                conditions.add(condition);
            }
        }
        if (!conditions.isEmpty()) {
            RexNode combinedCondition = rexBuilder.makeCall(SqlStdOperatorTable.AND, conditions);
            builder.filter(combinedCondition);
        }

        // Apply orderBy
        List<RexNode> sorts = new ArrayList<>();
        for (JsonNode order : orderByNode) {
            String orderStr = order.asText();
            if (orderStr.startsWith("desc(")) {
                String field = orderStr.substring(5, orderStr.length() - 1);
                sorts.add(rexBuilder.makeCall(
                        SqlStdOperatorTable.DESC,
                        rexBuilder.makeInputRef(builder.peek().getRowType().getField(field, false, false).getType(), aliases.indexOf(field))
                ));
            } else {
                sorts.add(rexBuilder.makeInputRef(builder.peek().getRowType().getField(orderStr, false, false).getType(), aliases.indexOf(orderStr)));
            }
        }
        builder.sort(sorts);

        // Convert to SQL for multiple dialects
        RelNode relNode = builder.build();
        SqlDialect dialect = SnowflakeSqlDialect.DEFAULT;// PostgresqlSqlDialect.DEFAULT ;
        String sql = new RelToSqlConverter(dialect).visitRoot(relNode).asStatement().toSqlString(dialect).getSql();
        
        // Close connection
        connection.close();
        
        return sql;
    }
}