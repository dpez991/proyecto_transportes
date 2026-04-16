USE nwdb;

INSERT INTO viajes (horario_id, fecha, asientos_disponibles)
SELECT h.id, CURDATE(), 45
FROM horarios_viaje h
WHERE NOT EXISTS (
    SELECT 1 FROM viajes v
    WHERE v.horario_id = h.id
    AND v.fecha = CURDATE()
);