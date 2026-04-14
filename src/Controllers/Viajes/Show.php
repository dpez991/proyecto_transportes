<?php

namespace Controllers\Viajes;

use Controllers\PublicController;
use Views\Renderer;
use Dao\Viajes;

class Show extends PublicController
{
    public function run(): void
    {
        $viewData = [];

        $id = $_GET["id"] ?? 0;

        $viewData["viaje"] = Viajes::getById($id);

        Renderer::render("viajes/show", $viewData);
    }
}