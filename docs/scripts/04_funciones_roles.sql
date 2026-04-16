USE nwdb;

-- ========================
-- FUNCIONES COMPLETAS
-- ========================
INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES

-- MENÚS
('Menu_Admin_Dashboard','Dashboard','ACT','MNU'),
('Menu_Mantenimiento_Usuarios','Usuarios','ACT','MNU'),
('Menu_Mantenimiento_Roles','Roles','ACT','MNU'),
('Menu_Mantenimiento_Rutas','Rutas','ACT','MNU'),
('Menu_Mantenimiento_Buses','Buses','ACT','MNU'),
('Menu_Mantenimiento_Viajes','Viajes','ACT','MNU'),
('Menu_Mantenimiento_Compras','Compras','ACT','MNU'),
('Menu_Mantenimientos_Compras','Compras Admin','ACT','MNU'),
('Menu_Checkout','Checkout','ACT','MNU'),
('Menu_PaymentCheckout','Pago','ACT','MNU'),
('Menu_Compra_Historial','Historial Compras','ACT','MNU'),

-- CONTROLADORES
('Admin_Dashboard','Dashboard','ACT','CTR'),

('Mantenimientos_Usuarios_Listado','Usuarios','ACT','CTR'),
('Mantenimientos_Usuarios_Formulario','Usuarios','ACT','CTR'),

('Mantenimientos_Roles_Listado','Roles','ACT','CTR'),
('Mantenimientos_Roles_Formulario','Roles','ACT','CTR'),

('Mantenimientos_Rutas_Listado','Rutas','ACT','CTR'),
('Mantenimientos_Rutas_Formulario','Rutas','ACT','CTR'),

('Mantenimientos_Buses_Listado','Buses','ACT','CTR'),
('Mantenimientos_Buses_Formulario','Buses','ACT','CTR'),

('Mantenimientos_Viajes_Listado','Viajes','ACT','CTR'),
('Mantenimientos_Viajes_Formulario','Viajes','ACT','CTR'),

('Mantenimientos_Compras_Listado','Compras','ACT','CTR'),
('Mantenimientos_Compras_Detalle','Detalle Compra','ACT','CTR'),

-- PROGRAMAS (CRUD)
('Mantenimientos_Usuarios_Usuario','CRUD Usuarios','ACT','PRG'),
('Mantenimientos_Roles_Rol','CRUD Roles','ACT','PRG'),
('Mantenimientos_Rutas_Ruta','CRUD Rutas','ACT','PRG'),
('Mantenimientos_Buses_Bus','CRUD Buses','ACT','PRG'),
('Mantenimientos_Viajes_Viaje','CRUD Viajes','ACT','PRG'),
('Mantenimientos_Compras_Compra','CRUD Compras','ACT','PRG'),

-- CHECKOUT
('Checkout_Checkout','Carrito','ACT','CTR'),
('Checkout_Add','Agregar','ACT','CTR'),
('Checkout_Remove','Eliminar','ACT','CTR'),
('Checkout_Update','Actualizar','ACT','CTR'),
('Checkout_Confirm','Confirmar','ACT','CTR'),
('Checkout_Success','Success','ACT','CTR'),
('Checkout_Accept','PayPal OK','ACT','CTR'),
('Checkout_Error','PayPal Error','ACT','CTR'),

-- PERFIL
('Private_MiPerfil','Mi Perfil','ACT','CTR'),

-- HISTORIAL
('Compra_Historial','Historial Compras','ACT','CTR');

-- ========================
-- ADMIN → TODO
-- ========================
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp)
SELECT 'admin', fncod, 'ACT', '2030-01-01'
FROM funciones;

-- ========================
-- CLIENTE → PERMISOS
-- ========================
INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES

-- CHECKOUT
('cliente','Checkout_Checkout','ACT','2030-01-01'),
('cliente','Checkout_Add','ACT','2030-01-01'),
('cliente','Checkout_Remove','ACT','2030-01-01'),
('cliente','Checkout_Update','ACT','2030-01-01'),
('cliente','Checkout_Confirm','ACT','2030-01-01'),
('cliente','Checkout_Success','ACT','2030-01-01'),
('cliente','Checkout_Accept','ACT','2030-01-01'),
('cliente','Checkout_Error','ACT','2030-01-01'),

-- MENÚS
('cliente','Menu_Checkout','ACT','2030-01-01'),
('cliente','Menu_Compra_Historial','ACT','2030-01-01'),

-- PERFIL
('cliente','Private_MiPerfil','ACT','2030-01-01'),

-- HISTORIAL
('cliente','Compra_Historial','ACT','2030-01-01');