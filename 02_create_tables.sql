-- PlantPulse
-- 02_create_tables.sql

USE PlantPulse;
GO

DROP TABLE IF EXISTS dbo.order_parts;
DROP TABLE IF EXISTS dbo.maintenance_orders;
DROP TABLE IF EXISTS dbo.notifications;
DROP TABLE IF EXISTS dbo.spare_parts;
DROP TABLE IF EXISTS dbo.technicians;
DROP TABLE IF EXISTS dbo.equipment;
DROP TABLE IF EXISTS dbo.functional_locations;
GO

CREATE TABLE dbo.functional_locations (
    functional_location_id VARCHAR(20) NOT NULL,
    location_name VARCHAR(100) NOT NULL,
    area VARCHAR(50) NOT NULL,
    CONSTRAINT PK_functional_locations PRIMARY KEY (functional_location_id)
);
GO

CREATE TABLE dbo.equipment (
    equipment_id VARCHAR(20) NOT NULL,
    equipment_name VARCHAR(100) NOT NULL,
    equipment_type VARCHAR(50) NOT NULL,
    functional_location_id VARCHAR(20) NOT NULL,
    installation_year INT NOT NULL,
    criticality VARCHAR(20) NOT NULL,
    status VARCHAR(30) NOT NULL,
    CONSTRAINT PK_equipment PRIMARY KEY (equipment_id)
);
GO

CREATE TABLE dbo.technicians (
    technician_id VARCHAR(20) NOT NULL,
    technician_name VARCHAR(100) NOT NULL,
    specialty VARCHAR(50) NOT NULL,
    skill_level VARCHAR(30) NOT NULL,
    CONSTRAINT PK_technicians PRIMARY KEY (technician_id)
);
GO

CREATE TABLE dbo.spare_parts (
    spare_part_id VARCHAR(20) NOT NULL,
    part_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    unit_cost DECIMAL(12,2) NOT NULL,
    stock_quantity INT NOT NULL,
    CONSTRAINT PK_spare_parts PRIMARY KEY (spare_part_id)
);
GO

CREATE TABLE dbo.notifications (
    notification_id VARCHAR(20) NOT NULL,
    equipment_id VARCHAR(20) NOT NULL,
    created_date DATE NOT NULL,
    notification_type VARCHAR(50) NOT NULL,
    priority VARCHAR(20) NOT NULL,
    status VARCHAR(30) NOT NULL,
    CONSTRAINT PK_notifications PRIMARY KEY (notification_id)
);
GO

CREATE TABLE dbo.maintenance_orders (
    maintenance_order_id VARCHAR(20) NOT NULL,
    notification_id VARCHAR(20) NOT NULL,
    equipment_id VARCHAR(20) NOT NULL,
    technician_id VARCHAR(20) NOT NULL,
    order_date DATE NOT NULL,
    maintenance_type VARCHAR(30) NOT NULL,
    priority VARCHAR(20) NOT NULL,
    status VARCHAR(30) NOT NULL,
    labour_hours DECIMAL(10,2) NOT NULL,
    downtime_hours DECIMAL(10,2) NOT NULL,
    labour_cost DECIMAL(12,2) NOT NULL,
    material_cost DECIMAL(12,2) NOT NULL DEFAULT 0,
    total_cost AS (labour_cost + material_cost) PERSISTED,
    CONSTRAINT PK_maintenance_orders PRIMARY KEY (maintenance_order_id)
);
GO

CREATE TABLE dbo.order_parts (
    maintenance_order_id VARCHAR(20) NOT NULL,
    spare_part_id VARCHAR(20) NOT NULL,
    quantity INT NOT NULL,
    material_cost DECIMAL(12,2) NOT NULL,
    CONSTRAINT PK_order_parts PRIMARY KEY (maintenance_order_id, spare_part_id)
);
GO
