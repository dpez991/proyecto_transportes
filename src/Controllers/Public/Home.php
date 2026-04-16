<?php

namespace Controllers\Public;

use Controllers\PublicController;
use Views\Renderer;

class Home extends PublicController
{
    public function run(): void
    {
        $mode = $_GET['mode'] ?? 'index';
        $viewData = [];

        if ($mode === 'about') {
            Renderer::render('home/about', $viewData);
        } elseif ($mode === 'contact') {
            Renderer::render('home/contact', $viewData);
        } else {
            Renderer::render('home/index', $viewData);
        }
    }
}
