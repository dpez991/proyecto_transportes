<?php

namespace Controllers;

use Utilities\Security;

class Index extends PublicController
{
    public function run(): void
    {
        $viewData = [];

        if (Security::isLogged()) {
            $userId = Security::getUserId();
            $user = Security::getUser();

            $userName = $user['userName'];

            if (Security::isInRol($userId, 'admin')) {
                $viewData['mensaje'] = 'Bienvenido ADMIN: '.$userName;
            } elseif (Security::isInRol($userId, 'cliente')) {
                $viewData['mensaje'] = 'Bienvenido CLIENTE: '.$userName;
            } else {
                $viewData['mensaje'] = 'Bienvenido: '.$userName;
            }
        } else {
            $viewData['mensaje'] = 'Bienvenido a Rutas del Pacífico';
        }

        \Views\Renderer::render('index', $viewData);
    }
}
