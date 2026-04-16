USE nwdb;

-- ROLES
INSERT INTO roles VALUES
('admin', 'Administrador del sistema', 'ACT'),
('cliente', 'Cliente del sistema', 'ACT');

-- BUSES
INSERT INTO buses VALUES
(NULL,'BUS-001',45,1),
(NULL,'BUS-002',45,1),
(NULL,'BUS-003',45,1),
(NULL,'BUS-004',45,1),
(NULL,'BUS-005',45,1),
(NULL,'BUS-006',45,1);

-- RUTAS
INSERT INTO rutas VALUES
(NULL,'Tegucigalpa','Choluteca',1),
(NULL,'Choluteca','Tegucigalpa',1),
(NULL,'Tegucigalpa','San Pedro Sula',1),
(NULL,'San Pedro Sula','Tegucigalpa',1),
(NULL,'Tegucigalpa','Copán',1),
(NULL,'Copán','Tegucigalpa',1),
(NULL,'Tegucigalpa','La Ceiba',1),
(NULL,'La Ceiba','Tegucigalpa',1),
(NULL,'Tegucigalpa','Comayagua',1),
(NULL,'Comayagua','Tegucigalpa',1),
(NULL,'Tegucigalpa','Danlí',1),
(NULL,'Danlí','Tegucigalpa',1);

-- HORARIOS
INSERT INTO horarios_viaje VALUES
(NULL,1,1,'08:00:00',1),
(NULL,2,2,'10:00:00',1),
(NULL,3,3,'06:00:00',1),
(NULL,4,4,'14:00:00',1),
(NULL,5,5,'07:30:00',1),
(NULL,6,6,'15:00:00',1),
(NULL,7,1,'05:45:00',1),
(NULL,8,2,'13:30:00',1),
(NULL,9,3,'09:00:00',1),
(NULL,10,4,'16:00:00',1),
(NULL,11,5,'07:00:00',1),
(NULL,12,6,'17:00:00',1);