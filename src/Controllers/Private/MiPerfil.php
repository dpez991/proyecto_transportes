<?php

namespace Controllers\Private;

use Controllers\PrivateController;
use Dao\Security\Security;
use Utilities\Site;
use Views\Renderer;

class MiPerfil extends PrivateController
{
    private int $usercod = 0;
    private string $username = '';
    private string $useremail = '';
    private string $userpswd = '';
    private string $error = '';

    private array $viewData = [];

    public function run(): void
    {
        $this->usercod = \Utilities\Security::getUserId();

        if ($this->usercod <= 0) {
            Site::redirectTo('index.php?page=sec_login');
        }

        if ($this->isPostBack()) {
            $this->username = $_POST['username'] ?? '';
            $this->userpswd = $_POST['userpswd'] ?? '';

            if ($this->username === '') {
                $this->error = 'El nombre es obligatorio.';
            } elseif ($this->userpswd !== '' && !\Utilities\Validators::IsValidPassword($this->userpswd)) {
                $this->error = 'La contraseña debe tener al menos 8 caracteres, una mayúscula, un número y un carácter especial.';
            } else {
                $user = Security::getUsuarioById($this->usercod);

                Security::updateUsuario(
                    $this->usercod,
                    $this->username,
                    $user['useremail'],
                    $this->userpswd
                );

                Site::redirectToWithMsg(
                    'index.php?page=Private_MiPerfil',
                    'Perfil actualizado correctamente'
                );
            }
        }

        $user = Security::getUsuarioById($this->usercod);

        $this->viewData = [
            'usercod' => $user['usercod'],
            'username' => $user['username'],
            'useremail' => $user['useremail'],
            'userest' => $user['userest'],
            'error' => $this->error,
            'title' => 'Mi Perfil',
        ];

        Renderer::render('private/miperfil', $this->viewData);
    }
}
