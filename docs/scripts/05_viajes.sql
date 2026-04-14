CREATE TABLE `viajes` (
    `viajeId` int(12) NOT NULL AUTO_INCREMENT,
    `rutaId` int(12) NOT NULL,
    `busId` int(12) DEFAULT NULL,
    `fecha` date NOT NULL,
    `hora` time NOT NULL,
    `asientosDisponibles` int(14) NOT NULL,
    PRIMARY KEY (`viajeId`),
    KEY `ruta_idx` (`rutaId`),
    CONSTRAINT `viaje_ruta_fk`
        FOREIGN KEY (`rutaId`)
        REFERENCES `rutas` (`rutaId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;