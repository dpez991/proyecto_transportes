<?php

namespace Controllers\Mantenimientos\Buses;

use Controllers\PrivateController;
use Views\Renderer;
use Dao\BusDAO;

const LIST_VIEW_TEMPLATE = "mantenimientos/buses/listado";

class Listado extends PrivateController
{
    public function run(): void
    {
        Renderer::render(LIST_VIEW_TEMPLATE, [
            "buses" => BusDAO::getAll(),
            "showNew" => $this->isFeatureAutorized("Mantenimientos_Buses_Bus"),
            "showEdit" => $this->isFeatureAutorized("Mantenimientos_Buses_Bus"),
            "showDel" => $this->isFeatureAutorized("Mantenimientos_Buses_Bus"),
            "showView" => true
        ]);
    }
}