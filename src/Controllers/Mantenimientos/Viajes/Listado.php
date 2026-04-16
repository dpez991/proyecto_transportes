<?php

namespace Controllers\Mantenimientos\Viajes;

use Controllers\PrivateController;
use Views\Renderer;
use Dao\ViajeDAO;

const LIST_VIEW_TEMPLATE = "mantenimientos/viajes/listado";

class Listado extends PrivateController
{
    public function run(): void
    {
        Renderer::render(LIST_VIEW_TEMPLATE, [
            "viajes" => ViajeDAO::getAll(),
            "showNew" => $this->isFeatureAutorized("Mantenimientos_Viajes_Viaje"),
            "showEdit" => $this->isFeatureAutorized("Mantenimientos_Viajes_Viaje"),
            "showDel" => $this->isFeatureAutorized("Mantenimientos_Viajes_Viaje"),
            "showView" => true
        ]);
    }
}