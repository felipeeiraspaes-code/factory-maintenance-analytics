-- PlantPulse | 03 Equipment Reliability
USE PlantPulse;
GO

-- 1. Equipment with the most maintenance orders
SELECT
    e.equipment_id,
    e.equipment_name,
    e.equipment_type,
    e.criticality,
    COUNT(mo.maintenance_order_id) AS maintenance_orders,
    ROUND(SUM(mo.downtime_hours), 2) AS downtime_hours,
    ROUND(SUM(mo.total_cost), 2) AS maintenance_cost
FROM dbo.equipment e
JOIN dbo.maintenance_orders mo
    ON e.equipment_id = mo.equipment_id
GROUP BY
    e.equipment_id,
    e.equipment_name,
    e.equipment_type,
    e.criticality
ORDER BY maintenance_orders DESC;

-- 2. Highest downtime equipment
SELECT TOP 20
    e.equipment_id,
    e.equipment_name,
    e.equipment_type,
    ROUND(SUM(mo.downtime_hours), 2) AS downtime_hours
FROM dbo.equipment e
JOIN dbo.maintenance_orders mo
    ON e.equipment_id = mo.equipment_id
GROUP BY
    e.equipment_id,
    e.equipment_name,
    e.equipment_type
ORDER BY downtime_hours DESC;

-- 3. MTTR by equipment
-- MTTR here is average downtime per corrective maintenance order.
SELECT
    e.equipment_id,
    e.equipment_name,
    COUNT(*) AS corrective_orders,
    ROUND(AVG(mo.downtime_hours), 2) AS mttr_hours
FROM dbo.equipment e
JOIN dbo.maintenance_orders mo
    ON e.equipment_id = mo.equipment_id
WHERE mo.maintenance_type = 'Corrective'
GROUP BY e.equipment_id, e.equipment_name
HAVING COUNT(*) >= 2
ORDER BY mttr_hours DESC;

-- 4. Failure frequency by equipment
SELECT
    e.equipment_id,
    e.equipment_name,
    COUNT(n.notification_id) AS breakdown_count
FROM dbo.equipment e
LEFT JOIN dbo.notifications n
    ON e.equipment_id = n.equipment_id
    AND n.notification_type = 'Breakdown'
GROUP BY e.equipment_id, e.equipment_name
ORDER BY breakdown_count DESC;

-- 5. Equipment reliability summary
WITH failure_data AS (
    SELECT
        equipment_id,
        COUNT(*) AS failures,
        SUM(downtime_hours) AS downtime_hours,
        AVG(downtime_hours) AS avg_repair_downtime
    FROM dbo.maintenance_orders
    WHERE maintenance_type = 'Corrective'
    GROUP BY equipment_id
)
SELECT
    e.equipment_id,
    e.equipment_name,
    e.criticality,
    COALESCE(f.failures, 0) AS failures,
    ROUND(COALESCE(f.downtime_hours, 0), 2) AS downtime_hours,
    ROUND(COALESCE(f.avg_repair_downtime, 0), 2) AS mttr_hours
FROM dbo.equipment e
LEFT JOIN failure_data f
    ON e.equipment_id = f.equipment_id
ORDER BY failures DESC;
GO
