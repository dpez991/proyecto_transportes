<?php

namespace Controllers\Checkout;

use Controllers\PrivateController;
use Dao\Cart\Cart;
use Utilities\Security;
use Views\Renderer;

class Checkout extends PrivateController
{
    public function run(): void
    {
        $usercod = Security::getUserId();

        $items = Cart::obtenerCarrito($usercod);
        $total = 0;

        foreach ($items as &$item) {
            $item['subtotal'] = $item['cantidad'] * $item['precio_unitario'];
            $total += $item['subtotal'];

            // 🔥 FIX DEL SELECT (CLAVE)
            $item['sel_normal'] = ($item['tipo_asiento'] === 'Normal') ? 'selected' : '';
            $item['sel_semi'] = ($item['tipo_asiento'] === 'Semi cama') ? 'selected' : '';
            $item['sel_cama'] = ($item['tipo_asiento'] === 'Cama') ? 'selected' : '';
        }

        if ($this->isPostBack()) {
            if (empty($items)) {
                \Utilities\Site::redirectToWithMsg('index.php?page=Checkout_Checkout', 'Tu carrito está vacío.');
            }

            $baseDir = \Utilities\Context::getContextByKey('BASE_DIR');
            $scheme = (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] === 'on') ? 'https' : 'http';
            $host = $_SERVER['HTTP_HOST'];
            $baseUrl = $scheme.'://'.$host.$baseDir;

            $errorUrl = $baseUrl.'/index.php?page=Checkout_Error';
            $acceptUrl = $baseUrl.'/index.php?page=Checkout_Accept';

            $PayPalOrder = new \Utilities\Paypal\PayPalOrder(
                'ORD-'.$usercod.'-'.time(),
                $errorUrl,
                $acceptUrl
            );

            foreach ($items as $item) {
                $PayPalOrder->addItem(
                    'Boleto '.$item['origen'].' a '.$item['destino'],
                    $item['origen'].'-'.$item['destino'],
                    'AS-'.$item['horario_id'],
                    $item['precio_unitario'],
                    0,
                    $item['cantidad'],
                    'DIGITAL_GOODS'
                );
            }

            $PayPalRestApi = new \Utilities\PayPal\PayPalRestApi(
                \Utilities\Context::getContextByKey('PAYPAL_CLIENT_ID'),
                \Utilities\Context::getContextByKey('PAYPAL_CLIENT_SECRET')
            );

            $PayPalRestApi->getAccessToken();
            $response = $PayPalRestApi->createOrder($PayPalOrder);

            $_SESSION['orderid'] = $response->id;

            foreach ($response->links as $link) {
                if ($link->rel == 'approve') {
                    \Utilities\Site::redirectTo($link->href);
                }
            }
            exit;
        }

        $viewData = [
            'items' => $items,
            'hasItems' => count($items) > 0,
            'total' => number_format($total, 2),
        ];

        Renderer::render('checkout/cart', $viewData);
    }
}
