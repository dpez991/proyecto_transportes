<?php

namespace Controllers;

class Index extends PublicController
{
    public function run(): void
    {
        \Utilities\Site::redirectTo('index.php?page=Public_Home');
    }
}
