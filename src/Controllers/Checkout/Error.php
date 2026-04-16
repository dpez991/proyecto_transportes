<?php

namespace Controllers\Checkout;

use Controllers\PrivateController;

class Error extends PrivateController
{
    public function run(): void
    {
        \Utilities\Site::redirectToWithMsg("index.php?page=Checkout_Checkout", "El pago no fue completado o fue cancelado por el usuario.");
    }
}
