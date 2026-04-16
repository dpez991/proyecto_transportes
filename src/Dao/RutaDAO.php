<?php

namespace Dao;

class RutaDAO extends Table
{
    public static function getAll()
    {
        $sql = "SELECT 
                    id as rutaId,
                    origen,
                    destino,
                    CASE 
                        WHEN estado = 1 THEN 'ACTIVO'
                        ELSE 'INACTIVO'
                    END as estado
                FROM rutas
                ORDER BY id DESC;";

        return self::obtenerRegistros($sql, []);
    }

    public static function getById($id)
    {
        $sql = 'SELECT 
                    id as rutaId,
                    origen,
                    destino,
                    estado
                FROM rutas
                WHERE id = :id;';

        return self::obtenerUnRegistro($sql, ['id' => $id]);
    }

    public static function insert($origen, $destino, $estado)
    {
        $sql = 'INSERT INTO rutas (origen, destino, estado)
                VALUES (:origen, :destino, :estado);';

        return self::executeNonQuery($sql, [
            'origen' => $origen,
            'destino' => $destino,
            'estado' => $estado === 'ACT' ? 1 : 0,
        ]);
    }

    public static function update($id, $origen, $destino, $estado)
    {
        $sql = 'UPDATE rutas
                SET origen = :origen,
                    destino = :destino,
                    estado = :estado
                WHERE id = :id;';

        return self::executeNonQuery($sql, [
            'id' => $id,
            'origen' => $origen,
            'destino' => $destino,
            'estado' => $estado === 'ACT' ? 1 : 0,
        ]);
    }

    public static function inactivate($id)
    {
        $sql = 'UPDATE rutas
                SET estado = 0
                WHERE id = :id;';

        return self::executeNonQuery($sql, ['id' => $id]);
    }
}
