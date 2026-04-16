<?php

namespace Controllers\Checkout;

use Controllers\PrivateController;
use Dao\Cart\Cart;
use Utilities\Security;
use Utilities\Site;

class Update extends PrivateController
{
    public function run(): void
    {
        if ($this->isPostBack()) {
            $usercod = Security::getUserId();
            $carrito_id = $_POST['carrito_id'] ?? 0;
            $fecha = $_POST['fecha'] ?? '';
            $cantidad = intval($_POST['cantidad'] ?? 0);
            $tipo_asiento = $_POST['tipo_asiento'] ?? '';
            $horario_id = $_POST['horario_id'] ?? 0;

            if ($carrito_id > 0 && !empty($fecha) && $cantidad > 0 && $horario_id > 0) {
                // Validación contra fecha pasada
                $hoy = date('Y-m-d');
                if ($fecha < $hoy) {
                    Site::redirectToWithMsg("index.php?page=Checkout_Checkout", "No puedes seleccionar fechas pasadas.");
                    return;
                }

                // Check availability
                $viaje = \Dao\Viajes::obtenerViajePorHorarioYFecha($horario_id, $fecha);
                if ($viaje && $cantidad > $viaje['asientos_disponibles']) {
                    Site::redirectToWithMsg("index.php?page=Checkout_Checkout", "No hay asientos suficientes. Disponibles: " . $viaje['asientos_disponibles']);
                    return;
                }

                // Recalculatar precio si cambió asiento
                $precio = 200; // Normal default
                if ($tipo_asiento === "Semi cama") $precio = 250;
                if ($tipo_asiento === "Cama") $precio = 350;

                Cart::actualizarItem($carrito_id, $usercod, $fecha, $tipo_asiento, $cantidad, $precio);
                $_SESSION['CART_COUNT'] = Cart::obtenerCantidad($usercod);
            }
        }
        
        Site::redirectTo("index.php?page=Checkout_Checkout");
    }
}
