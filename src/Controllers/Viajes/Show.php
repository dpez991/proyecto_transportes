<?php

namespace Controllers\Viajes;

use Controllers\PublicController;
use Dao\Viajes;
use Views\Renderer;

class Show extends PublicController
{
    public function run(): void
    {
        $id = isset($_GET['id']) ? intval($_GET['id']) : 0;

        if ($id === 0) {
            \Utilities\Site::redirectToWithMsg(
                'index.php?page=Viajes_Index',
                'Viaje no válido.'
            );
        }

        $viaje = Viajes::obtenerViajePorId($id);

        if (!$viaje) {
            \Utilities\Site::redirectToWithMsg(
                'index.php?page=Viajes_Index',
                'El viaje solicitado no existe o no tiene asientos disponibles.'
            );
        }

        $baseDir = \Utilities\Context::getContextByKey('BASE_DIR');

        function limpiar($txt)
        {
            $txt = strtolower($txt);
            $txt = str_replace(
                ['á', 'é', 'í', 'ó', 'ú', ' '],
                ['a', 'e', 'i', 'o', 'u', ''],
                $txt
            );

            return $txt;
        }

        $imgOrigen = limpiar($viaje['origen']).'.jpg';
        $pathOrigen = 'public/imgs/rutas/'.$imgOrigen;

        $imgDestino = limpiar($viaje['destino']).'.jpg';
        $pathDestino = 'public/imgs/rutas/'.$imgDestino;

        $imagenes = [];

        if (file_exists($pathOrigen)) {
            $imagenes[] = $baseDir.'/'.$pathOrigen;
        }

        if (file_exists($pathDestino)) {
            $imagenes[] = $baseDir.'/'.$pathDestino;
        }

        if (empty($imagenes)) {
            $imagenes[] = 'https://placehold.co/800x400/001f3f/ffffff?text=Viaje';
        }

        $viaje['fecha_fmt'] = date('d/m/Y', strtotime($viaje['fecha']));
        $viaje['hora_fmt'] = date('h:i A', strtotime($viaje['hora']));

        $viewData = [
            'viaje_id' => $viaje['id'],
            'origen' => $viaje['origen'],
            'destino' => $viaje['destino'],
            'fecha' => $viaje['fecha_fmt'],
            'hora' => $viaje['hora_fmt'],
            'asientos_disponibles' => $viaje['asientos_disponibles'],
            'imagenes' => $imagenes,
        ];

        Renderer::render('viajes/show', $viewData);
    }
}
