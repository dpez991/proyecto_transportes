<?php
namespace Controllers\Mantenimientos\Roles;

use Controllers\PrivateController;
use Views\Renderer;
use Dao\Security\Security;
use Utilities\Site;
use Controllers\PrivateNoAuthException;

const ROLES_FORMULARIO_URL = "index.php?page=Mantenimientos_Roles_Formulario";
const ROLES_LISTADO_URL = "index.php?page=Mantenimientos_Roles_Listado";

class Formulario extends PrivateController
{
    private array $viewData = [];
    private $mode;
    private $rolescod;
    private $rol;

    public function run(): void
    {
        $this->LoadPage();
        
        if ($this->isPostBack()) {
            if ($this->mode === 'UPD') {
                $action = $_POST["action"] ?? "";
                $fncod = $_POST["fncod"] ?? "";
                
                if ($action === "assign" && $fncod !== "") {
                    Security::assignFeatureToRol($this->rolescod, $fncod);
                } elseif ($action === "remove" && $fncod !== "") {
                    Security::removeFeatureFromRol($fncod, $this->rolescod);
                }
                Site::redirectTo(ROLES_FORMULARIO_URL . "&mode=UPD&id=" . $this->rolescod);
            }
        }
        
        $this->GenerarViewData();
        Renderer::render("mantenimientos/roles/formulario", $this->viewData);
    }

    private function LoadPage()
    {
        $this->mode = $_GET["mode"] ?? '';
        if ($this->mode !== 'DSP' && $this->mode !== 'UPD') {
            Site::redirectToWithMsg(ROLES_LISTADO_URL, "Modo no válido");
        }
        
        if ($this->mode === 'UPD' && (!$this->isFeatureAutorized("Mantenimientos_Roles_Formulario"))) {
            throw new PrivateNoAuthException();
        }
        
        $this->rolescod = $_GET["id"] ?? '';
        if ($this->rolescod === '') {
            Site::redirectToWithMsg(ROLES_LISTADO_URL, "Error al cargar formulario, Se requiere Código de Rol");
        }
        
        $this->CargarDatos();
    }

    private function CargarDatos()
    {
        $this->rol = Security::getRolById($this->rolescod);
        if (!$this->rol) {
            Site::redirectToWithMsg(ROLES_LISTADO_URL, "No se encontró el Rol");
        }
    }

    private function GenerarViewData()
    {
        $this->viewData["mode"] = $this->mode;
        $this->viewData["rolescod"] = $this->rol["rolescod"];
        $this->viewData["rolesdsc"] = $this->rol["rolesdsc"];
        $this->viewData["rolesest"] = $this->rol["rolesest"];
        
        $this->viewData["isReadonly"] = true; // El form de creación de rol no es parte del scope actual
        $this->viewData["showEdit"] = $this->mode === 'UPD';
        
        $this->viewData["funcionesAsignadas"] = Security::getFeaturesByRol($this->rolescod);
        $this->viewData["funcionesDisponibles"] = Security::getUnAssignedFeatures($this->rolescod);
    }
}
