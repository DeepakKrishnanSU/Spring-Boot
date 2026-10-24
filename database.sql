-- ====================================================================
-- Experiment 10: Spring Boot MVC + JPA + JSP + Hibernate + PostgreSQL
-- Database Setup Script
-- ====================================================================

-- 1. Create the database (Execute while connected to PostgreSQL default server)
CREATE DATABASE college;

-- 2. Connect to the 'college' database and execute the following:
CREATE TABLE IF NOT EXISTS student (
    regno INTEGER PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    cgpa DOUBLE PRECISION NOT NULL
);

-- (Optional) Sample test record:
-- INSERT INTO student (regno, name, cgpa) VALUES (101, 'Arul Xavier', 8.75);
