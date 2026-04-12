<?php
namespace Controllers\Mantenimientos\Usuarios;

use Controllers\PrivateController;
use Views\Renderer;
use Dao\Security\Security;
use Utilities\Site;
use Controllers\PrivateNoAuthException;

const USUARIOS_FORMULARIO_URL = "index.php?page=Mantenimientos_Usuarios_Formulario";
const USUARIOS_LISTADO_URL = "index.php?page=Mantenimientos_Usuarios_Listado";

class Formulario extends PrivateController
{
    private array $viewData = [];
    private $mode;
    private $usercod;
    private $usuario;

    public function run(): void
    {
        $this->LoadPage();
        
        if ($this->isPostBack()) {
            if ($this->mode === 'UPD') {
                $action = $_POST["action"] ?? "";
                $rolescod = $_POST["rolescod"] ?? "";
                
                if ($action === "assign" && $rolescod !== "") {
                    // Logic: Single role per user
                    $currentRoles = Security::getRolesByUsuario($this->usercod);
                    foreach ($currentRoles as $cr) {
                        if ($cr['rolescod'] !== $rolescod) {
                            Security::removeRolFromUser($this->usercod, $cr['rolescod']);
                        }
                    }
                    Security::assignRolToUser($this->usercod, $rolescod);
                    
                    if ($this->usercod == \Utilities\Security::getUserId()) {
                        \Utilities\Nav::invalidateNavData();
                    }
                } elseif ($action === "remove" && $rolescod !== "") {
                    // Logic: User must have at least one active role. 'cliente' is the base role.
                    if (strtolower($rolescod) === 'cliente') {
                        Site::redirectToWithMsg(USUARIOS_FORMULARIO_URL . "&mode=UPD&id=" . $this->usercod, "El rol cliente es el rol base del sistema y no puede ser inactivado.");
                    }
                    
                    Security::removeRolFromUser($this->usercod, $rolescod);
                    // Automatically assign 'cliente' as the base role
                    Security::assignRolToUser($this->usercod, 'cliente');
                    
                    if ($this->usercod == \Utilities\Security::getUserId()) {
                        \Utilities\Nav::invalidateNavData();
                    }
                }
                Site::redirectTo(USUARIOS_FORMULARIO_URL . "&mode=UPD&id=" . $this->usercod);
            }
        }
        
        $this->GenerarViewData();
        Renderer::render("mantenimientos/usuarios/formulario", $this->viewData);
    }

    private function LoadPage()
    {
        $this->mode = $_GET["mode"] ?? '';
        if ($this->mode !== 'DSP' && $this->mode !== 'UPD') {
            Site::redirectToWithMsg(USUARIOS_LISTADO_URL, "Modo no válido");
        }
        
        if ($this->mode === 'UPD' && !$this->isFeatureAutorized("Mantenimientos_Usuarios_Formulario")) {
            throw new PrivateNoAuthException();
        }
        
        $this->usercod = intval($_GET["id"] ?? '0');
        if ($this->usercod <= 0) {
            Site::redirectToWithMsg(USUARIOS_LISTADO_URL, "Error al cargar formulario, Se requiere Id del Usuario");
        }
        
        $this->CargarDatos();
    }

    private function CargarDatos()
    {
        $this->usuario = Security::getUsuarioById($this->usercod);
        if (!$this->usuario) {
            Site::redirectToWithMsg(USUARIOS_LISTADO_URL, "No se encontró el Usuario");
        }
    }

    private function GenerarViewData()
    {
        $this->viewData["mode"] = $this->mode;
        $this->viewData["usercod"] = $this->usuario["usercod"];
        $this->viewData["useremail"] = $this->usuario["useremail"];
        $this->viewData["username"] = $this->usuario["username"];
        $this->viewData["usertipo"] = $this->usuario["usertipo"];
        
        $this->viewData["isReadonly"] = true; // El form en sí es readonly para datos base
        $this->viewData["showEdit"] = $this->mode === 'UPD';
        
        $this->viewData["rolesAsignados"] = Security::getRolesByUsuario($this->usercod);
        $this->viewData["rolesDisponibles"] = Security::getUnAssignedRoles($this->usercod);
    }
}
