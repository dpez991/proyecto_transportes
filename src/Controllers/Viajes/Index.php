<?php

namespace Controllers\Viajes;

use Controllers\PublicController;
use Views\Renderer;
use Dao\Viajes;

class Index extends PublicController
{
    public function run(): void
    {
        $viewData = [];

        $viewData["viajes"] = Viajes::getAll();

        Renderer::render("viajes/index", $viewData);
    }
}