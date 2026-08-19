# PlantPulse — Industrial Maintenance & Reliability Analytics

##  Overview

**PlantPulse** is a fictional industrial maintenance analytics project designed to demonstrate how maintenance data can be transformed into actionable business insights using **SQL, data modelling and Microsoft Power BI**.

The project simulates the maintenance operations of a manufacturing plant, covering equipment, functional locations, maintenance notifications, maintenance orders, technicians, spare parts, costs and downtime.

The objective is to answer a simple business question:

> **How can maintenance data be used to improve equipment reliability, reduce costs and support better maintenance decisions?**

---

##  Project Objectives

PlantPulse aims to analyse the performance of a fictional manufacturing plant and identify:

* Which equipment generates the highest maintenance costs
* Which assets experience the most failures
* How much downtime is caused by equipment failures
* The relationship between preventive and corrective maintenance
* Maintenance costs by production line
* Technician workload and maintenance performance
* Maintenance trends over time
* Equipment reliability using **MTBF** and **MTTR**
* Opportunities to improve preventive maintenance

---

##  Business Context

The fictional company operates a manufacturing plant containing several production lines and different types of industrial equipment.

Maintenance activities are divided primarily into:

### Preventive Maintenance

Planned maintenance performed to reduce the probability of equipment failure.

Examples:

* Scheduled inspections
* Lubrication
* Component replacement
* Calibration
* Routine servicing

### Corrective Maintenance

Maintenance performed after an equipment problem or failure has occurred.

Examples:

* Equipment breakdowns
* Emergency repairs
* Component failures
* Unplanned interventions

The project analyses both maintenance strategies to understand their impact on **cost, downtime and equipment reliability**.

---
##  Data Model

The project uses a relational data model inspired by real-world industrial maintenance processes and concepts commonly found in enterprise asset management systems.

```text
Functional Locations
        │
        │
        ▼
    Equipment
        │
        │
        ▼
 Maintenance Notifications
        │
        │
        ▼
 Maintenance Orders
        │
        ├───────────────┐
        │               │
        ▼               ▼
 Technicians       Spare Parts
                        │
                        ▼
                  Order Parts
```

### Main entities

| Entity               | Description                                             |
| -------------------- | ------------------------------------------------------- |
| Functional Locations | Physical/organizational locations within the plant      |
| Equipment            | Individual maintainable assets                          |
| Notifications        | Reported faults, problems or maintenance requests       |
| Maintenance Orders   | Work performed to resolve or prevent maintenance issues |
| Technicians          | Employees responsible for maintenance activities        |
| Spare Parts          | Materials consumed during maintenance                   |
| Order Parts          | Relationship between maintenance orders and spare parts |

---

## 🛠️ Technologies

### Database

**SQL Server**

SQL is used to:

* Create the database
* Define tables and relationships
* Clean and transform data
* Calculate maintenance KPIs
* Analyse equipment performance
* Create reusable views
* Perform advanced analytical queries

### Business Intelligence

**Microsoft Power BI**

Power BI is used to transform the SQL results into interactive dashboards covering:

* Maintenance performance
* Equipment reliability
* Maintenance costs
* Downtime
* Preventive vs corrective maintenance

### Version Control

**GitHub**

GitHub is used to document the project, store SQL scripts, datasets and Power BI documentation.

---

##  Project Structure

```text
plantpulse-maintenance-analytics/
│
├── README.md
│
├── data/
│   ├── equipment.csv
│   ├── functional_locations.csv
│   ├── maintenance_orders.csv
│   ├── notifications.csv
│   ├── technicians.csv
│   ├── spare_parts.csv
│   └── order_parts.csv
│
├── database/
│   ├── 01_create_database.sql
│   ├── 02_create_tables.sql
│   ├── 03_constraints.sql
│   └── 04_insert_data.sql
│
├── sql/
│   ├── 01_basic_queries.sql
│   ├── 02_maintenance_kpis.sql
│   ├── 03_equipment_reliability.sql
│   ├── 04_cost_analysis.sql
│   └── 05_advanced_analysis.sql
│
├── powerbi/
│   └── README.md
│
└── documentation/
    ├── data_dictionary.md
    ├── data_model.md
    └── business_questions.md
```

---

# 📈 Key Performance Indicators

PlantPulse focuses on several important maintenance KPIs.

