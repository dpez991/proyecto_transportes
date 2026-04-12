<?php
namespace Controllers\Mantenimientos\Usuarios;

use Controllers\PrivateController;
use Views\Renderer;
use Dao\Security\Security;

const LIST_VIEW_TEMPLATE = "mantenimientos/usuarios/listado";

class Listado extends PrivateController
{
    private array $usuariosList = [];
    public function run(): void
    {
        $rawUsuarios = Security::getUsuarios();
        foreach ($rawUsuarios as $idx => $usuario) {
            $rawUsuarios[$idx]["isActivo"] = ($usuario["userest"] === 'ACT');
            $rawUsuarios[$idx]["isInactive"] = ($usuario["userest"] === 'INA');
            
            $rolesAsignados = Security::getRolesByUsuario($usuario["usercod"]);
            if (count($rolesAsignados) > 0) {
                $rolesDsc = array_map(function($r) { return $r["rolesdsc"]; }, $rolesAsignados);
                $rawUsuarios[$idx]["userroles"] = implode(", ", $rolesDsc);
            } else {
                $rawUsuarios[$idx]["userroles"] = "Ninguno";
            }
        }
        $this->usuariosList = $rawUsuarios;
        Renderer::render(LIST_VIEW_TEMPLATE, $this->prepareViewData());
    }

    private function prepareViewData()
    {
        return [
            "usuarios" => $this->usuariosList,
            "showEdit" => $this->isFeatureAutorized("Mantenimientos_Usuarios_Formulario"),
            "showMod" => $this->isFeatureAutorized("Mantenimientos_Usuarios_Usuario"),
            "showDel" => $this->isFeatureAutorized("Mantenimientos_Usuarios_Usuario")
        ];
    }
}
