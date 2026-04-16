<?php

namespace Controllers\Mantenimientos\Buses;

use Controllers\PrivateController;
use Dao\BusDAO;
use Utilities\Site;
use Views\Renderer;

class Bus extends PrivateController
{
    private $mode = 'DSP';
    private $busId = 0;
    private $codigo_bus = '';
    private $capacidad = 45;
    private $estado = 'ACT';
    private $error = '';

    private array $viewData = [];

    public function run(): void
    {
        $this->mode = $_GET['mode'] ?? 'DSP';
        $this->busId = intval($_GET['id'] ?? 0);

        if ($this->isPostBack()) {
            $this->mode = $_POST['mode'] ?? 'DSP';
            $this->busId = intval($_POST['busId'] ?? 0);
            $this->codigo_bus = $_POST['codigo_bus'] ?? '';
            $this->capacidad = intval($_POST['capacidad'] ?? 45);
            $this->estado = $_POST['estado'] ?? 'ACT';

            if ($this->mode === 'INS') {
                if ($this->codigo_bus === '') {
                    $this->error = 'Código de bus obligatorio.';
                } else {
                    BusDAO::insert($this->codigo_bus, $this->capacidad, $this->estado);
                    Site::redirectTo('index.php?page=Mantenimientos_Buses_Listado');
                }
            } elseif ($this->mode === 'UPD') {
                if ($this->codigo_bus === '') {
                    $this->error = 'Código de bus obligatorio.';
                } else {
                    BusDAO::update($this->busId, $this->codigo_bus, $this->capacidad, $this->estado);
                    Site::redirectTo('index.php?page=Mantenimientos_Buses_Listado');
                }
            } elseif ($this->mode === 'DEL') {
                BusDAO::inactivate($this->busId);
                Site::redirectTo('index.php?page=Mantenimientos_Buses_Listado');
            }
        } else {
            if (in_array($this->mode, ['UPD', 'DEL', 'DSP'])) {
                $bus = BusDAO::getById($this->busId);

                if ($bus) {
                    $this->busId = $bus['busId'];
                    $this->codigo_bus = $bus['codigo_bus'];
                    $this->capacidad = $bus['capacidad'];
                    $this->estado = ($bus['estado'] == 1) ? 'ACT' : 'INA';
                } else {
                    Site::redirectTo('index.php?page=Mantenimientos_Buses_Listado');
                }
            }
        }

        $this->viewData = [
            'mode' => $this->mode,
            'busId' => $this->busId,
            'codigo_bus' => $this->codigo_bus,
            'capacidad' => $this->capacidad,
            'estado' => $this->estado,
            'error' => $this->error,

            'isReadonly' => ($this->mode === 'DEL' || $this->mode === 'DSP'),
            'isINS' => ($this->mode === 'INS'),
            'isUPD' => ($this->mode === 'UPD'),
            'isDEL' => ($this->mode === 'DEL'),

            'isAct' => ($this->estado === 'ACT'),
            'isIna' => ($this->estado === 'INA'),

            'title' => $this->getTitle(),
        ];

        Renderer::render('mantenimientos/buses/bus', $this->viewData);
    }

    private function getTitle()
    {
        if ($this->mode === 'INS') {
            return 'Nuevo Bus';
        }
        if ($this->mode === 'UPD') {
            return 'Editar Bus';
        }
        if ($this->mode === 'DEL') {
            return 'Inactivar Bus';
        }

        return 'Detalle de Bus';
    }
}
