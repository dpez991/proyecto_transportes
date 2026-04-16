<?php

namespace Dao;

class AdminDAO extends Table
{
    public static function getDashboardResume()
    {
        $sqlUsuarios = "SELECT COUNT(*) AS totalUsuarios FROM usuario;";
        $sqlViajes = "SELECT COUNT(*) AS totalViajes FROM viajes;";
        $sqlCompras = "SELECT COUNT(*) AS totalCompras FROM compras;";

        $usuarios = self::obtenerUnRegistro($sqlUsuarios, []);
        $viajes = self::obtenerUnRegistro($sqlViajes, []);
        $compras = self::obtenerUnRegistro($sqlCompras, []);

        return [
            "totalUsuarios" => $usuarios["totalUsuarios"] ?? 0,
            "totalViajes" => $viajes["totalViajes"] ?? 0,
            "totalCompras" => $compras["totalCompras"] ?? 0
        ];
    }
}