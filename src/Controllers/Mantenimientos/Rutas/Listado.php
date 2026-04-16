<?php

namespace Controllers\Mantenimientos\Rutas;

use Controllers\PrivateController;
use Views\Renderer;
use Dao\RutaDAO;

const LIST_VIEW_TEMPLATE = "mantenimientos/rutas/listado";

class Listado extends PrivateController
{
    private array $rutas = [];

    public function run(): void
    {
        $this->rutas = RutaDAO::getAll();

        Renderer::render(LIST_VIEW_TEMPLATE, [
            "rutas" => $this->rutas,
            "showNew" => true,
            "showEdit" => true,
            "showDel" => true,
            "showView" => true
        ]);
    }
}