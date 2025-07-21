#!/usr/bin/env python3
"""
EdgeQL to PostgreSQL Schema Parser
Parses EdgeQL schema and generates PostgreSQL DDL script
"""

import re
import sys
from typing import Dict, List, Set, Tuple

class EdgeQLParser:
    def __init__(self):
        self.types = {}
        self.foreign_keys = []
        
    def parse_schema_file(self, file_path: str):
        """Parse the EdgeQL schema file and extract all type definitions"""
        with open(file_path, 'r') as f:
            content = f.read()
        
        # Split content by type definitions - more robust approach
        lines = content.split('\n')
        current_type = None
        current_type_body = []
        brace_count = 0
        in_type = False
        
        for line in lines:
            stripped = line.strip()
            
            # Check if this is a type definition start
            type_match = re.match(r'\s*type\s+(\w+)\s*\{', line)
            if type_match:
                # If we were processing a previous type, save it
                if current_type and current_type_body:
                    self.parse_type(current_type, '\n'.join(current_type_body))
                
                current_type = type_match.group(1)
                current_type_body = []
                brace_count = 1
                in_type = True
                continue
            
            if in_type:
                # Count braces to track nesting
                brace_count += line.count('{') - line.count('}')
                current_type_body.append(line)
                
                # If we've closed all braces, we're done with this type
                if brace_count == 0:
                    if current_type:
                        self.parse_type(current_type, '\n'.join(current_type_body[:-1]))  # Exclude the closing line
                    current_type = None
                    current_type_body = []
                    in_type = False
        
        # Handle last type if file doesn't end with a newline
        if current_type and current_type_body:
            self.parse_type(current_type, '\n'.join(current_type_body))
    
    def parse_type(self, type_name: str, type_body: str):
        """Parse individual type definition"""
        properties = []
        links = []
        
        # Parse properties
        prop_pattern = r'property\s+(\w+):\s*([^{;]+)(?:\s*\{([^}]*)\})?;'
        prop_matches = re.findall(prop_pattern, type_body, re.DOTALL)
        
        for prop_name, prop_type, constraints in prop_matches:
            pg_type = self.map_edgeql_to_postgres_type(prop_type.strip(), constraints)
            properties.append((prop_name, pg_type))
        
        # Parse links
        link_pattern = r'(?:multi\s+)?link\s+(\w+):\s*wealthdomain::(\w+)'
        link_matches = re.findall(link_pattern, type_body)
        
        for link_name, target_type in link_matches:
            links.append((link_name, target_type))
            # Store foreign key relationship
            self.foreign_keys.append((type_name, link_name, target_type))
        
        self.types[type_name] = {
            'properties': properties,
            'links': links
        }
    
    def map_edgeql_to_postgres_type(self, edgeql_type: str, constraints: str = "") -> str:
        """Map EdgeQL types to PostgreSQL types"""
        type_mapping = {
            'std::str': 'TEXT',
            'std::int16': 'SMALLINT',
            'std::int32': 'INTEGER',
            'std::int64': 'BIGINT',
            'std::float32': 'REAL',
            'std::float64': 'DOUBLE PRECISION',
            'std::bool': 'BOOLEAN',
            'std::uuid': 'UUID',
            'std::datetime': 'TIMESTAMP WITH TIME ZONE',
            'std::duration': 'INTERVAL',
            'std::decimal': 'NUMERIC',
            'std::bytes': 'BYTEA',
            'std::json': 'JSONB',
            'cal::local_datetime': 'TIMESTAMP',
            'cal::local_date': 'DATE',
            'cal::local_time': 'TIME'
        }
        
        # Clean up type
        clean_type = edgeql_type.strip()
        
        # Handle max_len_value constraint for VARCHAR
        if 'std::str' in clean_type and 'max_len_value' in constraints:
            max_len_match = re.search(r'max_len_value\((\d+)\)', constraints)
            if max_len_match:
                max_len = max_len_match.group(1)
                return f'VARCHAR({max_len})'
        
        return type_mapping.get(clean_type, 'TEXT')
    
    def generate_postgresql_ddl(self) -> str:
        """Generate PostgreSQL DDL script"""
        ddl = []
        
        # Create tables
        for type_name, type_def in self.types.items():
            table_ddl = self.generate_table_ddl(type_name, type_def)
            ddl.append(table_ddl)
        
        # Add foreign key constraints
        for source_table, link_name, target_table in self.foreign_keys:
            if target_table in self.types:  # Ensure target table exists
                fk_ddl = f"""
ALTER TABLE "{source_table}" 
ADD CONSTRAINT "fk_{source_table}_{link_name}" 
FOREIGN KEY ("{link_name}_id") REFERENCES "{target_table}"(id);"""
                ddl.append(fk_ddl)
        
        return '\n'.join(ddl)
    
    def generate_table_ddl(self, type_name: str, type_def: Dict) -> str:
        """Generate DDL for a single table"""
        table_name = f'"{type_name}"'  # Keep original case with quotes
        columns = ['id UUID PRIMARY KEY DEFAULT gen_random_uuid()']
        
        # Add properties as columns (preserve original case)
        for prop_name, pg_type in type_def['properties']:
            columns.append(f'"{prop_name}" {pg_type}')
        
        # Add foreign key columns for links (preserve original case)
        for link_name, target_type in type_def['links']:
            columns.append(f'"{link_name}_id" UUID')
        
        ddl = f"""
-- Table: {type_name}
CREATE TABLE {table_name} (
    {',\n    '.join(columns)}
);"""
        
        return ddl

def main():
    parser = EdgeQLParser()
    schema_file = "/Users/aswathmurugan/Documents/MyProject/edgeql-sql/src/main/resources/schemas/schema_sample.txt"
    
    try:
        parser.parse_schema_file(schema_file)
        print(f"Parsed {len(parser.types)} types")
        
        # Generate PostgreSQL DDL
        ddl_script = parser.generate_postgresql_ddl()
        
        # Write to file
        output_file = "/Users/aswathmurugan/Documents/MyProject/edgeql-sql/postgresql_ddl_complete.sql"
        with open(output_file, 'w') as f:
            f.write("-- PostgreSQL DDL Script generated from EdgeQL Schema\n")
            f.write("-- Source: schema_sample.txt\n")
            f.write("-- Generated types: " + str(len(parser.types)) + "\n\n")
            f.write("CREATE SCHEMA IF NOT EXISTS wealthdomain;\n")
            f.write("SET search_path TO wealthdomain, public;\n\n")
            f.write(ddl_script)
        
        print(f"DDL script written to: {output_file}")
        
    except Exception as e:
        print(f"Error: {e}")
        return 1
    
    return 0

if __name__ == "__main__":
    sys.exit(main())