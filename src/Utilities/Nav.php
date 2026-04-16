<?php

namespace Utilities;

class Nav
{
    public static function setPublicNavContext()
    {
        $tmpNAVIGATION = Context::getContextByKey('PUBLIC_NAVIGATION');
        if ($tmpNAVIGATION === '') {
            $navigationData = self::getNavFromJson()['public'];
            $saveToSession = intval(Context::getContextByKey('DEVELOPMENT')) !== 1;
            Context::setContext('PUBLIC_NAVIGATION', $navigationData, $saveToSession);
        }
    }

    public static function setNavContext()
    {
        $tmpNAVIGATION = Context::getContextByKey('NAVIGATION');

        if ($tmpNAVIGATION === '') {
            $tmpNAVIGATION = [];
            $userID = Security::getUserId();
            $isLogged = Security::isLogged();

            $json = self::getNavFromJson();

            $publicNav = $json['public'];
            $privateNav = $json['private'];

            // 🔥 1. PUBLIC NAV (FILTRADO)
            foreach ($publicNav as $navEntry) {
                // ❌ Si está logueado → NO mostrar login/register
                if ($isLogged && (
                    $navEntry['id'] === 'Menu_SignIn'
                    || $navEntry['id'] === 'Menu_SignUp'
                )) {
                    continue;
                }

                $tmpNAVIGATION[] = $navEntry;
            }

            // 🔥 2. CARRITO SOLO LOGUEADO
            if ($isLogged) {
                $tmpNAVIGATION[] = [
                    'id' => 'Menu_Checkout',
                    'nav_url' => 'index.php?page=Checkout_Checkout',
                    'nav_label' => '<i class="fas fa-shopping-cart"></i>&nbsp;Carrito',
                ];
            }

            // 🔥 3. PRIVADOS (ADMIN)
            foreach ($privateNav as $navEntry) {
                if ($isLogged && Security::isAuthorized($userID, $navEntry['id'], 'MNU')) {
                    $tmpNAVIGATION[] = $navEntry;
                }
            }

            $saveToSession = intval(Context::getContextByKey('DEVELOPMENT')) !== 1;
            Context::setContext('NAVIGATION', $tmpNAVIGATION, $saveToSession);
        }
    }

    public static function invalidateNavData()
    {
        Context::removeContextByKey('NAVIGATION_DATA');
        Context::removeContextByKey('NAVIGATION');
        Context::removeContextByKey('PUBLIC_NAVIGATION');
    }

    private static function getNavFromJson()
    {
        $jsonContent = Context::getContextByKey('NAVIGATION_DATA');

        if ($jsonContent === '') {
            $filePath = 'nav.config.json';

            if (!file_exists($filePath)) {
                throw new \Exception(sprintf('%s does not exist', $filePath));
            }

            if (!is_readable($filePath)) {
                throw new \Exception(sprintf('%s file is not readable', $filePath));
            }

            $jsonContent = file_get_contents($filePath);

            $saveToSession = intval(Context::getContextByKey('DEVELOPMENT')) !== 1;
            Context::setContext('NAVIGATION_DATA', $jsonContent, $saveToSession);
        }

        return json_decode($jsonContent, true);
    }

    private function __construct()
    {
    }

    private function __clone()
    {
    }
}
