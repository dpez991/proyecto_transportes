<?php

namespace Controllers\Viajes;

use Controllers\PublicController;
use Dao\Viajes;
use Views\Renderer;

class Show extends PublicController
{
    public function run(): void
    {
        // 🔥 AJAX
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $horario_id = $_POST['horario_id'] ?? 0;
            $fecha = $_POST['fecha'] ?? '';

            header('Content-Type: application/json');

            $hoy = date('Y-m-d');

            if ($fecha < $hoy) {
                echo json_encode([
                    'success' => false,
                    'asientos' => 0,
                ]);
                exit;
            }

            // ❌ YA NO CREAMOS NADA
            $viaje = Viajes::obtenerViajePorHorarioYFecha($horario_id, $fecha);

            echo json_encode([
                'success' => true,
                'asientos' => $viaje['asientos_disponibles'],
            ]);

            exit;
        }

        // 🔥 NORMAL
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
                'Viaje no encontrado.'
            );
        }

        $baseDir = \Utilities\Context::getContextByKey('BASE_DIR');

        function limpiar($txt)
        {
            return str_replace(
                ['á', 'é', 'í', 'ó', 'ú', ' '],
                ['a', 'e', 'i', 'o', 'u', ''],
                strtolower($txt)
            );
        }

        $imagenes = [];

        $imgOrigen = 'public/imgs/rutas/'.limpiar($viaje['origen']).'.jpg';
        $imgDestino = 'public/imgs/rutas/'.limpiar($viaje['destino']).'.jpg';

        if (file_exists($imgOrigen)) {
            $imagenes[] = $baseDir.'/'.$imgOrigen;
        }

        if (file_exists($imgDestino)) {
            $imagenes[] = $baseDir.'/'.$imgDestino;
        }

        if (empty($imagenes)) {
            $imagenes[] = 'https://placehold.co/800x400';
        }

        $viewData = [
            'horario_id' => $viaje['horario_id'],
            'origen' => $viaje['origen'],
            'destino' => $viaje['destino'],
            'hora' => date('h:i A', strtotime($viaje['hora'])),
            'imagenes' => $imagenes,
        ];

        Renderer::render('viajes/show', $viewData);
    }
}
