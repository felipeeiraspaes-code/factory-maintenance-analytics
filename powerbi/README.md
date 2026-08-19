# Power BI — Factory Maintenance Analytics

## Overview

This Power BI component provides an interactive dashboard for analysing maintenance activities within a fictional manufacturing facility.

The dashboard connects to the **Factory Maintenance Analytics** SQL Server database and transforms maintenance data into operational and management insights.

The main objective is to help answer:

> **Which equipment, production areas and maintenance activities are having the greatest impact on cost, reliability and downtime?**

---

## Data Source

The Power BI model uses data from the following SQL Server tables:

- `functional_locations`
- `equipment`
- `notifications`
- `maintenance_orders`
- `technicians`
- `spare_parts`
- `order_parts`

The primary fact table is:

**`maintenance_orders`**

The remaining tables provide additional information about equipment, locations, technicians, notifications and spare parts.

---

## Data Model

The Power BI model follows a relational structure based on the maintenance database.

```text
                    Functional Locations
                            │
                            │
                            ▼
                        Equipment
                            │
                            │
                            ▼
                    Maintenance Orders
                       /          \
                      /            \
                     ▼              ▼
              Technicians      Notifications
                                    
Maintenance Orders
        │
        ▼
    Order Parts
        │
        ▼
    Spare Parts

# Dashboard Structure

The Power BI report is divided into four main pages.

---

## 1. Maintenance Overview

The **Maintenance Overview** page provides a high-level view of the overall maintenance performance of the factory.

### Key Performance Indicators

The dashboard displays:

* Total Maintenance Cost
* Number of Maintenance Orders
* Total Downtime
* MTTR
* Preventive Maintenance %
* Number of Failures

### Visualisations

The page includes:

* Maintenance Cost by Month
* Preventive vs Corrective Maintenance
* Maintenance Cost by Production Area
* Maintenance Orders by Month
* Maintenance Cost by Maintenance Type

### Filters

Users can filter the dashboard by:

* Year
* Production Area
* Equipment Type
* Criticality
* Maintenance Type
* Priority

---

## 2. Equipment Reliability

The **Equipment Reliability** page focuses on identifying equipment that requires attention.

### Key Metrics

* Failure Frequency
* MTTR
* Downtime
* Maintenance Cost
* Number of Corrective Maintenance Orders

### Main Visualisations

#### Top Equipment by Downtime

Identifies the equipment responsible for the largest amount of downtime.

#### Top Equipment by Maintenance Cost

Identifies assets that consume the greatest amount of maintenance resources.

#### Equipment Failure Frequency

Shows which assets experience the highest number of breakdowns.

#### Equipment Reliability Table

The table provides:

| Equipment   | Type  | Criticality | Failures |  MTTR | Downtime |   Cost |
| ----------- | ----- | ----------- | -------: | ----: | -------: | -----: |
| Equipment A | Motor | Critical    |       12 | 5.2 h |   62.4 h | €8,450 |
| Equipment B | Pump  | High        |        9 | 4.1 h |   36.9 h | €6,230 |

This allows individual equipment to be compared directly.

---

## 3. Cost Analysis

The **Cost Analysis** page focuses on understanding where maintenance expenditure is being generated.

### Key Metrics

* Total Maintenance Cost
* Labour Cost
* Material Cost
* Average Maintenance Order Cost

### Main Visualisations

#### Maintenance Cost Trend

Shows how maintenance expenditure changes over time.

#### Labour vs Material Cost

Compares the two main components of maintenance expenditure.

#### Cost by Production Area

Identifies which areas of the factory have the highest maintenance costs.

#### Spare Parts Cost

Shows which spare parts contribute most to material expenditure.

#### Equipment Cost Ranking

Ranks equipment according to total maintenance expenditure.

---

## 4. Maintenance Strategy

The **Maintenance Strategy** page compares preventive and corrective maintenance.

### Key Metrics

* Preventive Maintenance %
* Preventive Maintenance Orders
* Corrective Maintenance Orders
* Preventive Maintenance Cost
* Corrective Maintenance Cost
* Corrective Downtime

### Main Visualisations

* Preventive vs Corrective Maintenance
* Preventive vs Corrective Orders Over Time
* Corrective Cost by Equipment
* Downtime by Maintenance Type
* Maintenance Cost by Maintenance Type

The purpose of this page is to identify whether maintenance activities are predominantly proactive or reactive.

---

# DAX Measures

The report uses **DAX measures** to calculate the main maintenance KPIs.

## Total Maintenance Cost

```DAX
Total Maintenance Cost =
SUM('maintenance_orders'[total_cost])
```

## Total Labour Cost

```DAX
Total Labour Cost =
SUM('maintenance_orders'[labour_cost])
```

## Total Material Cost

```DAX
Total Material Cost =
SUM('maintenance_orders'[material_cost])
```

## Maintenance Orders

```DAX
Maintenance Orders =
COUNTROWS('maintenance_orders')
```

## Total Downtime

```DAX
Total Downtime =
SUM('maintenance_orders'[downtime_hours])
```

## Total Labour Hours

```DAX
Total Labour Hours =
SUM('maintenance_orders'[labour_hours])
```

## Preventive Orders

```DAX
Preventive Orders =
CALCULATE(
    [Maintenance Orders],
    'maintenance_orders'[maintenance_type] = "Preventive"
)
```

## Corrective Orders

```DAX
Corrective Orders =
CALCULATE(
    [Maintenance Orders],
    'maintenance_orders'[maintenance_type] = "Corrective"
)
```

## Preventive Maintenance %

```DAX
Preventive Maintenance % =
DIVIDE(
    [Preventive Orders],
    [Maintenance Orders]
)
```

Format this measure as a **percentage** in Power BI.

## MTTR

**Mean Time To Repair (MTTR)** is calculated as the average downtime associated with corrective maintenance orders.

```DAX
MTTR =
CALCULATE(
    AVERAGE('maintenance_orders'[downtime_hours]),
    'maintenance_orders'[maintenance_type] = "Corrective"
)
```

## Failure Count

```DAX
Failures =
CALCULATE(
    COUNTROWS('notifications'),
    'notifications'[notification_type] = "Breakdown"
)
```

---

# Date Table

A dedicated Date table is used for time-based analysis.

Create the following table using **DAX**:

```DAX
DateTable =
ADDCOLUMNS(
    CALENDAR(
        DATE(2024,1,1),
        DATE(2026,6,30)
    ),
    "Year", YEAR([Date]),
    "Month Number", MONTH([Date]),
    "Month", FORMAT([Date], "MMMM"),
    "Year Month", FORMAT([Date], "YYYY-MM"),
    "Quarter", "Q" & FORMAT([Date], "Q")
)
```

The Date table is related to:

```text
DateTable[Date]
        ↓
