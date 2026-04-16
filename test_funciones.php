<?php
$host = '127.0.0.1';
$db   = 'nwdb';
$user = 'devuser';
$pass = '';

$dsn = "mysql:host=$host;dbname=$db;charset=utf8mb4";
try {
    $pdo = new PDO($dsn, $user, $pass, [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION, PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC]);
    $stmt = $pdo->query('SELECT * FROM funciones;');
    print_r($stmt->fetchAll());
    
    $stmt = $pdo->query('SELECT * FROM funciones_roles;');
    print_r($stmt->fetchAll());
} catch (\Exception $e) {
    echo "Error: " . $e->getMessage();
}
