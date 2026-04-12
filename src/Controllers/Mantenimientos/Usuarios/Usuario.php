<?php
namespace Controllers\Mantenimientos\Usuarios;

use Controllers\PrivateController;
use Views\Renderer;
use Dao\Security\Security;
use Utilities\Site;

class Usuario extends PrivateController
{
    private $mode = 'DSP';
    private $usercod = 0;
    private $username = '';
    private $useremail = '';
    private $userpswd = '';
    private $userest = 'ACT';
    private $error = '';
    
    private $viewData = [];

    public function run(): void
    {
        $this->mode = $_GET["mode"] ?? 'DSP';
        $this->usercod = intval($_GET["id"] ?? '0');
        
        if ($this->isPostBack()) {
            $this->usercod = intval($_POST["usercod"] ?? 0);
            $this->username = $_POST["username"] ?? '';
            $this->useremail = $_POST["useremail"] ?? '';
            $this->userpswd = $_POST["userpswd"] ?? '';
            $this->mode = $_POST["mode"] ?? 'DSP';
            
            if ($this->mode === 'UPD') {
                if ($this->username === '' || $this->useremail === '') {
                    $this->error = "Nombre y correo son obligatorios.";
                } elseif ($this->userpswd !== '' && !\Utilities\Validators::IsValidPassword($this->userpswd)) {
                    $this->error = "La contraseña debe tener al menos 8 caracteres, una mayúscula, un número y un carácter especial.";
                } else {
                    Security::updateUsuario($this->usercod, $this->username, $this->useremail, $this->userpswd);
                    Site::redirectTo("index.php?page=Mantenimientos_Usuarios_Listado");
                }
            } elseif ($this->mode === 'DEL') {
                Security::inactivarUsuario($this->usercod);
                Site::redirectToWithMsg("index.php?page=Mantenimientos_Usuarios_Listado", "Usuario desactivado correctamente");
            } elseif ($this->mode === 'ACT') {
                Security::activarUsuario($this->usercod);
                Site::redirectToWithMsg("index.php?page=Mantenimientos_Usuarios_Listado", "Usuario activado correctamente");
            }
        } else {
            if ($this->mode === 'UPD' || $this->mode === 'DEL' || $this->mode === 'DSP') {
                $userDao = Security::getUsuarioById($this->usercod);
                if ($userDao) {
                    $this->usercod = $userDao["usercod"];
                    $this->username = $userDao["username"];
                    $this->useremail = $userDao["useremail"];
                    $this->userest = $userDao["userest"];
                } else {
                    Site::redirectToWithMsg("index.php?page=Mantenimientos_Usuarios_Listado", "No se encontró el Usuario");
                }
            }
        }
        
        $this->GenerarViewData();
        Renderer::render("mantenimientos/usuarios/usuario", $this->viewData);
    }
    
    private function GenerarViewData()
    {
        $this->viewData["mode"] = $this->mode;
        $this->viewData["usercod"] = $this->usercod;
        $this->viewData["username"] = $this->username;
        $this->viewData["useremail"] = $this->useremail;
        $this->viewData["userest"] = $this->userest;
        $this->viewData["error"] = $this->error;
        
        $this->viewData["isReadonly"] = ($this->mode === 'DEL' || $this->mode === 'DSP');
        $this->viewData["isUPD"] = ($this->mode === 'UPD');
        $this->viewData["isDEL"] = ($this->mode === 'DEL');
        $this->viewData["isDSP"] = ($this->mode === 'DSP');
        
        $this->viewData["title"] = "Gestión de Usuario";
        if ($this->mode === 'UPD') $this->viewData["title"] = "Modificar Usuario";
        if ($this->mode === 'DEL') $this->viewData["title"] = "Inactivar Usuario";
        if ($this->mode === 'DSP') $this->viewData["title"] = "Ver Usuario";
    }
}
