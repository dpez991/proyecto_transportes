<?php

namespace Controllers\Checkout;

use Controllers\PrivateController;
use Dao\Cart\Cart;
use Utilities\Security;
use Utilities\Site;

class Confirm extends PrivateController
{
    public function run(): void
    {
        if ($this->isPostBack()) {
            $usercod = Security::getUserId();
            try {
                $result = Cart::procesarCompra($usercod);
                if ($result) {
                    $_SESSION['CART_COUNT'] = 0;
                    Site::redirectToWithMsg("index.php?page=Checkout_Success", "¡Compra realizada con éxito!");
                }
            } catch (\Exception $e) {
                error_log($e->getMessage());
                Site::redirectToWithMsg("index.php?page=Checkout_Checkout", "Error: " . $e->getMessage());
            }
        } else {
            Site::redirectTo("index.php?page=Checkout_Checkout");
        }
    }
}
