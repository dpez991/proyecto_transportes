<?php

namespace Controllers\Checkout;

use Controllers\PrivateController;
use Views\Renderer;

class Success extends PrivateController
{
    public function run(): void
    {
        $viewData = [];

        if (isset($_SESSION['paypal_response'])) {
            $paypalRaw = $_SESSION['paypal_response'];
            $paypalJson = json_decode($paypalRaw);

            if ($paypalJson) {
                $viewData['payer_name'] = ($paypalJson->payer->name->given_name ?? 'N/A').' '.($paypalJson->payer->name->surname ?? '');
                $viewData['payer_email'] = $paypalJson->payer->email_address ?? 'N/A';
                $viewData['transaction_id'] = $paypalJson->id ?? 'N/A';
                $viewData['status'] = $paypalJson->status ?? 'N/A';

                if (isset($paypalJson->purchase_units[0]->shipping->address)) {
                    $addr = $paypalJson->purchase_units[0]->shipping->address;
                    $viewData['payer_address'] = ($addr->address_line_1 ?? '').', '.($addr->admin_area_2 ?? '').', '.($addr->country_code ?? '');
                } else {
                    $viewData['payer_address'] = 'N/A';
                }
            } else {
                $viewData['error'] = 'Error decodificando respuesta.';
            }

            unset($_SESSION['paypal_response']);
        }

        Renderer::render('checkout/success', $viewData);
    }
}
