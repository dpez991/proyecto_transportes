<?php

namespace Dao;

class CompraDAO extends Table
{
    public static function getAll()
    {
        $sqlstr = "SELECT
                        c.compraId,
                        c.usercod,
                        c.viajeId,
                        c.cantidadAsientos,
                        c.total,
                        c.fechacompra,
                        c.compraest,
                        u.username,
                        u.useremail,
                        r.origen,
                        r.destino,
                        v.fecha,
                        v.hora
                   FROM compras c
                   INNER JOIN usuario u ON c.usercod = u.usercod
                   INNER JOIN viajes v ON c.viajeId = v.viajeId
                   INNER JOIN rutas r ON v.rutaId = r.rutaId
                   ORDER BY c.fechacompra DESC;";
        return self::obtenerRegistros($sqlstr, []);
    }

    public static function getById($compraId)
    {
        $sqlstr = "SELECT
                        c.compraId,
                        c.usercod,
                        c.viajeId,
                        c.cantidadAsientos,
                        c.total,
                        c.fechacompra,
                        c.compraest,
                        u.username,
                        u.useremail,
                        r.origen,
                        r.destino,
                        v.fecha,
                        v.hora,
                        b.numeroBus,
                        b.placa
                   FROM compras c
                   INNER JOIN usuario u ON c.usercod = u.usercod
                   INNER JOIN viajes v ON c.viajeId = v.viajeId
                   INNER JOIN rutas r ON v.rutaId = r.rutaId
                   INNER JOIN buses b ON v.busId = b.busId
                   WHERE c.compraId = :compraId;";
        return self::obtenerUnRegistro($sqlstr, ["compraId" => $compraId]);
    }

    public static function countAll()
    {
        $sqlstr = "SELECT COUNT(*) as total FROM compras;";
        return self::obtenerUnRegistro($sqlstr, []);
    }
}