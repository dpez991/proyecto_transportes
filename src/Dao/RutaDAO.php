<?php

namespace Dao;

class RutaDAO extends Table
{
    public static function getAll()
    {
        $sqlstr = "SELECT * FROM rutas;";
        return self::obtenerRegistros($sqlstr, []);
    }

    public static function getById($rutaId)
    {
        $sqlstr = "SELECT * FROM rutas WHERE rutaId = :rutaId;";
        return self::obtenerUnRegistro($sqlstr, ["rutaId" => $rutaId]);
    }

    public static function insert($origen, $destino, $estado = "ACT")
    {
        $sqlstr = "INSERT INTO rutas (origen, destino, estado)
                   VALUES (:origen, :destino, :estado);";
        return self::executeNonQuery($sqlstr, [
            "origen" => $origen,
            "destino" => $destino,
            "estado" => $estado
        ]);
    }

    public static function update($rutaId, $origen, $destino, $estado)
    {
        $sqlstr = "UPDATE rutas
                   SET origen = :origen,
                       destino = :destino,
                       estado = :estado
                   WHERE rutaId = :rutaId;";
        return self::executeNonQuery($sqlstr, [
            "rutaId" => $rutaId,
            "origen" => $origen,
            "destino" => $destino,
            "estado" => $estado
        ]);
    }

    public static function delete($rutaId)
    {
        $sqlstr = "DELETE FROM rutas WHERE rutaId = :rutaId;";
        return self::executeNonQuery($sqlstr, ["rutaId" => $rutaId]);
    }
}