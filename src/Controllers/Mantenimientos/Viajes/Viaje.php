<?php

namespace Controllers\Mantenimientos\Viajes;

use Controllers\PrivateController;
use Dao\Viajes;
use Utilities\Site;
use Views\Renderer;

class Viaje extends PrivateController
{
    private $mode = 'DSP';
    private $viajeId = 0;
    private $horario_id = 0;
    private $fecha = '';
    private $asientos = 45;
    private $error = '';

    private array $viewData = [];

    public function run(): void
    {
        $this->mode = $_GET['mode'] ?? 'DSP';
        $this->viajeId = intval($_GET['id'] ?? 0);

        if ($this->isPostBack()) {
            $this->mode = $_POST['mode'] ?? 'DSP';
            $this->viajeId = intval($_POST['viajeId'] ?? 0);
            $this->horario_id = intval($_POST['horario_id'] ?? 0);
            $this->fecha = $_POST['fecha'] ?? '';
            $this->asientos = intval($_POST['asientos'] ?? 0);

            if ($this->mode !== 'DEL') {
                if ($this->horario_id <= 0 || $this->fecha === '' || $this->asientos <= 0) {
                    $this->error = 'Todos los campos son obligatorios.';
                }
            }

            if ($this->mode === 'INS' && $this->error === '') {
                Viajes::insertAdmin($this->horario_id, $this->fecha, $this->asientos);
                Site::redirectTo('index.php?page=Mantenimientos_Viajes_Listado');
            }

            if ($this->mode === 'UPD' && $this->error === '') {
                Viajes::updateAdmin($this->viajeId, $this->fecha, $this->asientos);
                Site::redirectTo('index.php?page=Mantenimientos_Viajes_Listado');
            }

            if ($this->mode === 'DEL') {
                Viajes::deleteAdmin($this->viajeId);
                Site::redirectToWithMsg(
                    'index.php?page=Mantenimientos_Viajes_Listado',
                    'Viaje eliminado correctamente'
                );
            }
        } else {
            if ($this->viajeId > 0) {
                $viaje = Viajes::getByIdAdmin($this->viajeId);

                if ($viaje) {
                    $this->horario_id = $viaje['horario_id'];
                    $this->fecha = $viaje['fecha'];
                    $this->asientos = $viaje['asientos_disponibles'];
                } else {
                    Site::redirectToWithMsg(
                        'index.php?page=Mantenimientos_Viajes_Listado',
                        'No se encontró el viaje'
                    );
                }
            }
        }

        $horarios = Viajes::getHorariosAdmin();

        foreach ($horarios as $index => $h) {
            $horarios[$index]['selected'] = ($h['id'] == $this->horario_id);
        }

        $this->viewData = [
            'mode' => $this->mode,
            'viajeId' => $this->viajeId,
            'horario_id' => $this->horario_id,
            'fecha' => $this->fecha,
            'asientos' => $this->asientos,
            'error' => $this->error,
            'horarios' => $horarios,

            'isReadonly' => ($this->mode === 'DEL' || $this->mode === 'DSP'),
            'isINS' => ($this->mode === 'INS'),
            'isUPD' => ($this->mode === 'UPD'),
            'isDEL' => ($this->mode === 'DEL'),
            'isDSP' => ($this->mode === 'DSP'),

            'title' => $this->getTitle(),
        ];

        Renderer::render('mantenimientos/viajes/viaje', $this->viewData);
    }

    private function getTitle()
    {
        if ($this->mode === 'INS') {
            return 'Nuevo Viaje';
        }
        if ($this->mode === 'UPD') {
            return 'Editar Viaje';
        }
        if ($this->mode === 'DEL') {
            return 'Eliminar Viaje';
        }

        return 'Detalle de Viaje';
    }
}
