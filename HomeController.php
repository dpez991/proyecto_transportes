<?php
class HomeController {
    public function index() {
        $title = "Inicio - Nuestra Plataforma";
        include 'views/home.php';
    }

    public function about() {
        $title = "Sobre Nosotros";
        include 'views/about.php';
    }

    public function contact() {
        $title = "Contacto";
        include 'views/contact.php';
    }
}