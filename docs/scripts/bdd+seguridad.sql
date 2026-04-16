USE nwdb;

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS funciones_roles;
DROP TABLE IF EXISTS roles_usuarios;
DROP TABLE IF EXISTS funciones;
DROP TABLE IF EXISTS roles;
DROP TABLE IF EXISTS usuario;
DROP TABLE IF EXISTS bitacora;

SET FOREIGN_KEY_CHECKS = 1;

-- ========================
-- TABLAS
-- ========================

CREATE TABLE usuario (
    usercod bigint AUTO_INCREMENT PRIMARY KEY,
    useremail varchar(80) UNIQUE,
    username varchar(80),
    userpswd varchar(128),
    userfching datetime,
    userpswdest char(3),
    userpswdexp datetime,
    userest char(3),
    useractcod varchar(128),
    userpswdchg varchar(128),
    usertipo char(3)
);

CREATE TABLE roles (
    rolescod varchar(128) PRIMARY KEY,
    rolesdsc varchar(45),
    rolesest char(3)
);

CREATE TABLE funciones (
    fncod varchar(255) PRIMARY KEY,
    fndsc varchar(255),
    fnest char(3),
    fntyp char(3)
);

CREATE TABLE roles_usuarios (
    usercod bigint,
    rolescod varchar(128),
    roleuserest char(3),
    roleuserfch datetime,
    roleuserexp datetime,
    PRIMARY KEY (usercod, rolescod),
    FOREIGN KEY (usercod) REFERENCES usuario(usercod),
    FOREIGN KEY (rolescod) REFERENCES roles(rolescod)
);

CREATE TABLE funciones_roles (
    rolescod varchar(128),
    fncod varchar(255),
    fnrolest char(3),
    fnexp datetime,
    PRIMARY KEY (rolescod, fncod),
    FOREIGN KEY (rolescod) REFERENCES roles(rolescod),
    FOREIGN KEY (fncod) REFERENCES funciones(fncod)
);

CREATE TABLE bitacora (
    bitacoracod int AUTO_INCREMENT PRIMARY KEY,
    bitacorafch datetime,
    bitprograma varchar(255),
    bitdescripcion varchar(255),
    bitobservacion mediumtext,
    bitTipo char(3),
    bitusuario bigint
);

-- ========================
-- ROLES BASE
-- ========================

INSERT INTO roles (rolescod, rolesdsc, rolesest) VALUES
('admin', 'Administrador del sistema', 'ACT'),
('cliente', 'Cliente del sistema', 'ACT');

-- ========================
-- FUNCIONES (SEGÚN TU SISTEMA ACTUAL)
-- ========================

INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES

-- MENÚS
('Menu_Mantenimiento_Usuarios', 'Menu_Mantenimiento_Usuarios', 'ACT', 'MNU'),
('Menu_Mantenimiento_Roles', 'Menu_Mantenimiento_Roles', 'ACT', 'MNU'),
('Menu_PaymentCheckout', 'Menu_PaymentCheckout', 'ACT', 'MNU'),

-- USUARIOS
('Mantenimientos_Usuarios_Listado', 'Listado Usuarios', 'ACT', 'CTR'),
('Mantenimientos_Usuarios_Formulario', 'Formulario Usuarios', 'ACT', 'CTR'),
('Mantenimientos_Usuarios_Usuario', 'CRUD Usuarios', 'ACT', 'PRG'),

-- ROLES
('Mantenimientos_Roles_Listado', 'Listado Roles', 'ACT', 'CTR'),
('Mantenimientos_Roles_Formulario', 'Formulario Roles', 'ACT', 'CTR'),
('Mantenimientos_Roles_Rol', 'CRUD Roles', 'ACT', 'PRG');

-- ========================
-- ASIGNAR TODO AL ADMIN
-- ========================

INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp)
SELECT 'admin', fncod, 'ACT', '2030-01-01'
FROM funciones;

-- ========================
-- NOTA IMPORTANTE USUARIOS
-- ========================

-- ⚠️ NO insertar usuarios manualmente
-- porque las contraseñas están encriptadas

-- ✔ CREAR USUARIOS DESDE REGISTER
-- ✔ Automáticamente se asigna el rol 'cliente'

-- ========================
-- EJEMPLO DE LO QUE PASA INTERNAMENTE (NO EJECUTAR)
-- ========================

