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
