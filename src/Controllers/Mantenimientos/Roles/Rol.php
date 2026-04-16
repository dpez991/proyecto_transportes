<?php

namespace Controllers\Mantenimientos\Roles;

use Controllers\PrivateController;
use Dao\Security\Security;
use Utilities\Site;
use Views\Renderer;

class Rol extends PrivateController
{
    private $mode = 'DSP';
    private $rolescod = '';
    private $rolesdsc = '';
    private $rolesest = 'ACT';
    private $error = '';

    private $viewData = [];

    public function run(): void
    {
        $this->mode = $_GET['mode'] ?? 'DSP';
        $this->rolescod = $_GET['id'] ?? '';

        if ($this->isPostBack()) {
            $this->rolescod = $_POST['rolescod'] ?? '';
            $this->rolesdsc = $_POST['rolesdsc'] ?? '';
            $this->rolesest = $_POST['rolesest'] ?? 'ACT';
            $this->mode = $_POST['mode'] ?? 'DSP';

            if ($this->mode === 'INS') {
                if ($this->rolescod === '' || $this->rolesdsc === '') {
                    $this->error = 'El código y la descripción son obligatorios.';
                } elseif (Security::getRolById($this->rolescod)) {
                    $this->error = 'Este código de rol ya existe.';
                } else {
                    Security::addNewRol($this->rolescod, $this->rolesdsc, $this->rolesest);
                    Site::redirectTo('index.php?page=Mantenimientos_Roles_Listado');
                }
            } elseif ($this->mode === 'UPD') {
                if ($this->rolesdsc === '') {
                    $this->error = 'La descripción es obligatoria.';
                } else {
                    Security::updateRol($this->rolescod, $this->rolesdsc, $this->rolesest);
                    Site::redirectTo('index.php?page=Mantenimientos_Roles_Listado');
                }
            } elseif ($this->mode === 'DEL') {
                if (strtolower($this->rolescod) === 'cliente') {
                    Site::redirectToWithMsg('index.php?page=Mantenimientos_Roles_Listado', 'El rol cliente es obligatorio y no puede ser eliminado');
                }
                if (Security::isRolInUse($this->rolescod)) {
                    Site::redirectToWithMsg('index.php?page=Mantenimientos_Roles_Listado', 'No se puede eliminar el rol porque está asignado a uno o más usuarios.');
                }

                Security::deleteRolDependencies($this->rolescod);
                Security::deleteRol($this->rolescod);
                Site::redirectTo('index.php?page=Mantenimientos_Roles_Listado');
            }
        } else {
            if ($this->mode === 'UPD' || $this->mode === 'DEL' || $this->mode === 'DSP') {
                $rolDao = Security::getRolById($this->rolescod);
                if ($rolDao) {
                    $this->rolescod = $rolDao['rolescod'];
                    $this->rolesdsc = $rolDao['rolesdsc'];
                    $this->rolesest = $rolDao['rolesest'];
                } else {
                    Site::redirectToWithMsg('index.php?page=Mantenimientos_Roles_Listado', 'No se encontró el Rol');
                }
            }
        }

        $this->GenerarViewData();
        Renderer::render('mantenimientos/roles/rol', $this->viewData);
    }

    private function GenerarViewData()
    {
        $this->viewData['mode'] = $this->mode;
        $this->viewData['rolescod'] = $this->rolescod;
        $this->viewData['rolesdsc'] = $this->rolesdsc;
        $this->viewData['rolesest'] = $this->rolesest;
        $this->viewData['error'] = $this->error;

        $this->viewData['isReadonly'] = ($this->mode === 'DEL' || $this->mode === 'DSP');
        $this->viewData['isInsert'] = ($this->mode === 'INS');
        $this->viewData['isUPD'] = ($this->mode === 'UPD');
        $this->viewData['isDEL'] = ($this->mode === 'DEL');
        $this->viewData['isDSP'] = ($this->mode === 'DSP');

        $this->viewData['isRoleAct'] = ($this->rolesest === 'ACT');
        $this->viewData['isRoleIna'] = ($this->rolesest === 'INA');

        $this->viewData['title'] = 'Gestión de Rol';
        if ($this->mode === 'INS') {
            $this->viewData['title'] = 'Crear Nuevo Rol';
        }
        if ($this->mode === 'UPD') {
            $this->viewData['title'] = 'Actualizar Rol';
        }
        if ($this->mode === 'DEL') {
            $this->viewData['title'] = 'Eliminar Rol';
        }
        if ($this->mode === 'DSP') {
            $this->viewData['title'] = 'Ver Rol';
        }
    }
}
