<style>
.detail-container {
    max-width: 900px;
    margin: 40px auto;
    background: #fff;
    border-radius: 10px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.1);
    overflow: hidden;
}
.detail-header {
    background: #001f3f;
    color: white;
    padding: 25px;
}
.detail-section {
    padding: 20px 25px;
    border-bottom: 1px solid #eee;
}
.detail-section h3 {
    margin-bottom: 15px;
    color: #001f3f;
}
.detail-row {
    margin-bottom: 8px;
}
.detail-label {
    font-weight: bold;
}
.ticket {
    border-bottom: 1px dashed #ddd;
    padding: 10px 0;
}
.total {
    text-align: right;
    font-size: 1.3rem;
    font-weight: bold;
    color: #28a745;
}
.btn-back {
    display: inline-block;
    margin: 20px;
    background: #6c757d;
    color: white;
    padding: 8px 14px;
    border-radius: 5px;
    text-decoration: none;
}
</style>

<div class="detail-container">

    <div class="detail-header">
        <h2>Compra #{{compra_id}}</h2>
        <p>{{fecha_compra}}</p>
    </div>

    <div class="detail-section">
        <h3>Cliente</h3>
        <div class="detail-row"><span class="detail-label">Nombre:</span> {{username}}</div>
        <div class="detail-row"><span class="detail-label">Correo:</span> {{useremail}}</div>
    </div>

    <div class="detail-section">
        <h3>Pago</h3>
        <div class="detail-row"><span class="detail-label">Método:</span> {{metodo}}</div>
        <div class="detail-row"><span class="detail-label">Estado:</span> {{estado_pago}}</div>
        <div class="detail-row"><span class="detail-label">Order ID:</span> {{paypal_order_id}}</div>
        <div class="detail-row"><span class="detail-label">Capture ID:</span> {{paypal_capture_id}}</div>
        <div class="detail-row"><span class="detail-label">Pagador:</span> {{payer_nombre}}</div>
        <div class="detail-row"><span class="detail-label">Email:</span> {{payer_email}}</div>
        <div class="detail-row"><span class="detail-label">Dirección:</span> {{direccion}}</div>
    </div>

    <div class="detail-section">
        <h3>Boletos</h3>

        {{foreach detalles}}
        <div class="ticket">
            <div>{{origen}} → {{destino}}</div>
            <div>{{fecha_viaje}} {{hora}}</div>
            <div>{{cantidad}} x {{tipo_asiento}}</div>
            <div>Subtotal: L. {{subtotal}}</div>
        </div>
        {{endfor detalles}}

        <div class="total">
            Total: L. {{total_compra}}
        </div>
    </div>

    <a href="index.php?page=Mantenimientos_Compras_Listado" class="btn-back">← Volver</a>

</div>