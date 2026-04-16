<?php

namespace Controllers\Compra;

use Controllers\PrivateController;
use Dao\CompraDAO;
use Utilities\Security;
use Views\Renderer;

class Historial extends PrivateController
{
    public function run(): void
    {
        // 1. Obtener ID del usuario logueado
        $usercod = Security::getUserId();

        // 2. Traer su historial de la base de datos
        $comprasDB = CompraDAO::obtenerHistorialUsuario($usercod);

        // 🔥 DEBUG (si querés probar, descomenta esto)
        // var_dump($comprasDB);
        // die();

        // 3. Agrupar la información por ID de compra
        $comprasAgrupadas = [];

        foreach ($comprasDB as $row) {
            $compraId = $row['compra_id'];

            // Crear estructura base si no existe
            if (!isset($comprasAgrupadas[$compraId])) {
                $comprasAgrupadas[$compraId] = [
                    'compra_id' => $compraId,
                    'fecha_compra' => $row['fecha_compra'],
                    'total_compra' => number_format($row['total_compra'], 2),
                    'estado_compra' => $row['estado_compra'],
                    'metodo_pago' => $row['metodo_pago'] ?? 'N/A',
                    'estado_pago' => $row['estado_pago'] ?? 'N/A',
                    'transaccion_id' => $row['transaccion_id'] ?? 'N/A',
                    'detalles' => [],
                ];
            }

            // 🔥 SOLO agregar detalle si existe (evita NULL)
            if (isset($row['cantidad'])) {
                $comprasAgrupadas[$compraId]['detalles'][] = [
                    'origen' => $row['origen'] ?? 'N/A',
                    'destino' => $row['destino'] ?? 'N/A',
                    'fecha_viaje' => $row['fecha_viaje'] ?? '',
                    'hora_salida' => $row['hora_salida'] ?? '',
                    'tipo_asiento' => $row['tipo_asiento'] ?? '',
                    'cantidad' => $row['cantidad'],
                    'precio_unitario' => number_format($row['precio_unitario'] ?? 0, 2),
                    'subtotal' => number_format(
                        ($row['cantidad'] ?? 0) * ($row['precio_unitario'] ?? 0),
                        2
                    ),
                ];
            }
        }

        // 4. Enviar a la vista
        $viewData = [
            'hasCompras' => count($comprasAgrupadas),
            'compras' => array_values($comprasAgrupadas),
        ];

        Renderer::render('compra/historial', $viewData);
    }
}