maintenance_orders[order_date]
```

The `DateTable` should be configured as the official **Power BI Date table**.

The `Month` column should be sorted by `Month Number` to ensure that months appear in chronological order.

---

# Business Questions

The dashboard is designed to answer questions such as:

### Equipment

* Which equipment fails most frequently?
* Which equipment generates the most downtime?
* Which equipment has the highest maintenance cost?
* Which critical assets require additional attention?

### Costs

* How much is the factory spending on maintenance?
* What percentage of maintenance cost comes from labour?
* What percentage comes from spare parts?
* Which production areas have the highest maintenance expenditure?

### Maintenance Strategy

* What percentage of maintenance is preventive?
* How much maintenance is corrective?
* Are corrective activities increasing over time?
* Which equipment generates the highest corrective maintenance cost?

### Reliability

* Which equipment has the highest MTTR?
* Which assets experience repeated failures?
* Which equipment combines high cost, high failure frequency and high downtime?

---

# Expected Insights

The dashboard should help identify potential improvement opportunities, including:

* Equipment requiring additional preventive maintenance
* Assets with recurring failures
* Production areas with excessive maintenance costs
* High-cost spare parts
* Excessive corrective maintenance
* Opportunities to reduce equipment downtime
* Potentially inefficient maintenance processes

The final recommendations should be based on the results of the analysis rather than predetermined conclusions.

---

# Tools

The Power BI component uses:

* **Microsoft Power BI Desktop**
* **DAX**
* **SQL Server**
* **Power Query**
* **GitHub**

---

# Project Workflow

```text
Factory Maintenance Data
          ↓
      SQL Server
          ↓
    Data Modelling
          ↓
       Power BI
          ↓
    DAX Measures
          ↓
      Dashboards
          ↓
  Maintenance Insights
```

---

## Disclaimer

This is a fictional portfolio project.

The data represents simulated factory maintenance activities and does not contain real company information.

The project is designed to demonstrate practical skills in:

* SQL
* Power BI
* DAX
* Power Query
* Data Modelling
* Business Intelligence
* Maintenance Analytics
* Data Analysis
