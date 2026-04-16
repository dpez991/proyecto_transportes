<?php

namespace Dao\Security;

if (version_compare(phpversion(), '7.4.0', '<')) {
    define('PASSWORD_ALGORITHM', 1);  // BCRYPT
} else {
    define('PASSWORD_ALGORITHM', '2y');  // BCRYPT
}

class Security extends \Dao\Table
{
    public static function getUsuarios($filter = '', $page = -1, $items = 0)
    {
        $sqlstr = '';
        if ($filter == '' && $page == -1 && $items == 0) {
            $sqlstr = 'SELECT * FROM usuario;';
        } else {
            if ($page == -1 && $items == 0) {
                $sqlstr = sprintf('SELECT * FROM usuarios %s;', $filter);
            } else {
                $offset = ($page - 1 * $items);
                $sqlstr = sprintf(
                    'SELECT * FROM usuarios %s limit %d, %d;',
                    $filter,
                    $offset,
                    $items
                );
            }
        }

        return self::obtenerRegistros($sqlstr, []);
    }

    public static function newUsuario($email, $password, $username)
    {
        if (!\Utilities\Validators::IsValidEmail($email)) {
            throw new \Exception('Correo no es válido');
        }
        if (!\Utilities\Validators::IsValidPassword($password)) {
            throw new \Exception('Contraseña debe ser almenos 8 caracteres, 1 número, 1 mayúscula, 1 símbolo especial');
        }

        $newUser = self::_usuarioStruct();
        $hashedPassword = self::_hashPassword($password);

        unset($newUser['usercod']);
        unset($newUser['userfching']);
        unset($newUser['userpswdchg']);

        $newUser['useremail'] = $email;
        $newUser['username'] = $username;
        $newUser['userpswd'] = $hashedPassword;
        $newUser['userpswdest'] = Estados::ACTIVO;
        $newUser['userpswdexp'] = date('Y-m-d', time() + 7776000);
        $newUser['userest'] = Estados::ACTIVO;
        $newUser['useractcod'] = hash('sha256', $email.time());
        $newUser['usertipo'] = UsuarioTipo::PUBLICO;

        $sqlIns = 'INSERT INTO `usuario` (`useremail`, `username`, `userpswd`,
        `userfching`, `userpswdest`, `userpswdexp`, `userest`, `useractcod`,
        `userpswdchg`, `usertipo`)
        VALUES
        ( :useremail, :username, :userpswd,
        now(), :userpswdest, :userpswdexp, :userest, :useractcod,
        now(), :usertipo);';

        $result = self::executeNonQuery($sqlIns, $newUser);

        if ($result) {
            $usuario = self::getUsuarioByEmail($email);
            if ($usuario) {
                self::assignRolToUser($usuario['usercod'], 'cliente');
            }
        }

