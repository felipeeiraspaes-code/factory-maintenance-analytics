-- PlantPulse | 04 Cost Analysis
USE PlantPulse;
GO

-- 1. Cost by equipment
SELECT
    e.equipment_id,
    e.equipment_name,
    e.equipment_type,
    ROUND(SUM(mo.total_cost), 2) AS total_cost,
    ROUND(SUM(mo.labour_cost), 2) AS labour_cost,
    ROUND(SUM(mo.material_cost), 2) AS material_cost
FROM dbo.equipment e
JOIN dbo.maintenance_orders mo
    ON e.equipment_id = mo.equipment_id
GROUP BY e.equipment_id, e.equipment_name, e.equipment_type
ORDER BY total_cost DESC;

-- 2. Cost by production area
SELECT
    fl.area,
    COUNT(mo.maintenance_order_id) AS maintenance_orders,
    ROUND(SUM(mo.total_cost), 2) AS total_cost,
    ROUND(SUM(mo.downtime_hours), 2) AS downtime_hours
FROM dbo.functional_locations fl
JOIN dbo.equipment e
    ON fl.functional_location_id = e.functional_location_id
JOIN dbo.maintenance_orders mo
    ON e.equipment_id = mo.equipment_id
GROUP BY fl.area
ORDER BY total_cost DESC;

-- 3. Labour vs materials
SELECT
    ROUND(SUM(labour_cost), 2) AS labour_cost,
    ROUND(SUM(material_cost), 2) AS material_cost,
    ROUND(SUM(total_cost), 2) AS total_cost,
    ROUND(100.0 * SUM(labour_cost) / SUM(total_cost), 2) AS labour_percentage,
    ROUND(100.0 * SUM(material_cost) / SUM(total_cost), 2) AS material_percentage
FROM dbo.maintenance_orders;

-- 4. Most expensive spare parts
SELECT
    sp.spare_part_id,
    sp.part_name,
    SUM(op.quantity) AS quantity_used,
    ROUND(SUM(op.material_cost), 2) AS total_material_cost
FROM dbo.spare_parts sp
JOIN dbo.order_parts op
    ON sp.spare_part_id = op.spare_part_id
GROUP BY sp.spare_part_id, sp.part_name
ORDER BY total_material_cost DESC;

-- 5. Monthly maintenance cost
SELECT
    DATEFROMPARTS(YEAR(order_date), MONTH(order_date), 1) AS month_start,
    ROUND(SUM(total_cost), 2) AS maintenance_cost
FROM dbo.maintenance_orders
GROUP BY DATEFROMPARTS(YEAR(order_date), MONTH(order_date), 1)
ORDER BY month_start;
GO
