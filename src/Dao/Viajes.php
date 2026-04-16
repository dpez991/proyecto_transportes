<?php

namespace Dao;

class Viajes extends Table
{
    public static function obtenerViajesDisponibles()
    {
        $sqlstr = 'SELECT
            v.id,
            r.origen,
            r.destino,
            v.fecha,
            h.hora,
            v.asientos_disponibles
        FROM viajes v
        INNER JOIN horarios_viaje h ON v.horario_id = h.id
        INNER JOIN rutas r ON h.ruta_id = r.id
        WHERE v.asientos_disponibles > 0;';

        return self::obtenerRegistros($sqlstr, []);
    }

    public static function obtenerViajePorId($id)
    {
        $sqlstr = 'SELECT
            v.id,
            v.horario_id,
            r.origen,
            r.destino,
            v.fecha,
            h.hora,
            v.asientos_disponibles
        FROM viajes v
        INNER JOIN horarios_viaje h ON v.horario_id = h.id
        INNER JOIN rutas r ON h.ruta_id = r.id
        WHERE v.id = :id;';

        return self::obtenerUnRegistro($sqlstr, ['id' => $id]);
    }

    // 🔥 CONSULTA INTELIGENTE
    public static function obtenerViajePorHorarioYFecha($horario_id, $fecha)
    {
        $sqlstr = 'SELECT
            v.asientos_disponibles
        FROM viajes v
        WHERE v.horario_id = :horario_id
        AND v.fecha = :fecha;';

        $viaje = self::obtenerUnRegistro($sqlstr, [
            'horario_id' => $horario_id,
            'fecha' => $fecha,
        ]);

        // 🔥 SI NO EXISTE → DEVOLVER CAPACIDAD DEL BUS
        if (!$viaje) {
            $sqlCapacidad = 'SELECT b.capacidad
                FROM horarios_viaje h
                INNER JOIN buses b ON h.bus_id = b.id
                WHERE h.id = :horario_id';

            $bus = self::obtenerUnRegistro($sqlCapacidad, [
                'horario_id' => $horario_id,
            ]);

            return [
                'asientos_disponibles' => $bus['capacidad'] ?? 45,
            ];
        }

        return $viaje;
    }
}
