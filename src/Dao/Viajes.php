<?php

namespace Dao;

class Viajes extends Table
{
    public static function obtenerViajesDisponibles()
    {
        $sqlstr = "SELECT
            v.id,
            r.origen,
            r.destino,
            v.fecha,
            v.hora,
            v.asientos_disponibles
            FROM viajes v
            INNER JOIN rutas r ON v.ruta_id = r.id
            WHERE v.asientos_disponibles > 0;";
        return self::obtenerRegistros($sqlstr, []);
    }

    public static function obtenerViajePorId($id)
    {
        $sqlstr = "SELECT
            v.id,
            r.origen,
            r.destino,
            v.fecha,
            v.hora,
            v.asientos_disponibles
            FROM viajes v
            INNER JOIN rutas r ON v.ruta_id = r.id
            WHERE v.id = :id AND v.asientos_disponibles > 0;";
        return self::obtenerUnRegistro($sqlstr, ['id' => $id]);
    }
}
