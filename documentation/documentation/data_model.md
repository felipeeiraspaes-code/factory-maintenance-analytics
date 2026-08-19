

# Data Model

## Overview

The Factory Maintenance Analytics database uses a relational data model designed to represent a simplified industrial maintenance environment.

The model separates:

- Factory locations
- Equipment
- Maintenance notifications
- Maintenance orders
- Technicians
- Spare parts

This structure allows maintenance activity to be analysed from multiple perspectives.

---

# Entity Relationship Overview

```text
                         ┌──────────────────────┐
                         │ Functional Locations │
                         │                      │
                         │ PK functional_       │
                         │    location_id       │
                         └──────────┬───────────┘
                                    │
                                    │ 1:N
                                    ▼
                         ┌──────────────────────┐
                         │      Equipment       │
                         │                      │
                         │ PK equipment_id      │
                         │ FK functional_       │
                         │    location_id       │
                         └───────┬──────────────┘
                                 │
                     ┌───────────┴────────────┐
                     │                        │
                     │ 1:N                    │ 1:N
                     ▼                        ▼
          ┌────────────────────┐   ┌─────────────────────┐
          │   Notifications    │   │ Maintenance Orders  │
          │                    │   │                     │
          │ PK notification_id │   │ PK order_id         │
          │ FK equipment_id    │   │ FK equipment_id     │
          └─────────┬──────────┘   │ FK notification_id  │
                    │              │ FK technician_id    │
                    │              └──────┬──────────────┘
                    │                     │
                    │                     │ N:1
                    │                     ▼
                    │              ┌──────────────┐
                    │              │ Technicians  │
                    │              │              │
                    │              │ PK technician│
                    │              │    _id       │
                    │              └──────────────┘
                    │
                    │
                    │              ┌────────────────┐
                    │              │  Order Parts   │
                    │              │                │
                    │              │ FK order_id    │
                    │              │ FK spare_part  │
                    │              └───────┬────────┘
                    │                      │
                    │                      │ N:1
                    │                      ▼
                    │               ┌──────────────┐
                    │               │ Spare Parts  │
                    │               │              │
                    │               │ PK spare_    │
                    │               │    part_id   │
                    │               └──────────────┘
