<style>
.success-container {
    max-width: 600px;
    margin: 50px auto;
    text-align: center;
    background: #fff;
    padding: 50px 30px;
    border-radius: 12px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.1);
}
.success-icon {
    font-size: 5rem;
    color: #28a745;
    margin-bottom: 20px;
}
.success-title {
    color: #001f3f;
    font-size: 2rem;
    margin-bottom: 15px;
}
.success-text {
    font-size: 1.1rem;
    color: #666;
    margin-bottom: 30px;
}
.btn-primary {
    background: linear-gradient(90deg, #001f3f, #003366);
    color: #fff;
    padding: 12px 25px;
    border-radius: 6px;
    text-decoration: none;
    font-weight: bold;
    transition: 0.3s;
}
.btn-primary:hover {
    box-shadow: 0 4px 10px rgba(0,31,63,0.3);
}
</style>

<div class="success-container">
    <i class="fas fa-check-circle success-icon"></i>
    <h1 class="success-title">¡Compra Exitosa!</h1>
    <p class="success-text">Compra exitosa, tu pago ha sido procesado correctamente y tus asientos están reservados.</p>
    
    {{if payer_name}}
    <div style="background:#f8f9fa; border: 1px solid #e0e0e0; border-radius:8px; padding:20px; text-align:left; margin-bottom:30px; box-shadow:inset 0 0 10px rgba(0,0,0,0.02);">
        <h3 style="color:#001f3f; border-bottom: 2px solid #ddd; padding-bottom:10px; margin-top:0;">Detalles de la Transacción</h3>
        
        <p style="margin: 10px 0;"><strong><i class="fas fa-user" style="color:#0074D9; width:20px;"></i> Pago realizado por:</strong><br>
        <span style="color:#555; margin-left: 25px;">{{payer_name}}</span></p>

        <p style="margin: 10px 0;"><strong><i class="fas fa-envelope" style="color:#0074D9; width:20px;"></i> Email:</strong><br>
        <span style="color:#555; margin-left: 25px;">{{payer_email}}</span></p>

        <p style="margin: 10px 0;"><strong><i class="fas fa-receipt" style="color:#0074D9; width:20px;"></i> ID de transacción:</strong><br>
        <span style="color:#555; margin-left: 25px;">{{transaction_id}}</span></p>

        <p style="margin: 10px 0;"><strong><i class="fas fa-info-circle" style="color:#0074D9; width:20px;"></i> Estado:</strong><br>
        <span style="color:#28a745; font-weight:bold; margin-left: 25px;">{{status}}</span></p>

        <p style="margin: 10px 0;"><strong><i class="fas fa-map-marker-alt" style="color:#0074D9; width:20px;"></i> Dirección:</strong><br>
        <span style="color:#555; margin-left: 25px;">{{payer_address}}</span></p>
    </div>
    {{endif payer_name}}

    <a href="index.php?page=Public_Home" class="btn-primary" style="display:inline-block; margin-top:10px;">Volver al Inicio</a>
</div>
