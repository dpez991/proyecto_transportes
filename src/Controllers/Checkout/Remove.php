<?php

namespace Controllers\Checkout;

use Controllers\PrivateController;
use Dao\Cart\Cart;
use Utilities\Security;
use Utilities\Site;

class Remove extends PrivateController
{
    public function run(): void
    {
        if ($this->isPostBack()) {
            $usercod = Security::getUserId();
            $id = $_POST['id'] ?? 0;

            if ($id > 0) {
                Cart::eliminarItem($usercod, $id);
                $_SESSION['CART_COUNT'] = Cart::obtenerCantidad($usercod);
            }
        }
        
        Site::redirectTo("index.php?page=Checkout_Checkout");
    }
}
