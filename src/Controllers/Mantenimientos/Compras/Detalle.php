<?php

namespace Controllers\Mantenimientos\Compras;

use Controllers\PrivateController;
use Dao\CompraDAO;
use Utilities\Site;
use Views\Renderer;

class Detalle extends PrivateController
{
    public function run(): void
    {
        $compraId = intval($_GET['id'] ?? 0);

        if ($compraId <= 0) {
            Site::redirectToWithMsg('index.php?page=Mantenimientos_Compras_Listado', 'Compra inválida');
        }

        $rows = CompraDAO::obtenerDetalleCompleto($compraId);

        if (!$rows) {
            Site::redirectToWithMsg('index.php?page=Mantenimientos_Compras_Listado', 'No se encontró la compra');
        }

        $compra = [
            'compra_id' => $rows[0]['compra_id'],
            'fecha_compra' => $rows[0]['fecha_compra'],
            'total_compra' => $rows[0]['total_compra'],
            'estado_compra' => $rows[0]['estado_compra'],

            'username' => $rows[0]['username'],
            'useremail' => $rows[0]['useremail'],

            'metodo' => $rows[0]['metodo'],
            'estado_pago' => $rows[0]['estado_pago'],
            'paypal_order_id' => $rows[0]['paypal_order_id'],
            'paypal_capture_id' => $rows[0]['paypal_capture_id'],
            'payer_nombre' => $rows[0]['payer_nombre'],
            'payer_email' => $rows[0]['payer_email'],
            'monto' => $rows[0]['monto'],
            'moneda' => $rows[0]['moneda'],
            'direccion' => $rows[0]['direccion'],

            'detalles' => [],
        ];

        foreach ($rows as $row) {
            if (!empty($row['cantidad'])) {
                $compra['detalles'][] = [
                    'origen' => $row['origen'],
                    'destino' => $row['destino'],
                    'fecha_viaje' => $row['fecha_viaje'],
                    'hora' => $row['hora'],
                    'tipo_asiento' => $row['tipo_asiento'],
                    'cantidad' => $row['cantidad'],
                    'precio' => $row['precio'],
                    'subtotal' => $row['cantidad'] * $row['precio'],
                ];
            }
        }

        Renderer::render('mantenimientos/compras/detalle', $compra);
    }
}
