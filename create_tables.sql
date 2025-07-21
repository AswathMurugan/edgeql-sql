-- PostgreSQL DDL Script
-- This simple script has been replaced by a comprehensive version
-- 
-- For the COMPLETE database schema with ALL 153 tables and 294 foreign keys,
-- use the comprehensive DDL script instead:
--
-- File: postgresql_ddl_complete.sql
-- 
-- Usage:
--   psql -U username -d database_name -f postgresql_ddl_complete.sql
--
-- The comprehensive script includes:
-- - All 153 EdgeQL types converted to PostgreSQL tables
-- - All 294 foreign key relationships from the EdgeQL schema
-- - Proper data type mappings (std::str → VARCHAR, std::int64 → BIGINT, etc.)
-- - UUID primary keys with gen_random_uuid() defaults
-- - wealthdomain schema organization
-- - Complete referential integrity constraints
--
-- Note: This matches your existing database structure exactly!

-- Quick setup for testing (minimal tables only)
CREATE SCHEMA IF NOT EXISTS wealthdomain;
SET search_path TO wealthdomain, public;

-- Minimal Account table for basic testing
CREATE TABLE IF NOT EXISTS account (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    accountnumber VARCHAR(255),
    accountstatus VARCHAR(255),
    balance DOUBLE PRECISION,
    createdat TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Minimal primaryOwner table for basic testing  
CREATE TABLE IF NOT EXISTS primaryowner (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    firstname VARCHAR(100),
    lastname VARCHAR(100),
    email VARCHAR(255),
    createdat TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Basic sample data
INSERT INTO primaryowner (firstname, lastname, email) VALUES
('John', 'Doe', 'john.doe@example.com'),
('Jane', 'Smith', 'jane.smith@example.com')
ON CONFLICT (id) DO NOTHING;

INSERT INTO account (accountnumber, accountstatus, balance) VALUES
('ACC-001-2024', 'ACTIVE', 15000.50),
('ACC-002-2024', 'ACTIVE', 75000.00)
ON CONFLICT (id) DO NOTHING;

SELECT 'Basic tables created. Use postgresql_ddl_complete.sql for full schema.' as message;