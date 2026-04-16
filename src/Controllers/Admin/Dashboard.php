<?php

namespace Controllers\Admin;

use Controllers\PrivateController;
use Views\Renderer;
use Dao\AdminDAO;

class Dashboard extends PrivateController
{
    private array $viewData = [];

    public function run(): void
    {
        $resume = AdminDAO::getDashboardResume();

        $this->viewData["totalUsuarios"] = $resume["totalUsuarios"];
        $this->viewData["totalViajes"] = $resume["totalViajes"];
        $this->viewData["totalCompras"] = $resume["totalCompras"];

        Renderer::render("admin/dashboard", $this->viewData);
    }
}