        return $result;
    }

    public static function getUsuarioByEmail($email)
    {
        $sqlstr = "SELECT * from `usuario` where `useremail` = :useremail and `userest` = 'ACT';";
        $params = ['useremail' => $email];

        return self::obtenerUnRegistro($sqlstr, $params);
    }

    public static function getUsuarioById($userCod)
    {
        $sqlstr = 'SELECT * from `usuario` where `usercod` = :usercod ;';
        $params = ['usercod' => $userCod];

        return self::obtenerUnRegistro($sqlstr, $params);
    }

    private static function _saltPassword($password)
    {
        return hash_hmac(
            'sha256',
            $password,
            \Utilities\Context::getContextByKey('PWD_HASH')
        );
    }

    private static function _hashPassword($password)
    {
        return password_hash(self::_saltPassword($password), PASSWORD_ALGORITHM);
    }

    public static function verifyPassword($raw_password, $hash_password)
    {
        return password_verify(
            self::_saltPassword($raw_password),
            $hash_password
        );
    }

    private static function _usuarioStruct()
    {
        return [
            'usercod' => '',
            'useremail' => '',
            'username' => '',
            'userpswd' => '',
            'userfching' => '',
            'userpswdest' => '',
            'userpswdexp' => '',
            'userest' => '',
            'useractcod' => '',
            'userpswdchg' => '',
            'usertipo' => '',
        ];
    }

    public static function getFeature($fncod)
    {
        $sqlstr = 'SELECT * from funciones where fncod=:fncod;';
        $featuresList = self::obtenerRegistros($sqlstr, ['fncod' => $fncod]);

        return count($featuresList) > 0;
    }

    public static function addNewFeature($fncod, $fndsc, $fnest, $fntyp)
    {
        $sqlins = 'INSERT INTO `funciones` (`fncod`, `fndsc`, `fnest`, `fntyp`)
            VALUES (:fncod , :fndsc , :fnest , :fntyp );';

        return self::executeNonQuery(
            $sqlins,
            [
                'fncod' => $fncod,
                'fndsc' => $fndsc,
                'fnest' => $fnest,
                'fntyp' => $fntyp,
            ]
        );
    }

    public static function getFeatureByUsuario($userCod, $fncod)
    {
        $sqlstr = "select * from
        funciones_roles a inner join roles_usuarios b on a.rolescod = b.rolescod
        where a.fnrolest = 'ACT' and b.roleuserest='ACT' and b.usercod=:usercod
        and a.fncod=:fncod limit 1;";
        $resultados = self::obtenerRegistros(
            $sqlstr,
            [
                'usercod' => $userCod,
                'fncod' => $fncod,
            ]
        );

        return count($resultados) > 0;
    }

    public static function getRol($rolescod)
    {
        $sqlstr = 'SELECT * from roles where rolescod=:rolescod;';
        $featuresList = self::obtenerRegistros($sqlstr, ['rolescod' => $rolescod]);

        return count($featuresList) > 0;
    }

    public static function getRolById($rolescod)
    {
        $sqlstr = 'SELECT * from roles where rolescod=:rolescod;';
        $params = ['rolescod' => $rolescod];

        return self::obtenerUnRegistro($sqlstr, $params);
    }

    public static function addNewRol($rolescod, $rolesdsc, $rolesest)
    {
        $sqlins = 'INSERT INTO `roles` (`rolescod`, `rolesdsc`, `rolesest`)
        VALUES (:rolescod, :rolesdsc, :rolesest);';

        return self::executeNonQuery(
            $sqlins,
            [
                'rolescod' => $rolescod,
                'rolesdsc' => $rolesdsc,
                'rolesest' => $rolesest,
            ]
        );
    }

    public static function isUsuarioInRol($userCod, $rolescod)
    {
        $sqlstr = "select * from roles a inner join
        roles_usuarios b on a.rolescod = b.rolescod where a.rolesest = 'ACT'
        and b.roleuserest = 'ACT' and b.usercod=:usercod and a.rolescod=:rolescod limit 1;";
        $resultados = self::obtenerRegistros(
            $sqlstr,
            [
                'usercod' => $userCod,
                'rolescod' => $rolescod,
            ]
        );

        return count($resultados) > 0;
    }

    public static function getRolesByUsuario($userCod)
    {
        $sqlstr = "select * from roles a inner join
        roles_usuarios b on a.rolescod = b.rolescod where a.rolesest = 'ACT'
        and b.roleuserest = 'ACT' and b.usercod=:usercod;";
        $resultados = self::obtenerRegistros(
            $sqlstr,
            [
                'usercod' => $userCod,
            ]
        );

        return $resultados;
    }

    public static function removeRolFromUser($userCod, $rolescod)
    {
        $sqldel = "UPDATE roles_usuarios set roleuserest='INA' 
        where rolescod=:rolescod and usercod=:usercod;";

        return self::executeNonQuery(
            $sqldel,
            ['rolescod' => $rolescod, 'usercod' => $userCod]
        );
    }

    public static function removeFeatureFromRol($fncod, $rolescod)
    {
        $sqldel = "UPDATE funciones_roles set fnrolest='INA'
        where fncod=:fncod and rolescod=:rolescod;";

        return self::executeNonQuery(
            $sqldel,
            ['fncod' => $fncod, 'rolescod' => $rolescod]
        );
    }

    public static function getUnAssignedFeatures($rolescod)
    {
        $sqlstr = "SELECT * FROM funciones a WHERE fnest='ACT' AND a.fncod NOT IN (SELECT b.fncod FROM funciones_roles b WHERE b.rolescod = :rolescod AND b.fnrolest = 'ACT');";

        return self::obtenerRegistros($sqlstr, ['rolescod' => $rolescod]);
    }

    public static function getUnAssignedRoles($userCod)
    {
        $sqlstr = "SELECT * FROM roles a WHERE rolesest='ACT' AND a.rolescod NOT IN (SELECT b.rolescod FROM roles_usuarios b WHERE b.usercod = :usercod AND b.roleuserest = 'ACT');";

        return self::obtenerRegistros($sqlstr, ['usercod' => $userCod]);
    }

    public static function getRoles()
    {
        $sqlstr = 'SELECT * FROM roles;';

        return self::obtenerRegistros($sqlstr, []);
    }

    public static function getFeatures()
    {
        $sqlstr = 'SELECT * FROM funciones;';

        return self::obtenerRegistros($sqlstr, []);
    }

    public static function getFeaturesByRol($rolescod)
    {
        $sqlstr = "select a.* from funciones a inner join
        funciones_roles b on a.fncod = b.fncod where a.fnest = 'ACT'
        and b.rolescod=:rolescod and b.fnrolest='ACT';";

        return self::obtenerRegistros($sqlstr, ['rolescod' => $rolescod]);
    }

    public static function assignRolToUser($userCod, $rolescod)
    {
        $sqlstr = "INSERT INTO roles_usuarios (usercod, rolescod, roleuserest, roleuserfch, roleuserexp) 
                   VALUES (:usercod, :rolescod, 'ACT', NOW(), '2030-01-01') 
                   ON DUPLICATE KEY UPDATE roleuserest='ACT', roleuserfch=NOW(), roleuserexp='2030-01-01';";

        return self::executeNonQuery($sqlstr, ['usercod' => $userCod, 'rolescod' => $rolescod]);
    }

    public static function assignFeatureToRol($rolescod, $fncod)
    {
        $sqlstr = "INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) 
                   VALUES (:rolescod, :fncod, 'ACT', '2030-01-01') 
                   ON DUPLICATE KEY UPDATE fnrolest='ACT', fnexp='2030-01-01';";

        return self::executeNonQuery($sqlstr, ['rolescod' => $rolescod, 'fncod' => $fncod]);
    }

    public static function updateUsuario($usercod, $username, $useremail, $userpswd)
    {
        if (empty($userpswd)) {
            $sqlUpd = 'UPDATE `usuario` SET `username` = :username, `useremail` = :useremail WHERE `usercod` = :usercod;';

            return self::executeNonQuery($sqlUpd, [
                'username' => $username,
                'useremail' => $useremail,
                'usercod' => $usercod,
            ]);
        } else {
            $hashedPassword = self::_hashPassword($userpswd);
            $sqlUpd = 'UPDATE `usuario` SET `username` = :username, `useremail` = :useremail, `userpswd` = :userpswd, `userpswdchg` = now() WHERE `usercod` = :usercod;';

            return self::executeNonQuery($sqlUpd, [
                'username' => $username,
                'useremail' => $useremail,
                'userpswd' => $hashedPassword,
                'usercod' => $usercod,
            ]);
        }
    }

    public static function inactivarUsuario($userCod)
    {
        $sqlUpd = "UPDATE `usuario` SET `userest` = 'INA' WHERE `usercod` = :usercod;";

        return self::executeNonQuery($sqlUpd, ['usercod' => $userCod]);
    }

    public static function activarUsuario($userCod)
    {
        $sqlUpd = "UPDATE `usuario` SET `userest` = 'ACT' WHERE `usercod` = :usercod;";

        return self::executeNonQuery($sqlUpd, ['usercod' => $userCod]);
    }

    public static function updateRol($rolescod, $rolesdsc, $rolesest)
    {
        $sqlUpd = 'UPDATE `roles` SET `rolesdsc` = :rolesdsc, `rolesest` = :rolesest WHERE `rolescod` = :rolescod;';

        return self::executeNonQuery($sqlUpd, [
            'rolesdsc' => $rolesdsc,
            'rolesest' => $rolesest,
            'rolescod' => $rolescod,
        ]);
    }

    public static function deleteRol($rolescod)
    {
        $sqlDel = 'DELETE FROM `roles` WHERE `rolescod` = :rolescod;';

        return self::executeNonQuery($sqlDel, ['rolescod' => $rolescod]);
    }

    public static function deleteRolDependencies($rolescod)
    {
        $sql1 = 'DELETE FROM funciones_roles WHERE rolescod = :rolescod;';
        self::executeNonQuery($sql1, ['rolescod' => $rolescod]);

        $sql2 = 'DELETE FROM roles_usuarios WHERE rolescod = :rolescod;';
        self::executeNonQuery($sql2, ['rolescod' => $rolescod]);
    }

    public static function isRolInUse($rolescod)
    {
        $sqlstr = "SELECT * FROM `roles_usuarios` WHERE `rolescod` = :rolescod AND `roleuserest` = 'ACT';";
        $records = self::obtenerRegistros($sqlstr, ['rolescod' => $rolescod]);

        return count($records) > 0;
    }

    private function __construct()
    {
    }

    private function __clone()
    {
    }
}
