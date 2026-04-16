<?php

namespace Dao;

class CompraDAO extends Table
{
    public static function obtenerHistorialUsuario($usercod)
    {
        $sql = "SELECT 
                c.id AS compra_id,
                c.fecha AS fecha_compra,
                c.total AS total_compra,
                c.estado AS estado_compra,

                IFNULL(p.metodo, 'PAYPAL') AS metodo_pago,
                IFNULL(p.estado, 'COMPLETED') AS estado_pago,
                IFNULL(p.paypal_order_id, 'N/A') AS transaccion_id,

                d.cantidad,
                d.precio AS precio_unitario,
                d.tipo_asiento,
                d.fecha AS fecha_viaje,

                h.hora AS hora_salida,
                r.origen,
                r.destino

            FROM compras c

            INNER JOIN detalle_compra d 
                ON c.id = d.compra_id

            INNER JOIN horarios_viaje h 
                ON d.horario_id = h.id

            INNER JOIN rutas r 
                ON h.ruta_id = r.id

            LEFT JOIN pagos p 
                ON p.compra_id = c.id

            WHERE c.usercod = :usercod

            ORDER BY c.fecha DESC";

        return self::obtenerRegistros($sql, ['usercod' => $usercod]);
    }

    public static function obtenerTodasLasCompras()
    {
        $sql = 'SELECT 
                    c.id as compra_id,
                    c.fecha as fecha_compra,
                    c.total as total_compra,
                    c.estado as estado_compra,
                    u.username as usuario,
                    p.metodo as metodo_pago,
                    p.estado as estado_pago,
                    p.paypal_order_id as transaccion_id
                FROM compras c
                INNER JOIN usuario u ON c.usercod = u.usercod
                LEFT JOIN pagos p ON c.id = p.compra_id
                ORDER BY c.fecha DESC;';

        return self::obtenerRegistros($sql, []);
    }

    public static function marcarComoPagado($compraId)
    {
        $sql = "UPDATE compras 
            SET estado = 'pagado' 
            WHERE id = :id;";

        return self::executeNonQuery($sql, [
            'id' => $compraId,
        ]);
    }

    public static function obtenerDetalleCompleto($compraId)
    {
        $sql = 'SELECT 
                c.id AS compra_id,
                c.fecha AS fecha_compra,
                c.total AS total_compra,
                c.estado AS estado_compra,

                u.username,
                u.useremail,

                p.metodo,
                p.estado AS estado_pago,
                p.paypal_order_id,
                p.paypal_capture_id,
                p.payer_nombre,
                p.payer_email,
                p.monto,
                p.moneda,
                p.direccion,

                d.cantidad,
                d.precio,
                d.tipo_asiento,
                d.fecha AS fecha_viaje,

                h.hora,
                r.origen,
                r.destino

            FROM compras c

            INNER JOIN usuario u ON c.usercod = u.usercod
            LEFT JOIN pagos p ON p.compra_id = c.id
            LEFT JOIN detalle_compra d ON d.compra_id = c.id
            LEFT JOIN horarios_viaje h ON d.horario_id = h.id
            LEFT JOIN rutas r ON h.ruta_id = r.id

            WHERE c.id = :id';

        return self::obtenerRegistros($sql, ['id' => $compraId]);
    }
}
