# Data Dictionary

## Overview

This document describes the tables and fields used in the Factory Maintenance Analytics project.

The database represents a fictional manufacturing facility and contains simulated maintenance, equipment, technician and spare-parts data.

---

# 1. Functional Locations

The `functional_locations` table represents the physical or organizational areas within the factory.

| Column | Data Type | Description |
|---|---|---|
| functional_location_id | VARCHAR(20) | Unique identifier for the functional location |
| location_name | VARCHAR(100) | Name of the location |
| area | VARCHAR(50) | General factory area |

### Example

| functional_location_id | location_name | area |
|---|---|---|
| FL-100 | Production Hall A | Production |
| FL-200 | Production Hall B | Production |
| FL-300 | Packaging Area | Packaging |

---

# 2. Equipment

The `equipment` table contains the maintainable assets installed throughout the factory.

| Column | Data Type | Description |
|---|---|---|
| equipment_id | VARCHAR(20) | Unique equipment identifier |
| equipment_name | VARCHAR(100) | Equipment name/code |
| equipment_type | VARCHAR(50) | Type of equipment |
| functional_location_id | VARCHAR(20) | Functional location where the equipment is installed |
| installation_year | INT | Year the equipment was installed |
| criticality | VARCHAR(20) | Importance of the equipment to operations |
| status | VARCHAR(30) | Current operational status |

### Criticality

Equipment can have one of four criticality levels:

- Critical
- High
- Medium
- Low

Criticality is used to help identify assets where maintenance failures may have a greater operational impact.

---

# 3. Technicians

The `technicians` table contains information about maintenance personnel.

| Column | Data Type | Description |
|---|---|---|
| technician_id | VARCHAR(20) | Unique technician identifier |
| technician_name | VARCHAR(100) | Technician name |
| specialty | VARCHAR(50) | Main technical specialty |
| skill_level | VARCHAR(30) | Technician experience level |

### Specialties

Examples include:

- Mechanical
- Electrical
- Automation
- Hydraulics
- Multi-skilled

### Skill Levels

- Junior
- Technician
- Senior

---

# 4. Spare Parts

The `spare_parts` table contains materials that can be consumed during maintenance activities.

| Column | Data Type | Description |
|---|---|---|
| spare_part_id | VARCHAR(20) | Unique spare-part identifier |
| part_name | VARCHAR(100) | Name of the spare part |
| category | VARCHAR(50) | Spare-part category |
| unit_cost | DECIMAL(12,2) | Cost of one unit |
| stock_quantity | INT | Current simulated stock quantity |

### Examples

- Bearings
- Motor couplings
- Filters
- Sensors
- Belts
- Contactors
- Gearboxes
- Hydraulic hoses

---

# 5. Notifications

The `notifications` table represents maintenance issues, requests and reported equipment problems.

| Column | Data Type | Description |
|---|---|---|
| notification_id | VARCHAR(20) | Unique notification identifier |
| equipment_id | VARCHAR(20) | Equipment associated with the notification |
| created_date | DATE | Date the notification was created |
| notification_type | VARCHAR(50) | Type of maintenance notification |
| priority | VARCHAR(20) | Priority assigned to the notification |
| status | VARCHAR(30) | Current notification status |

### Notification Types

Examples include:

- Breakdown
- Inspection
- Preventive Request
- Condition Monitoring

A `Breakdown` notification represents an equipment failure and is used in failure analysis.

---

# 6. Maintenance Orders

The `maintenance_orders` table is the main fact table for the project.

It represents maintenance work performed or planned on equipment.

| Column | Data Type | Description |
|---|---|---|
| maintenance_order_id | VARCHAR(20) | Unique maintenance order identifier |
| notification_id | VARCHAR(20) | Notification that generated the order |
| equipment_id | VARCHAR(20) | Equipment being maintained |
| technician_id | VARCHAR(20) | Technician responsible for the order |
| order_date | DATE | Date of the maintenance order |
| maintenance_type | VARCHAR(30) | Preventive or Corrective |
| priority | VARCHAR(20) | Maintenance priority |
| status | VARCHAR(30) | Order status |
| labour_hours | DECIMAL(10,2) | Hours spent performing the work |
| downtime_hours | DECIMAL(10,2) | Equipment downtime associated with the order |
| labour_cost | DECIMAL(12,2) | Labour cost |
| material_cost | DECIMAL(12,2) | Spare-parts/material cost |
| total_cost | DECIMAL(12,2) | Total maintenance cost |

### Maintenance Types

#### Preventive

Maintenance performed as part of a planned activity intended to reduce the probability of failure.

#### Corrective

Maintenance performed to restore equipment following a fault or failure.

---

# 7. Order Parts

The `order_parts` table connects maintenance orders with the spare parts used during the work.

| Column | Data Type | Description |
|---|---|---|
| maintenance_order_id | VARCHAR(20) | Maintenance order |
| spare_part_id | VARCHAR(20) | Spare part used |
| quantity | INT | Quantity consumed |
| material_cost | DECIMAL(12,2) | Total cost of the consumed quantity |

This table represents a many-to-many relationship between maintenance orders and spare parts.

---

# Relationships

The main database relationships are:

```text
Functional Locations
        │
        │ 1:N
        ▼
    Equipment
        │
        │ 1:N
        ├──────────────────┐
        ▼                  ▼
 Notifications      Maintenance Orders
                          │
                    ┌─────┴─────┐
                    ▼           ▼
              Technicians    Order Parts
                                │
                                ▼
                           Spare Parts
