USE nwdb;

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS pagos;
DROP TABLE IF EXISTS detalle_compra;
DROP TABLE IF EXISTS compras;
DROP TABLE IF EXISTS carrito;

DROP TABLE IF EXISTS viajes;
DROP TABLE IF EXISTS horarios_viaje;
DROP TABLE IF EXISTS rutas;
DROP TABLE IF EXISTS buses;

SET FOREIGN_KEY_CHECKS = 1;

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
-- TABLA HORARIOS (PLANTILLA)
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
-- TABLA VIAJES (DINÁMICA POR FECHA)
-- ========================
CREATE TABLE viajes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    horario_id INT NOT NULL,
    fecha DATE NOT NULL,
    asientos_disponibles INT NOT NULL,
    FOREIGN KEY (horario_id) REFERENCES horarios_viaje(id)
);

-- ========================
-- TABLA CARRITO
-- ========================
CREATE TABLE carrito (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usercod BIGINT NOT NULL,
    horario_id INT NOT NULL,
    fecha DATE NOT NULL,
    tipo_asiento VARCHAR(20) NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    fecha_creacion DATETIME NOT NULL,

    FOREIGN KEY (usercod) REFERENCES usuario(usercod),
    FOREIGN KEY (horario_id) REFERENCES horarios_viaje(id)
);

-- ========================
-- TABLA COMPRAS
-- ========================
CREATE TABLE compras (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usercod BIGINT NOT NULL,
    fecha DATETIME NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    estado VARCHAR(20) NOT NULL,

    FOREIGN KEY (usercod) REFERENCES usuario(usercod)
);

-- ========================
-- TABLA DETALLE COMPRA
-- ========================
CREATE TABLE detalle_compra (
    id INT AUTO_INCREMENT PRIMARY KEY,
    compra_id INT NOT NULL,
    horario_id INT NOT NULL,
    fecha DATE NOT NULL,
    tipo_asiento VARCHAR(20) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    cantidad INT NOT NULL,

    FOREIGN KEY (compra_id) REFERENCES compras(id),
    FOREIGN KEY (horario_id) REFERENCES horarios_viaje(id)
);

-- ========================
-- TABLA PAGOS
-- ========================
DROP TABLE IF EXISTS pagos;

CREATE TABLE pagos (
    id INT AUTO_INCREMENT PRIMARY KEY,

    compra_id INT NOT NULL,

    metodo VARCHAR(50) NOT NULL DEFAULT 'PAYPAL',

    estado VARCHAR(30) NOT NULL, -- COMPLETED, FAILED, etc

    paypal_order_id VARCHAR(100),      -- ID de orden (ORDER ID)
    paypal_capture_id VARCHAR(100),    -- ID real de la transacción

    payer_nombre VARCHAR(150),
    payer_email VARCHAR(150),

    payer_id VARCHAR(100),

    monto DECIMAL(10,2) NOT NULL,

    moneda VARCHAR(10) DEFAULT 'L.',

    direccion TEXT,

    json_response LONGTEXT, -- 🔥 GUARDAS TODO EL JSON COMPLETO

    fecha DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (compra_id) REFERENCES compras(id)
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
-- INSERT HORARIOS (FIJOS)
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

-- ========================
-- VIAJES (SOLO HOY PARA MOSTRAR CATÁLOGO)
-- ========================
INSERT INTO viajes (horario_id, fecha, asientos_disponibles) VALUES
(1, CURDATE(), 45),
(2, CURDATE(), 45),
(3, CURDATE(), 45),
(4, CURDATE(), 45),
(5, CURDATE(), 45),
(6, CURDATE(), 45),
(7, CURDATE(), 45),
(8, CURDATE(), 45),
(9, CURDATE(), 45),
(10, CURDATE(), 45),
(11, CURDATE(), 45),
(12, CURDATE(), 45);

USE nwdb;

-- ========================
-- FUNCIONES NUEVAS
-- ========================

INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES
-- MENÚ
('Menu_Checkout', 'Acceso al carrito', 'ACT', 'MNU'),
-- CONTROLADORES
('Checkout_Checkout', 'Ver carrito', 'ACT', 'CTR'),
('Checkout_Add', 'Agregar al carrito', 'ACT', 'CTR'),
('Checkout_Remove', 'Eliminar del carrito', 'ACT', 'CTR'),
('Checkout_Confirm', 'Confirmar compra', 'ACT', 'CTR'),
('Checkout_Success', 'Compra exitosa', 'ACT', 'CTR');



-- ========================
-- ASIGNAR A ADMIN
-- ========================

INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp)
SELECT 'admin', fncod, 'ACT', '2030-01-01'
FROM funciones
WHERE fncod IN (
    'Menu_Checkout',
    'Checkout_Checkout',
    'Checkout_Add',
    'Checkout_Remove',
    'Checkout_Confirm',
    'Checkout_Success'
);



-- ========================
-- ASIGNAR A CLIENTE
-- ========================

INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp)
SELECT 'cliente', fncod, 'ACT', '2030-01-01'
FROM funciones
WHERE fncod IN (
    'Checkout_Checkout',
    'Checkout_Add',
    'Checkout_Remove',
    'Checkout_Confirm',
    'Checkout_Success'
);

INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES
('Checkout_Update', 'Actualizar carrito', 'ACT', 'CTR');

INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp)
SELECT 'admin', fncod, 'ACT', '2030-01-01'
FROM funciones
WHERE fncod LIKE 'Checkout_%';

INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp)
SELECT 'cliente', fncod, 'ACT', '2030-01-01'
FROM funciones
WHERE fncod LIKE 'Checkout_%';

INSERT INTO funciones (fncod, fndsc, fnest, fntyp)
VALUES ('Checkout_Accept', 'PayPal Accept', 'ACT', 'CTR');

INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp)
VALUES ('admin', 'Checkout_Accept', 'ACT', '2030-01-01');

INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp)
VALUES ('cliente', 'Checkout_Accept', 'ACT', '2030-01-01');

INSERT INTO funciones (fncod, fndsc, fnest, fntyp)
VALUES ('Checkout_Error', 'PayPal Error', 'ACT', 'CTR');

INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp)
VALUES 
('admin', 'Checkout_Error', 'ACT', '2030-01-01'),
('cliente', 'Checkout_Error', 'ACT', '2030-01-01');

INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp)
VALUES 
('admin', 'Checkout_Update', 'ACT', '2030-01-01'),
('cliente', 'Checkout_Update', 'ACT', '2030-01-01');

INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES 
('Menu_Mantenimientos_Compras', 'Menú Compras Admin', 'ACT', 'MNU');

INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES 
('admin', 'Compra_Historial', 'ACT', '2030-01-01 00:00:00'),
('admin', 'Menu_Compra_Historial', 'ACT', '2030-01-01 00:00:00'),
('admin', 'Menu_Mantenimientos_Compras', 'ACT', '2030-01-01 00:00:00');

SELECT * FROM compras WHERE usercod = 1;