<?php

namespace Controllers\Mantenimientos\Buses;

use Controllers\PrivateController;
use Dao\BusDAO;
use Views\Renderer;

class Listado extends PrivateController
{
    public function run(): void
    {
        $buses = BusDAO::getAll();

        $viewData = [
            'hasBuses' => count($buses) > 0,
            'buses' => $buses,
        ];

        Renderer::render('mantenimientos/buses/listado', $viewData);
    }
}
