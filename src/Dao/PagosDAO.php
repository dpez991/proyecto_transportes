<?php

namespace Dao;

class PagosDAO extends Table
{
    public static function insertarPago($compra_id, $metodo, $estado, $paypal_order_id, $paypal_capture_id, $payer_nombre, $payer_email, $payer_id, $monto, $moneda, $direccion, $json_response)
    {
        $sql = "INSERT INTO pagos (
                    compra_id, metodo, estado, paypal_order_id, paypal_capture_id, 
                    payer_nombre, payer_email, payer_id, monto, moneda, 
                    direccion, json_response, fecha
                ) VALUES (
                    :compra_id, :metodo, :estado, :paypal_order_id, :paypal_capture_id, 
                    :payer_nombre, :payer_email, :payer_id, :monto, :moneda, 
                    :direccion, :json_response, NOW()
                );";
        
        return self::executeNonQuery($sql, [
            "compra_id" => $compra_id,
            "metodo" => $metodo,
            "estado" => $estado,
            "paypal_order_id" => $paypal_order_id,
            "paypal_capture_id" => $paypal_capture_id,
            "payer_nombre" => $payer_nombre,
            "payer_email" => $payer_email,
            "payer_id" => $payer_id,
            "monto" => $monto,
            "moneda" => $moneda,
            "direccion" => $direccion,
            "json_response" => $json_response
        ]);
    }
}
