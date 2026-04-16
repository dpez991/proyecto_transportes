<?php

use Dao\Table;

// We need to load context or directly connect since Table::obtenerRegistros relies on Context.
// Since we are outside of mvc context, let's just use PDO.

$host = '127.0.0.1';
$db   = 'nwdb';
$user = 'devuser';
$pass = '';
$charset = 'utf8mb4';

$dsn = "mysql:host=$host;dbname=$db;charset=$charset";
$options = [
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    PDO::ATTR_EMULATE_PREPARES   => false,
];

try {
    $pdo = new PDO($dsn, $user, $pass, $options);
    
    // Check tables
    $stmt = $pdo->query('SHOW TABLES');
    $tables = $stmt->fetchAll(PDO::FETCH_COLUMN);
    echo "Tables:\n";
    print_r($tables);

    $tablesToCheck = ['carrito', 'compras', 'detalle_compra', 'viajes'];
    foreach($tablesToCheck as $t) {
        if (in_array($t, $tables)) {
            echo "\nDESCRIBE $t:\n";
            $stmt = $pdo->query("DESCRIBE $t");
            print_r($stmt->fetchAll());
        } else {
            echo "\nTable $t DOES NOT EXIST.\n";
        }
    }

} catch (\PDOException $e) {
    throw new \PDOException($e->getMessage(), (int)$e->getCode());
}
