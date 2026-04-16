USE nwdb;

-- ========================
-- USUARIOS
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

-- ========================
-- ROLES
-- ========================
CREATE TABLE roles (
    rolescod varchar(128) PRIMARY KEY,
    rolesdsc varchar(45),
    rolesest char(3)
);

-- ========================
-- FUNCIONES
-- ========================
CREATE TABLE funciones (
    fncod varchar(255) PRIMARY KEY,
    fndsc varchar(255),
    fnest char(3),
    fntyp char(3)
);

-- ========================
-- ROLES USUARIOS
-- ========================
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

-- ========================
-- FUNCIONES ROLES
-- ========================
CREATE TABLE funciones_roles (
    rolescod varchar(128),
    fncod varchar(255),
    fnrolest char(3),
    fnexp datetime,
    PRIMARY KEY (rolescod, fncod),
    FOREIGN KEY (rolescod) REFERENCES roles(rolescod),
    FOREIGN KEY (fncod) REFERENCES funciones(fncod)
);