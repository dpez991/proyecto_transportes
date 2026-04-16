<?php

namespace Controllers\Viajes;

use Controllers\PublicController;
use Dao\Viajes;
use Views\Renderer;

class Index extends PublicController
{
    public function run(): void
    {
        $viajes = Viajes::obtenerViajesDisponibles();

        $viewData = [
            'viajes' => [],
        ];

        $baseDir = \Utilities\Context::getContextByKey('BASE_DIR');

        foreach ($viajes as $viaje) {
            $imagenNombre = strtolower(str_replace([' ', 'á', 'é', 'í', 'ó', 'ú'], ['', 'a', 'e', 'i', 'o', 'u'], $viaje['destino'])).'.jpg';
            $pathFile = 'public/imgs/rutas/'.$imagenNombre;

            if (file_exists($pathFile)) {
                $viaje['imagenUrl'] = $baseDir.'/'.$pathFile;
            } else {
                $viaje['imagenUrl'] = 'https://placehold.co/600x400/001f3f/ffffff?text='.urlencode($viaje['destino']);
            }

            $viaje['fecha_fmt'] = date('d/m/Y', strtotime($viaje['fecha']));
            $viaje['hora_fmt'] = date('h:i A', strtotime($viaje['hora']));

            $viewData['viajes'][] = $viaje;
        }

        Renderer::render('viajes/index', $viewData);
    }
}
