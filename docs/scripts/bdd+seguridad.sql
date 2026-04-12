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
    useremail varchar(80),
    username varchar(80),
    userpswd varchar(128),
    userfching datetime,
    userpswdest char(3),
    userpswdexp datetime,
    userest char(3),
    useractcod varchar(128),
    userpswdchg varchar(128),
    usertipo char(3),
    UNIQUE KEY useremail_UNIQUE (useremail)
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
-- DATOS BASE
-- ========================

INSERT INTO roles VALUES
('admin', 'Administrador', 'ACT'),
('cliente', 'Cliente', 'ACT');

INSERT INTO funciones VALUES
('Menu_Mantenimiento_Usuarios', 'Menu Usuarios', 'ACT', 'MNU'),
('Mantenimientos_Usuarios_Listado', 'Listado Usuarios', 'ACT', 'CTR'),
('Mantenimientos_Usuarios_Formulario', 'Formulario Usuarios', 'ACT', 'CTR'),

('Menu_Mantenimiento_Roles', 'Menu Roles', 'ACT', 'MNU'),
('Mantenimientos_Roles_Listado', 'Listado Roles', 'ACT', 'CTR'),
('Mantenimientos_Roles_Formulario', 'Formulario Roles', 'ACT', 'CTR');

INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp)
SELECT 'admin', fncod, 'ACT', '2030-01-01'
FROM funciones;

-- USUARIO ADMIN (opcional)
INSERT INTO usuario (useremail, username, userpswd, userfching, userest, usertipo)
VALUES ('admin@admin.com', 'Admin', '123', NOW(), 'ACT', 'ADM');

INSERT INTO roles_usuarios VALUES
(1, 'admin', 'ACT', NOW(), '2030-01-01');

INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES
('Mantenimientos_Usuarios_Usuario', 'CRUD Usuarios', 'ACT', 'PRG'),
('Mantenimientos_Roles_Rol', 'CRUD Roles', 'ACT', 'PRG');

INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp)
VALUES
('admin', 'Mantenimientos_Usuarios_Usuario', 'ACT', '2030-01-01'),
('admin', 'Mantenimientos_Roles_Rol', 'ACT', '2030-01-01')
ON DUPLICATE KEY UPDATE fnrolest='ACT';

INSERT INTO funciones (fncod, fndsc, fnest, fntyp)
VALUES ('Mantenimientos_Usuarios_Formulario', 'Gestión Roles Usuario', 'ACT', 'PRG')
ON DUPLICATE KEY UPDATE fnest='ACT';