-- PlantPulse
-- 03_constraints.sql

USE PlantPulse;
GO

ALTER TABLE dbo.equipment
ADD CONSTRAINT FK_equipment_functional_location
FOREIGN KEY (functional_location_id)
REFERENCES dbo.functional_locations(functional_location_id);
GO

ALTER TABLE dbo.notifications
ADD CONSTRAINT FK_notifications_equipment
FOREIGN KEY (equipment_id)
REFERENCES dbo.equipment(equipment_id);
GO

ALTER TABLE dbo.maintenance_orders
ADD CONSTRAINT FK_orders_notification
FOREIGN KEY (notification_id)
REFERENCES dbo.notifications(notification_id);
GO

ALTER TABLE dbo.maintenance_orders
ADD CONSTRAINT FK_orders_equipment
FOREIGN KEY (equipment_id)
REFERENCES dbo.equipment(equipment_id);
GO

ALTER TABLE dbo.maintenance_orders
ADD CONSTRAINT FK_orders_technician
FOREIGN KEY (technician_id)
REFERENCES dbo.technicians(technician_id);
GO

ALTER TABLE dbo.order_parts
ADD CONSTRAINT FK_order_parts_order
FOREIGN KEY (maintenance_order_id)
REFERENCES dbo.maintenance_orders(maintenance_order_id);
GO

ALTER TABLE dbo.order_parts
ADD CONSTRAINT FK_order_parts_spare_part
FOREIGN KEY (spare_part_id)
REFERENCES dbo.spare_parts(spare_part_id);
GO

ALTER TABLE dbo.equipment
ADD CONSTRAINT CK_equipment_criticality
CHECK (criticality IN ('Critical','High','Medium','Low'));
GO

ALTER TABLE dbo.maintenance_orders
ADD CONSTRAINT CK_orders_maintenance_type
CHECK (maintenance_type IN ('Preventive','Corrective'));
GO

ALTER TABLE dbo.maintenance_orders
ADD CONSTRAINT CK_orders_nonnegative_values
CHECK (
    labour_hours >= 0
    AND downtime_hours >= 0
    AND labour_cost >= 0
    AND material_cost >= 0
);
GO

ALTER TABLE dbo.order_parts
ADD CONSTRAINT CK_order_parts_positive
CHECK (quantity > 0 AND material_cost >= 0);
GO
