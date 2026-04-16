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
        $usercod = Security::getUserId();

        $comprasDB = CompraDAO::obtenerHistorialUsuario($usercod);

        $comprasAgrupadas = [];

        foreach ($comprasDB as $row) {
            $compraId = $row['compra_id'];

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

        $viewData = [
            'hasCompras' => count($comprasAgrupadas),
            'compras' => array_values($comprasAgrupadas),
        ];

        Renderer::render('compra/historial', $viewData);
    }
}
