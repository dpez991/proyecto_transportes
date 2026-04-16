<?php

namespace Dao;

class BusDAO extends Table
{
    public static function getAll()
    {
        $sql = "SELECT 
                    id as busId,
                    codigo_bus,
                    capacidad,
                    CASE 
                        WHEN estado = 1 THEN 'ACTIVO'
                        ELSE 'INACTIVO'
                    END as estado
                FROM buses
                ORDER BY id DESC;";

        return self::obtenerRegistros($sql, []);
    }

    public static function getById($id)
    {
        $sql = 'SELECT 
                    id as busId,
                    codigo_bus,
                    capacidad,
                    estado
                FROM buses
                WHERE id = :id;';

        return self::obtenerUnRegistro($sql, ['id' => $id]);
    }

    public static function insert($codigo_bus, $capacidad, $estado)
    {
        $sql = 'INSERT INTO buses (codigo_bus, capacidad, estado)
                VALUES (:codigo_bus, :capacidad, :estado);';

        return self::executeNonQuery($sql, [
            'codigo_bus' => $codigo_bus,
            'capacidad' => $capacidad,
            'estado' => $estado === 'ACT' ? 1 : 0,
        ]);
    }

    public static function update($id, $codigo_bus, $capacidad, $estado)
    {
        $sql = 'UPDATE buses
                SET codigo_bus = :codigo_bus,
                    capacidad = :capacidad,
                    estado = :estado
                WHERE id = :id;';

        return self::executeNonQuery($sql, [
            'id' => $id,
            'codigo_bus' => $codigo_bus,
            'capacidad' => $capacidad,
            'estado' => $estado === 'ACT' ? 1 : 0,
        ]);
    }

    public static function inactivate($id)
    {
        $sql = 'UPDATE buses SET estado = 0 WHERE id = :id;';

        return self::executeNonQuery($sql, ['id' => $id]);
    }
}
