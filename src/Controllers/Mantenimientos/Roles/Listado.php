<?php
namespace Controllers\Mantenimientos\Roles;

use Controllers\PrivateController;
use Views\Renderer;
use Dao\Security\Security;

const LIST_VIEW_TEMPLATE = "mantenimientos/roles/listado";

class Listado extends PrivateController
{
    private array $rolesList = [];
    public function run(): void
    {
        $this->rolesList = Security::getRoles();
        Renderer::render(LIST_VIEW_TEMPLATE, $this->prepareViewData());
    }

    private function prepareViewData()
    {
        return [
            "roles" => $this->rolesList,
            "showEdit" => $this->isFeatureAutorized("Mantenimientos_Roles_Formulario"),
            "showNew" => $this->isFeatureAutorized("Mantenimientos_Roles_Rol"),
            "showDel" => $this->isFeatureAutorized("Mantenimientos_Roles_Rol"),
            "showMod" => $this->isFeatureAutorized("Mantenimientos_Roles_Rol")
        ];
    }
}
