USE nwdb;

-- ========================
-- BUSES
-- ========================
CREATE TABLE buses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    codigo_bus VARCHAR(50) NOT NULL,
    capacidad INT NOT NULL DEFAULT 45,
    estado BOOLEAN DEFAULT TRUE
);

-- ========================
-- RUTAS
-- ========================
CREATE TABLE rutas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    origen VARCHAR(100) NOT NULL,
    destino VARCHAR(100) NOT NULL,
    estado BOOLEAN DEFAULT TRUE
);

-- ========================
-- HORARIOS
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
-- VIAJES
-- ========================
CREATE TABLE viajes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    horario_id INT NOT NULL,
    fecha DATE NOT NULL,
    asientos_disponibles INT NOT NULL,
    FOREIGN KEY (horario_id) REFERENCES horarios_viaje(id)
);

-- ========================
-- CARRITO
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
-- COMPRAS
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
-- DETALLE COMPRA
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
-- PAGOS
-- ========================
CREATE TABLE pagos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    compra_id INT NOT NULL,
    metodo VARCHAR(50) NOT NULL DEFAULT 'PAYPAL',
    estado VARCHAR(30) NOT NULL,
    paypal_order_id VARCHAR(100),
    paypal_capture_id VARCHAR(100),
    payer_nombre VARCHAR(150),
    payer_email VARCHAR(150),
    payer_id VARCHAR(100),
    monto DECIMAL(10,2) NOT NULL,
    moneda VARCHAR(10) DEFAULT 'L.',
    direccion TEXT,
    json_response LONGTEXT,
    fecha DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (compra_id) REFERENCES compras(id)
);