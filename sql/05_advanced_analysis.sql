-- PlantPulse | 05 Advanced Analysis
USE PlantPulse;
GO

-- 1. Rank equipment by maintenance cost
SELECT
    e.equipment_id,
    e.equipment_name,
    ROUND(SUM(mo.total_cost), 2) AS total_cost,
    RANK() OVER (ORDER BY SUM(mo.total_cost) DESC) AS cost_rank
FROM dbo.equipment e
JOIN dbo.maintenance_orders mo
    ON e.equipment_id = mo.equipment_id
GROUP BY e.equipment_id, e.equipment_name
ORDER BY cost_rank;

-- 2. Running monthly maintenance cost
WITH monthly_cost AS (
    SELECT
        DATEFROMPARTS(YEAR(order_date), MONTH(order_date), 1) AS month_start,
        SUM(total_cost) AS monthly_cost
    FROM dbo.maintenance_orders
    GROUP BY DATEFROMPARTS(YEAR(order_date), MONTH(order_date), 1)
)
SELECT
    month_start,
    ROUND(monthly_cost, 2) AS monthly_cost,
    ROUND(
        SUM(monthly_cost) OVER (
            ORDER BY month_start
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ), 2
    ) AS cumulative_cost
FROM monthly_cost
ORDER BY month_start;

-- 3. Month-over-month cost change
WITH monthly_cost AS (
    SELECT
        DATEFROMPARTS(YEAR(order_date), MONTH(order_date), 1) AS month_start,
        SUM(total_cost) AS monthly_cost
    FROM dbo.maintenance_orders
    GROUP BY DATEFROMPARTS(YEAR(order_date), MONTH(order_date), 1)
)
SELECT
    month_start,
    ROUND(monthly_cost, 2) AS monthly_cost,
    ROUND(LAG(monthly_cost) OVER (ORDER BY month_start), 2) AS previous_month_cost,
    ROUND(
        monthly_cost - LAG(monthly_cost) OVER (ORDER BY month_start), 2
    ) AS cost_change
FROM monthly_cost
ORDER BY month_start;

-- 4. Top 3 most expensive equipment in each production area
WITH equipment_cost AS (
    SELECT
        fl.area,
        e.equipment_id,
        e.equipment_name,
        SUM(mo.total_cost) AS total_cost
    FROM dbo.functional_locations fl
    JOIN dbo.equipment e
        ON fl.functional_location_id = e.functional_location_id
    JOIN dbo.maintenance_orders mo
        ON e.equipment_id = mo.equipment_id
    GROUP BY fl.area, e.equipment_id, e.equipment_name
),
ranked AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY area
            ORDER BY total_cost DESC
        ) AS area_rank
    FROM equipment_cost
)
SELECT
    area,
    equipment_id,
    equipment_name,
    ROUND(total_cost, 2) AS total_cost,
    area_rank
FROM ranked
WHERE area_rank <= 3
ORDER BY area, area_rank;

-- 5. Technician workload and cost
SELECT
    t.technician_id,
    t.technician_name,
    t.specialty,
    t.skill_level,
    COUNT(mo.maintenance_order_id) AS orders_completed,
    ROUND(SUM(mo.labour_hours), 2) AS labour_hours,
    ROUND(SUM(mo.labour_cost), 2) AS labour_cost,
    ROUND(AVG(mo.labour_hours), 2) AS avg_hours_per_order
FROM dbo.technicians t
LEFT JOIN dbo.maintenance_orders mo
    ON t.technician_id = mo.technician_id
GROUP BY
    t.technician_id,
    t.technician_name,
    t.specialty,
    t.skill_level
ORDER BY orders_completed DESC;

-- 6. Critical equipment with high corrective-maintenance cost
SELECT
    e.equipment_id,
    e.equipment_name,
    e.criticality,
    COUNT(*) AS corrective_orders,
    ROUND(SUM(mo.total_cost), 2) AS corrective_cost,
    ROUND(SUM(mo.downtime_hours), 2) AS downtime_hours
FROM dbo.equipment e
JOIN dbo.maintenance_orders mo
    ON e.equipment_id = mo.equipment_id
WHERE e.criticality IN ('Critical', 'High')
  AND mo.maintenance_type = 'Corrective'
GROUP BY e.equipment_id, e.equipment_name, e.criticality
HAVING SUM(mo.total_cost) > 1000
ORDER BY corrective_cost DESC;
GO
