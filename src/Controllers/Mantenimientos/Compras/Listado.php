<?php

namespace Controllers\Mantenimientos\Compras;

use Controllers\PrivateController;
use Dao\CompraDAO;
use Views\Renderer;

class Listado extends PrivateController
{
    public function run(): void
    {
        $comprasDB = CompraDAO::obtenerTodasLasCompras();

        $viewData = [
            "hasCompras" => count($comprasDB) > 0,
            "compras" => $comprasDB
        ];

        Renderer::render("mantenimientos/compras/listado", $viewData);
    }
}