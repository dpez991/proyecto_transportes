USE nwdb;

-- ========================
-- TABLA BUSES
-- ========================
CREATE TABLE buses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    codigo_bus VARCHAR(50) NOT NULL,
    capacidad INT NOT NULL DEFAULT 45,
    estado BOOLEAN DEFAULT TRUE
);

-- ========================
-- TABLA RUTAS
-- ========================
CREATE TABLE rutas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    origen VARCHAR(100) NOT NULL,
    destino VARCHAR(100) NOT NULL,
    estado BOOLEAN DEFAULT TRUE
);

-- ========================
-- TABLA HORARIOS
-- ========================
CREATE TABLE horarios_viaje (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ruta_id INT NOT NULL,
    bus_id INT NOT NULL,
    hora TIME NOT NULL,
    estado BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (ruta_id) REFERENCES rutas(id),
    FOREIGN KEY (bus_id) REFERENCES buses(id)
);

-- ========================
-- TABLA VIAJES (DINÁMICA)
-- ========================
CREATE TABLE viajes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    horario_id INT NOT NULL,
    fecha DATE NOT NULL,
    asientos_disponibles INT NOT NULL,
    FOREIGN KEY (horario_id) REFERENCES horarios_viaje(id)
);

-- ========================
-- INSERT BUSES
-- ========================
INSERT INTO buses (codigo_bus, capacidad, estado) VALUES
('BUS-001', 45, TRUE),
('BUS-002', 45, TRUE),
('BUS-003', 45, TRUE),
('BUS-004', 45, TRUE),
('BUS-005', 45, TRUE),
('BUS-006', 45, TRUE);

-- ========================
-- INSERT RUTAS
-- ========================
INSERT INTO rutas (origen, destino, estado) VALUES
('Tegucigalpa','Choluteca', TRUE),
('Choluteca','Tegucigalpa', TRUE),
('Tegucigalpa','San Pedro Sula', TRUE),
('San Pedro Sula','Tegucigalpa', TRUE),
('Tegucigalpa','Copán', TRUE),
('Copán','Tegucigalpa', TRUE),
('Tegucigalpa','La Ceiba', TRUE),
('La Ceiba','Tegucigalpa', TRUE),
('Tegucigalpa','Comayagua', TRUE),
('Comayagua','Tegucigalpa', TRUE),
('Tegucigalpa','Danlí', TRUE),
('Danlí','Tegucigalpa', TRUE);

-- ========================
-- INSERT HORARIOS
-- ========================
INSERT INTO horarios_viaje (ruta_id, bus_id, hora, estado) VALUES
(1, 1, '08:00:00', TRUE),
(2, 2, '10:00:00', TRUE),
(3, 3, '06:00:00', TRUE),
(4, 4, '14:00:00', TRUE),
(5, 5, '07:30:00', TRUE),
(6, 6, '15:00:00', TRUE),
(7, 1, '05:45:00', TRUE),
(8, 2, '13:30:00', TRUE),
(9, 3, '09:00:00', TRUE),
(10, 4, '16:00:00', TRUE),
(11, 5, '07:00:00', TRUE),
(12, 6, '17:00:00', TRUE);

INSERT INTO viajes (horario_id, fecha, asientos_disponibles) VALUES
(1, '2026-04-15', 45),
(2, '2026-04-15', 45),
(3, '2026-04-15', 45),
(4, '2026-04-15', 45),
(5, '2026-04-15', 45),
(6, '2026-04-15', 45),
(7, '2026-04-15', 45),
(8, '2026-04-15', 45),
(9, '2026-04-15', 45),
(10, '2026-04-15', 45),
(11, '2026-04-15', 45),
(12, '2026-04-15', 45);