<?php

namespace Controllers\Admin;

use Controllers\PrivateController;
use Dao\AdminDAO;
use Views\Renderer;

class Dashboard extends PrivateController
{
    public function run(): void
    {
        $resume = AdminDAO::getDashboardResume();

        Renderer::render('admin/dashboard', $resume);
    }
}
