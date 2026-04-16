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

    public static function getAllAdmin()
    {
        $sql = 'SELECT
                v.id as viajeId,
                v.fecha,
                v.asientos_disponibles as asientosDisponibles,

                h.hora,

                r.origen,
                r.destino,

                b.codigo_bus

            FROM viajes v
            INNER JOIN horarios_viaje h ON v.horario_id = h.id
            INNER JOIN rutas r ON h.ruta_id = r.id
            INNER JOIN buses b ON h.bus_id = b.id

            ORDER BY v.fecha DESC, h.hora DESC;';

        return self::obtenerRegistros($sql, []);
    }

    public static function getByIdAdmin($id)
    {
        $sql = 'SELECT * FROM viajes WHERE id = :id;';

        return self::obtenerUnRegistro($sql, ['id' => $id]);
    }

    public static function insertAdmin($horario_id, $fecha, $asientos)
    {
        $sql = 'INSERT INTO viajes (horario_id, fecha, asientos_disponibles)
            VALUES (:horario_id, :fecha, :asientos);';

        return self::executeNonQuery($sql, [
            'horario_id' => $horario_id,
            'fecha' => $fecha,
            'asientos' => $asientos,
        ]);
    }

    public static function updateAdmin($id, $fecha, $asientos)
    {
        $sql = 'UPDATE viajes
            SET fecha = :fecha,
                asientos_disponibles = :asientos
            WHERE id = :id;';

        return self::executeNonQuery($sql, [
            'id' => $id,
            'fecha' => $fecha,
            'asientos' => $asientos,
        ]);
    }

    public static function deleteAdmin($id)
    {
        $sql = 'DELETE FROM viajes WHERE id = :id;';

        return self::executeNonQuery($sql, ['id' => $id]);
    }

    public static function getHorariosAdmin()
    {
        $sql = 'SELECT
                h.id,
                r.origen,
                r.destino,
                h.hora,
                b.codigo_bus
            FROM horarios_viaje h
            INNER JOIN rutas r ON h.ruta_id = r.id
            INNER JOIN buses b ON h.bus_id = b.id
            WHERE h.estado = 1;';

        return self::obtenerRegistros($sql, []);
    }
}
