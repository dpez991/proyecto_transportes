<?php

namespace Controllers;

class Index extends PublicController
{
    public function run(): void
    {
        // Landing única del sistema (para TODOS)
        \Utilities\Site::redirectTo('index.php?page=Public_Home');
    }
}
