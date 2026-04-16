<?php

namespace Dao;

class ViajeDAO extends Table
{
    public static function getAll()
    {
        $sqlstr = "SELECT
                        v.viajeId,
                        v.rutaId,
                        v.busId,
                        v.fecha,
                        v.hora,
                        v.asientosDisponibles,
                        v.estado,
                        r.origen,
                        r.destino
                   FROM viajes v
                   INNER JOIN rutas r ON v.rutaId = r.rutaId
                   ORDER BY v.fecha DESC, v.hora DESC;";
        return self::obtenerRegistros($sqlstr, []);
    }

    public static function getActivos()
    {
        $sqlstr = "SELECT
                        v.viajeId,
                        v.rutaId,
                        v.busId,
                        v.fecha,
                        v.hora,
                        v.asientosDisponibles,
                        v.estado,
                        r.origen,
                        r.destino
                   FROM viajes v
                   INNER JOIN rutas r ON v.rutaId = r.rutaId
                   WHERE v.estado = 'ACT'
                   ORDER BY v.fecha DESC, v.hora DESC;";
        return self::obtenerRegistros($sqlstr, []);
    }

    public static function getById($viajeId)
    {
        $sqlstr = "SELECT * FROM viajes WHERE viajeId = :viajeId;";
        return self::obtenerUnRegistro($sqlstr, ["viajeId" => $viajeId]);
    }

    public static function insert($rutaId, $busId, $fecha, $hora, $asientosDisponibles, $estado = "ACT")
    {
        $sqlstr = "INSERT INTO viajes (rutaId, busId, fecha, hora, asientosDisponibles, estado)
                   VALUES (:rutaId, :busId, :fecha, :hora, :asientosDisponibles, :estado);";
        return self::executeNonQuery($sqlstr, [
            "rutaId" => $rutaId,
            "busId" => $busId,
            "fecha" => $fecha,
            "hora" => $hora,
            "asientosDisponibles" => $asientosDisponibles,
            "estado" => $estado
        ]);
    }

    public static function update($viajeId, $rutaId, $busId, $fecha, $hora, $asientosDisponibles, $estado)
    {
        $sqlstr = "UPDATE viajes
                   SET rutaId = :rutaId,
                       busId = :busId,
                       fecha = :fecha,
                       hora = :hora,
                       asientosDisponibles = :asientosDisponibles,
                       estado = :estado
                   WHERE viajeId = :viajeId;";
        return self::executeNonQuery($sqlstr, [
            "viajeId" => $viajeId,
            "rutaId" => $rutaId,
            "busId" => $busId,
            "fecha" => $fecha,
            "hora" => $hora,
            "asientosDisponibles" => $asientosDisponibles,
            "estado" => $estado
        ]);
    }

    public static function inactivate($viajeId)
    {
        $sqlstr = "UPDATE viajes
                   SET estado = 'INA'
                   WHERE viajeId = :viajeId;";
        return self::executeNonQuery($sqlstr, ["viajeId" => $viajeId]);
    }
}