-- PlantPulse
-- 01_create_database.sql
-- SQL Server

IF DB_ID('PlantPulse') IS NULL
BEGIN
    CREATE DATABASE PlantPulse;
END;
GO

USE PlantPulse;
GO
