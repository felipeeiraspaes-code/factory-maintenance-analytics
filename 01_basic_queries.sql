-- PlantPulse | 01 Basic Queries
USE PlantPulse;
GO

-- 1. View all equipment
SELECT *
FROM dbo.equipment;

-- 2. Critical equipment
SELECT equipment_id, equipment_name, equipment_type, criticality
FROM dbo.equipment
WHERE criticality IN ('Critical', 'High')
ORDER BY criticality, equipment_name;

-- 3. Equipment by type
SELECT
    equipment_type,
    COUNT(*) AS equipment_count
FROM dbo.equipment
GROUP BY equipment_type
ORDER BY equipment_count DESC;

-- 4. Maintenance orders by type
SELECT
    maintenance_type,
    COUNT(*) AS order_count
FROM dbo.maintenance_orders
GROUP BY maintenance_type;

-- 5. Average labour hours by maintenance type
SELECT
    maintenance_type,
    ROUND(AVG(labour_hours), 2) AS avg_labour_hours
FROM dbo.maintenance_orders
GROUP BY maintenance_type;

-- 6. Orders with the highest total cost
SELECT TOP 20
    maintenance_order_id,
    equipment_id,
    maintenance_type,
    total_cost,
    downtime_hours
FROM dbo.maintenance_orders
ORDER BY total_cost DESC;
GO
