<?php

namespace Controllers\Mantenimientos\Compras;

use Controllers\PrivateController;
use Views\Renderer;
use Dao\CompraDAO;
use Utilities\Site;

class Detalle extends PrivateController
{
    private array $viewData = [];

    public function run(): void
    {
        $compraId = intval($_GET["id"] ?? 0);
        if ($compraId <= 0) {
            Site::redirectToWithMsg("index.php?page=Mantenimientos_Compras_Listado", "Compra inválida");
        }

        $compra = CompraDAO::getById($compraId);
        if (!$compra) {
            Site::redirectToWithMsg("index.php?page=Mantenimientos_Compras_Listado", "No se encontró la compra");
        }

        $this->viewData = $compra;
        Renderer::render("mantenimientos/compras/detalle", $this->viewData);
    }
}