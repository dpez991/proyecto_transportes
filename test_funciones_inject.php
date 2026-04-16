<?php
$host = '127.0.0.1';
$db   = 'nwdb';
$user = 'devuser';
$pass = '';

$dsn = "mysql:host=$host;dbname=$db;charset=utf8mb4";
try {
    $pdo = new PDO($dsn, $user, $pass, [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]);
    
    // Check if Menu_Compra_Historial exists
    $check = $pdo->query("SELECT fncod FROM funciones WHERE fncod = 'Menu_Compra_Historial'")->fetch();
    
    if (!$check) {
        $pdo->exec("INSERT INTO `funciones` (`fncod`, `fndsc`, `fnest`, `fntyp`) VALUES 
        ('Compra_Historial', 'Historial de Compras', 'ACT', 'TRN'),
        ('Menu_Compra_Historial', 'Menú Mi Historial', 'ACT', 'TRN');");
        
        $pdo->exec("INSERT INTO `funciones_roles` (`rolescod`, `fncod`, `fnrolest`, `fnexp`) VALUES 
        ('cliente', 'Compra_Historial', 'ACT', '2030-01-01 00:00:00'),
        ('cliente', 'Menu_Compra_Historial', 'ACT', '2030-01-01 00:00:00');");
        echo "Inserted.";
    } else {
        echo "Already exists.";
    }

} catch (\Exception $e) {
    echo "Error: " . $e->getMessage();
}
