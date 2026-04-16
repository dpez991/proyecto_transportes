<?php

namespace Controllers\Mantenimientos\Compras;

use Controllers\PrivateController;
use Views\Renderer;
use Dao\CompraDAO;

const LIST_VIEW_TEMPLATE = "mantenimientos/compras/listado";

class Listado extends PrivateController
{
    public function run(): void
    {
        Renderer::render(LIST_VIEW_TEMPLATE, [
            "compras" => CompraDAO::getAll(),
            "showDetail" => $this->isFeatureAutorized("Mantenimientos_Compras_Detalle")
        ]);
    }
}