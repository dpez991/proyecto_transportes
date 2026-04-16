<?php

namespace Controllers\Checkout;

use Controllers\PrivateController;
use Dao\Cart\Cart;
use Utilities\Security;
use Utilities\Site;

class Add extends PrivateController
{
    public function run(): void
    {
        if ($this->isPostBack()) {
            $usercod = Security::getUserId();
            $horario_id = $_POST['horario_id'] ?? 0;
            $fecha = $_POST['fecha'] ?? '';
            $tipo_asiento = $_POST['tipo_asiento'] ?? '';
            $cantidad = intval($_POST['cantidad'] ?? 0);
            $precio_unitario = floatval($_POST['precio_unitario'] ?? 0);

            if ($horario_id > 0 && !empty($fecha) && $cantidad > 0) {
                // Verificar en PHP por si acaso sobrepasan la UI
                $viaje = \Dao\Viajes::obtenerViajePorHorarioYFecha($horario_id, $fecha);
                if ($viaje && $cantidad <= $viaje['asientos_disponibles']) {
                    Cart::agregarItem($usercod, $horario_id, $fecha, $tipo_asiento, $cantidad, $precio_unitario);
                    $_SESSION['CART_COUNT'] = Cart::obtenerCantidad($usercod);
                }
            }
        }
        
        Site::redirectTo("index.php?page=Checkout_Checkout");
    }
}
