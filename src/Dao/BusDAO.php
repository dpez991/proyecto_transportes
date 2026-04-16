<?php

namespace Dao;

class BusDAO extends Table
{
    public static function getAll()
    {
        $sqlstr = "SELECT * FROM buses;";
        return self::obtenerRegistros($sqlstr, []);
    }

    public static function getById($busId)
    {
        $sqlstr = "SELECT * FROM buses WHERE busId = :busId;";
        return self::obtenerUnRegistro($sqlstr, ["busId" => $busId]);
    }

    public static function insert($numeroBus, $placa, $capacidad = 45, $busest = "ACT")
    {
        $sqlstr = "INSERT INTO buses (numeroBus, placa, capacidad, busest)
                   VALUES (:numeroBus, :placa, :capacidad, :busest);";
        return self::executeNonQuery($sqlstr, [
            "numeroBus" => $numeroBus,
            "placa" => $placa,
            "capacidad" => $capacidad,
            "busest" => $busest
        ]);
    }

    public static function update($busId, $numeroBus, $placa, $capacidad, $busest)
    {
        $sqlstr = "UPDATE buses
                   SET numeroBus = :numeroBus,
                       placa = :placa,
                       capacidad = :capacidad,
                       busest = :busest
                   WHERE busId = :busId;";
        return self::executeNonQuery($sqlstr, [
            "busId" => $busId,
            "numeroBus" => $numeroBus,
            "placa" => $placa,
            "capacidad" => $capacidad,
            "busest" => $busest
        ]);
    }

    public static function delete($busId)
    {
        $sqlstr = "DELETE FROM buses WHERE busId = :busId;";
        return self::executeNonQuery($sqlstr, ["busId" => $busId]);
    }
}