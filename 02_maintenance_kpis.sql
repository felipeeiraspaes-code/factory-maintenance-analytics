-- PlantPulse | 02 Maintenance KPIs
USE PlantPulse;
GO

-- 1. Overall maintenance KPIs
SELECT
    COUNT(*) AS total_orders,
    SUM(total_cost) AS total_maintenance_cost,
    SUM(labour_cost) AS total_labour_cost,
    SUM(material_cost) AS total_material_cost,
    SUM(downtime_hours) AS total_downtime_hours,
    ROUND(AVG(labour_hours), 2) AS avg_labour_hours
FROM dbo.maintenance_orders;

-- 2. Preventive vs corrective maintenance
SELECT
    maintenance_type,
    COUNT(*) AS order_count,
    SUM(total_cost) AS total_cost,
    SUM(downtime_hours) AS downtime_hours,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS percentage_of_orders
FROM dbo.maintenance_orders
GROUP BY maintenance_type;

-- 3. Preventive maintenance rate
SELECT
    ROUND(
        100.0 * SUM(CASE WHEN maintenance_type = 'Preventive' THEN 1 ELSE 0 END)
        / COUNT(*), 2
    ) AS preventive_maintenance_rate
FROM dbo.maintenance_orders;

-- 4. Monthly maintenance performance
SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    COUNT(*) AS order_count,
    ROUND(SUM(total_cost), 2) AS maintenance_cost,
    ROUND(SUM(downtime_hours), 2) AS downtime_hours
FROM dbo.maintenance_orders
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY order_year, order_month;

-- 5. Maintenance cost by priority
SELECT
    priority,
    COUNT(*) AS order_count,
    ROUND(SUM(total_cost), 2) AS total_cost,
    ROUND(AVG(total_cost), 2) AS avg_order_cost
FROM dbo.maintenance_orders
GROUP BY priority
ORDER BY total_cost DESC;
GO