-- INSERT INTO usuario (...)
-- INSERT INTO roles_usuarios (usercod, 'cliente', 'ACT', NOW(), ...

USE nwdb;

-- ========================
-- NUEVAS FUNCIONES (MENÚS)
-- ========================

INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES
('Menu_Admin_Dashboard', 'Menu Dashboard', 'ACT', 'MNU'),
('Menu_Mantenimiento_Rutas', 'Menu Mantenimiento Rutas', 'ACT', 'MNU'),
('Menu_Mantenimiento_Buses', 'Menu Mantenimiento Buses', 'ACT', 'MNU'),
('Menu_Mantenimiento_Viajes', 'Menu Mantenimiento Viajes', 'ACT', 'MNU'),
('Menu_Mantenimiento_Compras', 'Menu Gestion de Compras', 'ACT', 'MNU');

-- ========================
-- CONTROLADORES (CTR)
-- ========================

INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES
('Admin_Dashboard', 'Dashboard Admin', 'ACT', 'CTR'),

('Mantenimientos_Rutas_Listado', 'Listado Rutas', 'ACT', 'CTR'),
('Mantenimientos_Rutas_Formulario', 'Formulario Rutas', 'ACT', 'CTR'),

('Mantenimientos_Buses_Listado', 'Listado Buses', 'ACT', 'CTR'),
('Mantenimientos_Buses_Formulario', 'Formulario Buses', 'ACT', 'CTR'),

('Mantenimientos_Viajes_Listado', 'Listado Viajes', 'ACT', 'CTR'),
('Mantenimientos_Viajes_Formulario', 'Formulario Viajes', 'ACT', 'CTR'),

('Mantenimientos_Compras_Listado', 'Listado Compras', 'ACT', 'CTR');

-- ========================
-- PROGRAMAS (PRG)
-- ========================

INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES
('Mantenimientos_Rutas_Ruta', 'CRUD Rutas', 'ACT', 'PRG'),
('Mantenimientos_Buses_Bus', 'CRUD Buses', 'ACT', 'PRG'),
('Mantenimientos_Viajes_Viaje', 'CRUD Viajes', 'ACT', 'PRG'),
('Mantenimientos_Compras_Compra', 'CRUD Compras', 'ACT', 'PRG');

-- ========================
-- ASIGNAR TODO AL ADMIN
-- ========================

INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp)
SELECT 'admin', fncod, 'ACT', '2030-01-01'
FROM funciones f
WHERE NOT EXISTS (
    SELECT 1 FROM funciones_roles fr
    WHERE fr.rolescod = 'admin'
    AND fr.fncod = f.fncod
);



--================================================================================
--tablas para panel ADMINISTRADOR
--================================================================================

--Aca estan incluidas las tablas de rutas y viajes que se necesitan para el panel de administrador, 
--pero tambien para el cliente, por lo que se incluyen aqui para evitar problemas de integridad 
--referencial al momento de crear las tablas de viajes y rutas, ya que estas son necesarias para la 
--tabla de compras que se 
--relaciona con la tabla de usuario.
--
USE nwdb;

CREATE TABLE `rutas` (
    `rutaId` int(11) NOT NULL AUTO_INCREMENT,
    `origen` varchar(100) NOT NULL,
    `destino` varchar(100) NOT NULL,
    `estado` char(3) NOT NULL DEFAULT 'ACT',
    PRIMARY KEY (`rutaId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `buses` (
    `busId` int(12) NOT NULL AUTO_INCREMENT,
    `numeroBus` varchar(50) NOT NULL,
    `placa` varchar(20) NOT NULL,
    `capacidad` int NOT NULL DEFAULT 45,
    `busest` char(3) NOT NULL DEFAULT 'ACT',
    PRIMARY KEY (`busId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `viajes` (
    `viajeId` int(12) NOT NULL AUTO_INCREMENT,
    `rutaId` int(12) NOT NULL,
    `busId` int(12) DEFAULT NULL,
    `fecha` date NOT NULL,
    `hora` time NOT NULL,
    `asientosDisponibles` int NOT NULL,
    `estado` char(3) NOT NULL DEFAULT 'ACT',
    PRIMARY KEY (`viajeId`),
    KEY `ruta_idx` (`rutaId`),
    KEY `bus_idx` (`busId`),
    CONSTRAINT `viaje_ruta_fk`
        FOREIGN KEY (`rutaId`)
        REFERENCES `rutas` (`rutaId`),
    CONSTRAINT `viaje_bus_fk`
        FOREIGN KEY (`busId`)
        REFERENCES `buses` (`busId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `compras` (
    `compraId` int NOT NULL AUTO_INCREMENT,
    `usercod` bigint NOT NULL,
    `viajeId` int(12) NOT NULL,
    `cantidadAsientos` int NOT NULL DEFAULT 1,
    `total` decimal(10,2) NOT NULL,
    `fechacompra` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `compraest` char(3) NOT NULL DEFAULT 'ACT',
    PRIMARY KEY (`compraId`),
    KEY `compras_usuario_idx` (`usercod`),
    KEY `compras_viaje_idx` (`viajeId`),
    CONSTRAINT `compras_usuario_fk`
        FOREIGN KEY (`usercod`)
        REFERENCES `usuario` (`usercod`),
    CONSTRAINT `compras_viaje_fk`
        FOREIGN KEY (`viajeId`)
        REFERENCES `viajes` (`viajeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;