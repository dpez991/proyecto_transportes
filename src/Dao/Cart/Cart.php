<?php

namespace Dao\Cart;

use Dao\Dao;
use Dao\Table;

class Cart extends Table
{
    public static function agregarItem($usercod, $horario_id, $fecha, $tipo_asiento, $cantidad, $precio_unitario)
    {
        $sqlCheck = 'SELECT id, cantidad FROM carrito 
                     WHERE usercod = :usercod 
                     AND horario_id = :horario_id 
                     AND fecha = :fecha 
                     AND tipo_asiento = :tipo_asiento;';
        $itemParams = [
            'usercod' => $usercod,
            'horario_id' => $horario_id,
            'fecha' => $fecha,
            'tipo_asiento' => $tipo_asiento,
        ];

        $item = self::obtenerUnRegistro($sqlCheck, $itemParams);

        if ($item) {
            $sqlUpdate = 'UPDATE carrito SET cantidad = cantidad + :cantidad 
                          WHERE id = :id;';

            return self::executeNonQuery($sqlUpdate, [
                'cantidad' => $cantidad,
                'id' => $item['id'],
            ]);
        } else {
            $sqlInsert = 'INSERT INTO carrito (usercod, horario_id, fecha, tipo_asiento, cantidad, precio_unitario, fecha_creacion)
                          VALUES (:usercod, :horario_id, :fecha, :tipo_asiento, :cantidad, :precio_unitario, NOW());';

            return self::executeNonQuery($sqlInsert, array_merge($itemParams, [
                'cantidad' => $cantidad,
                'precio_unitario' => $precio_unitario,
            ]));
        }
    }

    public static function obtenerCarrito($usercod)
    {
        $sql = 'SELECT c.id as carrito_id, c.horario_id, c.fecha, c.tipo_asiento, c.cantidad, c.precio_unitario,
                       h.hora, r.origen, r.destino
                FROM carrito c
                INNER JOIN horarios_viaje h ON c.horario_id = h.id
                INNER JOIN rutas r ON h.ruta_id = r.id
                WHERE c.usercod = :usercod
                ORDER BY c.fecha_creacion DESC;';

        return self::obtenerRegistros($sql, ['usercod' => $usercod]);
    }

    public static function eliminarItem($usercod, $carrito_id)
    {
        $sql = 'DELETE FROM carrito WHERE usercod = :usercod AND id = :id;';

        return self::executeNonQuery($sql, ['usercod' => $usercod, 'id' => $carrito_id]);
    }

    public static function actualizarItem($carrito_id, $usercod, $fecha, $tipo_asiento, $cantidad, $precio_unitario)
    {
        $sql = 'UPDATE carrito 
                SET fecha = :fecha,
                    tipo_asiento = :tipo_asiento,
                    cantidad = :cantidad,
                    precio_unitario = :precio_unitario
                WHERE id = :id AND usercod = :usercod;';

        return self::executeNonQuery($sql, [
            'id' => $carrito_id,
            'usercod' => $usercod,
            'fecha' => $fecha,
            'tipo_asiento' => $tipo_asiento,
            'cantidad' => $cantidad,
            'precio_unitario' => $precio_unitario,
        ]);
    }

    public static function limpiarCarrito($usercod, &$conn = null)
    {
        $sql = 'DELETE FROM carrito WHERE usercod = :usercod;';

        return self::executeNonQuery($sql, ['usercod' => $usercod], $conn);
    }

    public static function obtenerCantidad($usercod)
    {
        $sql = 'SELECT SUM(cantidad) as total FROM carrito WHERE usercod = :usercod;';
        $result = self::obtenerUnRegistro($sql, ['usercod' => $usercod]);

        return intval($result['total'] ?? 0);
    }

    public static function procesarCompra($usercod)
    {
        $conn = Dao::getConn();
        $conn->beginTransaction();

        try {
            $items = self::obtenerCarrito($usercod);

            if (empty($items)) {
                throw new \Exception('El carrito está vacío.');
            }

            $totalCompra = 0;

            foreach ($items as $item) {
                $totalCompra += ($item['cantidad'] * $item['precio_unitario']);

                $sqlViaje = 'SELECT id, asientos_disponibles FROM viajes 
                             WHERE horario_id = :horario_id AND fecha = :fecha FOR UPDATE;';
                $paramsViaje = [
                    'horario_id' => $item['horario_id'],
                    'fecha' => $item['fecha'],
                ];

                $viaje = self::obtenerUnRegistro($sqlViaje, $paramsViaje, $conn);

                if ($viaje) {
                    if ($viaje['asientos_disponibles'] < $item['cantidad']) {
                        throw new \Exception("No hay asientos suficientes para el viaje {$item['origen']} a {$item['destino']} el {$item['fecha']}. Solo quedan {$viaje['asientos_disponibles']}");
                    }

                    $sqlUpdateViaje = 'UPDATE viajes SET asientos_disponibles = asientos_disponibles - :cantidad 
                                       WHERE id = :id AND asientos_disponibles >= :cantidad;';
                    $updated = self::executeNonQuery($sqlUpdateViaje, [
                        'cantidad' => $item['cantidad'],
                        'id' => $viaje['id'],
                    ], $conn);

                    if (!$updated) {
                        throw new \Exception('Error actualizando asientos (Concurrencia detectada).');
                    }
                } else {
                    $sqlBus = 'SELECT b.capacidad FROM horarios_viaje h 
                               INNER JOIN buses b ON h.bus_id = b.id 
                               WHERE h.id = :horario_id;';
                    $busParams = ['horario_id' => $item['horario_id']];
                    $bus = self::obtenerUnRegistro($sqlBus, $busParams, $conn);
                    $capacidad = $bus['capacidad'] ?? 45;

                    if ($capacidad < $item['cantidad']) {
                        throw new \Exception("La cantidad solicitada excede la capacidad total del bus ({$capacidad} asientos).");
                    }

                    $asientosRestantes = $capacidad - $item['cantidad'];

                    $sqlInsertViaje = 'INSERT INTO viajes (horario_id, fecha, asientos_disponibles)
                                       VALUES (:horario_id, :fecha, :asientos_disponibles);';
                    self::executeNonQuery($sqlInsertViaje, [
                        'horario_id' => $item['horario_id'],
                        'fecha' => $item['fecha'],
                        'asientos_disponibles' => $asientosRestantes,
                    ], $conn);
                }
            }

            $sqlCompra = "INSERT INTO compras (usercod, fecha, total, estado) 
                          VALUES (:usercod, NOW(), :total, 'pendiente');";
            self::executeNonQuery($sqlCompra, [
                'usercod' => $usercod,
                'total' => $totalCompra,
            ], $conn);

            $compraId = $conn->lastInsertId();

            foreach ($items as $item) {
                $sqlDetalle = 'INSERT INTO detalle_compra (compra_id, horario_id, fecha, tipo_asiento, precio, cantidad)
                               VALUES (:compra_id, :horario_id, :fecha, :tipo_asiento, :precio, :cantidad);';
                self::executeNonQuery($sqlDetalle, [
                    'compra_id' => $compraId,
                    'horario_id' => $item['horario_id'],
                    'fecha' => $item['fecha'],
                    'tipo_asiento' => $item['tipo_asiento'],
                    'precio' => $item['precio_unitario'],
                    'cantidad' => $item['cantidad'],
                ], $conn);
            }

            self::limpiarCarrito($usercod, $conn);

            $conn->commit();

            return $compraId;
        } catch (\Exception $e) {
            $conn->rollBack();
            throw $e;
        }
    }
}