### MTBF — Mean Time Between Failures

Measures the average operating time between equipment failures.

A higher MTBF generally indicates better equipment reliability.

### MTTR — Mean Time To Repair

Measures the average time required to restore equipment after a failure.

A lower MTTR generally indicates more efficient repair processes.

### Preventive Maintenance Rate

Measures the proportion of maintenance activities performed preventively rather than reactively.

### Maintenance Cost

Total maintenance expenditure, including:

* Labour
* Spare parts
* External services

### Downtime

Measures the amount of production time lost due to equipment failures or maintenance activities.

---

#  Business Questions

The analysis is designed to answer questions such as:

### Equipment Reliability

1. Which equipment fails most frequently?
2. Which equipment has the lowest MTBF?
3. Which equipment takes the longest to repair?
4. Which assets generate the most downtime?

### Maintenance Costs

5. Which production lines have the highest maintenance costs?
6. Which equipment consumes the most maintenance resources?
7. What percentage of costs comes from labour versus spare parts?
8. How are maintenance costs changing over time?

### Maintenance Strategy

9. What percentage of maintenance is preventive versus corrective?
10. Does higher preventive maintenance correlate with fewer failures?
11. Which assets should receive additional preventive maintenance?

### Operations

12. Which technicians have the highest workload?
13. What types of failures are most common?
14. Which production areas experience the most maintenance activity?

---

#  SQL Skills Demonstrated

The SQL component progressively increases in complexity.

### Basic SQL

* `SELECT`
* `WHERE`
* `ORDER BY`
* `GROUP BY`
* `DISTINCT`
* Aggregate functions

### Intermediate SQL

* `INNER JOIN`
* `LEFT JOIN`
* `CASE`
* `HAVING`
* Subqueries
* Date functions

### Advanced SQL

* Common Table Expressions
* Window functions
* `RANK()`
* `ROW_NUMBER()`
* `LAG()`
* `LEAD()`
* Running totals
* Moving averages
* Multi-table analytical queries

---

# Power BI Dashboard

The Power BI component will provide an interactive view of the plant's maintenance performance.

### Maintenance Overview

Key metrics:

* Total maintenance cost
* Number of maintenance orders
* Number of failures
* MTBF
* MTTR
* Preventive maintenance %
* Total downtime

### Equipment Reliability

Visualisations will identify:

* Most frequently failing equipment
* Highest-cost equipment
* Highest downtime assets
* MTBF by equipment
* MTTR by equipment

### Cost Analysis

The dashboard will analyse:

* Maintenance cost over time
* Cost by production line
* Labour cost
* Spare parts cost
* Cost by maintenance type

### Maintenance Strategy

The dashboard will compare:

* Preventive maintenance
* Corrective maintenance
* Emergency maintenance
* Failure frequency
* Downtime

---

#  Analytical Approach

The project follows a simplified analytics engineering workflow:

```text
Raw Data
    ↓
Data Validation
    ↓
Relational Database
    ↓
SQL Transformation
    ↓
Analytical Data Models
    ↓
KPI Calculation
    ↓
Power BI
    ↓
Business Insights
```

The goal is not simply to produce SQL queries, but to demonstrate how raw operational data can become useful information for decision-making.

---

#  Expected Business Insights

The final analysis will aim to identify areas such as:

* Equipment requiring additional preventive maintenance
* Assets responsible for disproportionate maintenance costs
* Production lines with recurring reliability problems
* Opportunities to reduce downtime
* Spare parts with unusually high consumption
* Maintenance processes that could be optimized

Recommendations will be based on the data rather than predefined assumptions.

---

#  Disclaimer

PlantPulse is a **fictional portfolio project**.

The data is simulated and does not represent a real manufacturing company or actual company maintenance records.

The project is inspired by common industrial maintenance processes and enterprise asset management concepts.

---

#  Project Goals

This project was created to develop and demonstrate practical skills in:

* SQL
* Relational database design
* Data modelling
* Data analysis
* Maintenance analytics
* KPI development
* Power BI
* Business intelligence
* Git/GitHub
* Industrial maintenance processes

The project also explores how operational maintenance data can support **data-driven maintenance and reliability decisions**.

---

##  Author

**Felipe Paes**

This project is part of my development in **data analytics, SQL, business intelligence and industrial maintenance**, combining technical data skills with practical knowledge of maintenance processes.
