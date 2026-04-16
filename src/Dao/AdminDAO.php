<?php

namespace Dao;

class AdminDAO extends Table
{
    public static function getDashboardResume()
    {
        $sql = "
            SELECT 
                (SELECT COUNT(*) FROM usuario) AS totalUsuarios,
                (SELECT COUNT(*) FROM viajes) AS totalViajes,
                (SELECT COUNT(*) FROM compras) AS totalCompras,
                (SELECT COUNT(*) FROM rutas) AS totalRutas,
                (SELECT COUNT(*) FROM buses) AS totalBuses,

                (SELECT IFNULL(SUM(total),0) 
                 FROM compras 
                 WHERE estado = 'pagado') AS ingresosTotales,

                (SELECT COUNT(*) 
                 FROM compras 
                 WHERE DATE(fecha) = CURDATE()) AS comprasHoy,

                (SELECT COUNT(*) 
                 FROM viajes 
                 WHERE fecha = CURDATE()) AS viajesHoy
        ";

        return self::obtenerUnRegistro($sql, []);
    }
}
