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
-- TABLA VIAJES
-- ========================
CREATE TABLE viajes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ruta_id INT NOT NULL,
    bus_id INT NOT NULL,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    asientos_disponibles INT NOT NULL,
    FOREIGN KEY (ruta_id) REFERENCES rutas(id),
    FOREIGN KEY (bus_id) REFERENCES buses(id)
);

INSERT INTO buses (codigo_bus, capacidad, estado) VALUES
('BUS-001', 45, TRUE),
('BUS-002', 45, TRUE),
('BUS-003', 45, TRUE),
('BUS-004', 45, TRUE),
('BUS-005', 45, TRUE),
('BUS-006', 45, TRUE);

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

INSERT INTO viajes (ruta_id, bus_id, fecha, hora, asientos_disponibles) VALUES
(1, 1, '2026-05-01', '08:00:00', 45),
(2, 2, '2026-05-01', '10:00:00', 45),
(3, 3, '2026-05-01', '06:00:00', 45),
(4, 4, '2026-05-01', '14:00:00', 45),

(5, 5, '2026-05-02', '07:30:00', 45),
(6, 6, '2026-05-02', '15:00:00', 45),

(7, 1, '2026-05-03', '05:45:00', 45),
(8, 2, '2026-05-03', '13:30:00', 45),

(9, 3, '2026-05-04', '09:00:00', 45),
(10, 4, '2026-05-04', '16:00:00', 45),

(11, 5, '2026-05-05', '07:00:00', 45),
(12, 6, '2026-05-05', '17:00:00', 45);