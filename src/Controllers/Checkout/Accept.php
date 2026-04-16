<?php

namespace Controllers\Checkout;

use Controllers\PrivateController;
use Dao\Cart\Cart;
use Dao\PagosDAO;
use Utilities\Security;
use Utilities\Site;

class Accept extends PrivateController
{
    public function run(): void
    {
        $token = $_GET['token'] ?? '';
        $session_token = $_SESSION['orderid'] ?? '';

        if ($token !== '' && $token == $session_token) {
            $usercod = Security::getUserId();
            $PayPalRestApi = new \Utilities\PayPal\PayPalRestApi(
                \Utilities\Context::getContextByKey('PAYPAL_CLIENT_ID'),
                \Utilities\Context::getContextByKey('PAYPAL_CLIENT_SECRET')
            );

            try {
                $response = $PayPalRestApi->captureOrder($session_token);

                if (isset($response->status) && $response->status === 'COMPLETED') {
                    $compraId = Cart::procesarCompra($usercod);
                    if ($compraId) {
                        // Default fallback values
                        \Dao\CompraDAO::marcarComoPagado($compraId);
                        $payerName = ($response->payer->name->given_name ?? '').' '.($response->payer->name->surname ?? '');
                        $payerEmail = $response->payer->email_address ?? '';
                        $payerId = $response->payer->payer_id ?? '';
                        $orderId = $response->id ?? '';
                        $monto = 0;
                        $moneda = 'L.';
                        $direccion = '';
                        $captureId = '';

                        // Extracts amounts and capture id
                        if (isset($response->purchase_units[0])) {
                            $unit = $response->purchase_units[0];
                            if (isset($unit->payments->captures[0])) {
                                $captureId = $unit->payments->captures[0]->id ?? '';
                                $monto = floatval($unit->payments->captures[0]->amount->value ?? 0);
                                $moneda = $unit->payments->captures[0]->amount->currency_code ?? 'L.';
                            }
                            if (isset($unit->shipping->address)) {
                                $addr = $unit->shipping->address;
                                $direccion = ($addr->address_line_1 ?? '').', '.($addr->admin_area_2 ?? '').', '.($addr->country_code ?? '');
                            }
                        }

                        // Save the payment
                        PagosDAO::insertarPago(
                            $compraId,
                            trim('PAYPAL'),
                            trim('COMPLETED'),
                            $orderId,
                            $captureId,
                            $payerName,
                            $payerEmail,
                            $payerId,
                            $monto,
                            $moneda,
                            $direccion,
                            json_encode($response)
                        );

                        $_SESSION['paypal_response'] = json_encode($response);
                        $_SESSION['CART_COUNT'] = 0;
                        Site::redirectTo('index.php?page=Checkout_Success');

                        return;
                    }
                } else {
                    Site::redirectToWithMsg('index.php?page=Checkout_Error', 'El pago no pudo completarse en PayPal.');
                }
            } catch (\Exception $e) {
                error_log($e->getMessage());
                Site::redirectToWithMsg('index.php?page=Checkout_Error', 'Hubo un problema procesando la compra o reservando asientos: '.$e->getMessage());
            }
        } else {
            Site::redirectToWithMsg('index.php?page=Checkout_Error', 'No se encontró una orden de pago iniciada válidamente.');
        }
    }
}
