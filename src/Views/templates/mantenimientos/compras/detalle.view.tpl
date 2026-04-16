<style>
.dashboard-card { max-width: 750px; margin:2rem auto; background:#fff; border-radius:8px; box-shadow:0 4px 12px rgba(0,0,0,.1); padding:30px; }
.info-row { margin-bottom:12px; }
.info-label { font-weight:bold; color:#495057; }
.btn-secondary { background:#6c757d; color:#fff; padding:8px 16px; border-radius:4px; text-decoration:none; display:inline-block; }
.form-actions { margin-top:20px; text-align:right; }
</style>

<section class="dashboard-card">
    <h2>Detalle de Compra</h2>

    <div class="info-row"><span class="info-label">Compra ID:</span> {{compraId}}</div>
    <div class="info-row"><span class="info-label">Cliente:</span> {{username}}</div>
    <div class="info-row"><span class="info-label">Correo:</span> {{useremail}}</div>
    <div class="info-row"><span class="info-label">Ruta:</span> {{origen}} - {{destino}}</div>
    <div class="info-row"><span class="info-label">Fecha de viaje:</span> {{fecha}}</div>
    <div class="info-row"><span class="info-label">Hora:</span> {{hora}}</div>
    <div class="info-row"><span class="info-label">Bus:</span> {{numeroBus}}</div>
    <div class="info-row"><span class="info-label">Placa:</span> {{placa}}</div>
    <div class="info-row"><span class="info-label">Asientos comprados:</span> {{cantidadAsientos}}</div>
    <div class="info-row"><span class="info-label">Total:</span> {{total}}</div>
    <div class="info-row"><span class="info-label">Fecha compra:</span> {{fechacompra}}</div>
    <div class="info-row"><span class="info-label">Estado:</span> {{compraest}}</div>

    <div class="form-actions">
        <a href="index.php?page=Mantenimientos_Compras_Listado" class="btn-secondary">Volver</a>
    </div>
</section>