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
-- INSERT INTO roles_usuarios (usercod, 'cliente', 'ACT', NOW(), ...)
