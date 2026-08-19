-- PlantPulse
-- 04_load_data.sql
--
-- Place the CSV files in the same directory as this script or update
-- the file paths below.
--
-- SQL Server requires the SQL Server service account to be able to read
-- the files. Alternatively, use the Import Flat File wizard in SSMS.

USE PlantPulse;
GO

-- Functional Locations
BULK INSERT dbo.functional_locations
FROM 'C:\PlantPulse\data\functional_locations.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    TABLOCK
);
GO

-- Equipment
BULK INSERT dbo.equipment
FROM 'C:\PlantPulse\data\equipment.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    TABLOCK
);
GO

-- Technicians
BULK INSERT dbo.technicians
FROM 'C:\PlantPulse\data\technicians.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    TABLOCK
);
GO

-- Spare Parts
BULK INSERT dbo.spare_parts
FROM 'C:\PlantPulse\data\spare_parts.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    TABLOCK
);
GO

-- Notifications
BULK INSERT dbo.notifications
FROM 'C:\PlantPulse\data\notifications.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    TABLOCK
);
GO

-- Maintenance Orders
BULK INSERT dbo.maintenance_orders
FROM 'C:\PlantPulse\data\maintenance_orders.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    TABLOCK
);
GO

-- Order Parts
BULK INSERT dbo.order_parts
FROM 'C:\PlantPulse\data\order_parts.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    TABLOCK
);
GO

-- Basic validation
SELECT 'functional_locations' AS table_name, COUNT(*) AS row_count FROM dbo.functional_locations
UNION ALL
SELECT 'equipment', COUNT(*) FROM dbo.equipment
UNION ALL
SELECT 'technicians', COUNT(*) FROM dbo.technicians
UNION ALL
SELECT 'spare_parts', COUNT(*) FROM dbo.spare_parts
UNION ALL
SELECT 'notifications', COUNT(*) FROM dbo.notifications
UNION ALL
SELECT 'maintenance_orders', COUNT(*) FROM dbo.maintenance_orders
UNION ALL
SELECT 'order_parts', COUNT(*) FROM dbo.order_parts;
GO
