CREATE TABLE `rutas` (
    `rutaId` int(11) NOT NULL AUTO_INCREMENT,
    `origen` varchar(100) NOT NULL,
    `destino` varchar(100) NOT NULL,
    `estado` char(3) NOT NULL DEFAULT 'ACT',
    PRIMARY KEY (`rutaId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO rutas (origen, destino, estado) VALUES
('Tegucigalpa','Choluteca','ACT'),
('Choluteca','Tegucigalpa','ACT'),
('Tegucigalpa','San Pedro Sula','ACT'),
('San Pedro Sula','Tegucigalpa','ACT'),
('Tegucigalpa','Copán','ACT'),
('Copán','Tegucigalpa','ACT'),
('Tegucigalpa','La Ceiba','ACT'),
('La Ceiba','Tegucigalpa','ACT'),
('Tegucigalpa','Comayagua','ACT'),
('Comayagua','Tegucigalpa','ACT'),
('Tegucigalpa','Danlí','ACT'),
('Danlí','Tegucigalpa','ACT');