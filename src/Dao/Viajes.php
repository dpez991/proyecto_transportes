<?php

namespace Dao;

class Viajes extends Table
{
    public static function getAll()
    {
        $sqlstr = "SELECT 
                        v.viajeId,
                        r.origen,
                        r.destino,
                        v.fecha,
                        v.hora,
                        v.asientosDisponibles
                   FROM viajes v
                   INNER JOIN rutas r ON v.rutaId = r.rutaId
                   WHERE v.asientosDisponibles > 0";

        return self::obtenerRegistros($sqlstr, []);
    }

    public static function getById($id)
    {
        $sqlstr = "SELECT 
                        v.viajeId,
                        r.origen,
                        r.destino,
                        v.fecha,
                        v.hora,
                        v.asientosDisponibles
                   FROM viajes v
                   INNER JOIN rutas r ON v.rutaId = r.rutaId
                   WHERE v.viajeId = :id";

        return self::obtenerUnRegistro($sqlstr, ["id" => $id]);
    }
}