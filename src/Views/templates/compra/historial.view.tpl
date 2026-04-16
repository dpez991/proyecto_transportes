<style>
    .history-container {
        max-width: 1100px;
        margin: 40px auto;
        padding: 0 20px;
    }
    .history-header {
        background: linear-gradient(90deg, #001f3f, #003366);
        color: #fff;
        padding: 30px;
        border-radius: 8px;
        margin-bottom: 30px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    }
    .purchase-card {
        background: #fff;
        border-radius: 8px;
        padding: 0;
        margin-bottom: 30px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        overflow: hidden;
        border: 1px solid #eee;
    }
    .purchase-header {
        background: #f8f9fa;
        padding: 20px;
        display: flex;
        justify-content: space-between;
        border-bottom: 1px solid #eee;
        align-items: center;
    }
    .purchase-meta h5 {
        margin: 0;
        font-size: 1.1rem;
        color: #001f3f;
    }
    .purchase-meta p {
        margin: 5px 0 0;
        font-size: 0.9rem;
        color: #666;
    }
    .badge {
        padding: 6px 12px;
        border-radius: 20px;
        font-size: 0.85rem;
        font-weight: bold;
        color: #fff;
    }
    .badge-success { background: #28a745; }
    .badge-warning { background: #ffc107; color:#333; }
    .badge-info { background: #17a2b8; }
    
    .purchase-body {
        padding: 20px;
    }
    .ticket-row {
        display: flex;
        justify-content: space-between;
        padding: 15px 0;
        border-bottom: 1px dashed #eee;
        align-items: center;
    }
    .ticket-row:last-child {
        border-bottom: none;
    }
    .ticket-info {
        display: flex;
        gap: 20px;
    }
    .ticket-col {
        display: flex;
        flex-direction: column;
    }
    .total-section {
        background: #fdfdfd;
        padding: 15px 20px;
        text-align: right;
        border-top: 1px solid #eee;
    }

    /* ===== ESTADO VACÍO (NUEVO) ===== */
    .empty-state {
        text-align: center;
        padding: 80px 20px;
        background: #fff;
        border-radius: 8px;
        border: 1px solid #eee;
        box-shadow: 0 2px 10px rgba(0,0,0,0.05);
    }
    .empty-state i {
        font-size: 5rem;
        color: #ddd;
        margin-bottom: 25px;
        display: block;
    }
    .empty-state h2 {
        color: #001f3f;
        margin-bottom: 10px;
        font-weight: 700;
    }
    .empty-state p {
        color: #777;
        max-width: 450px;
        margin: 0 auto 30px;
        line-height: 1.6;
    }
    .btn-buy-empty {
        display: inline-block;
        background: linear-gradient(90deg, #001f3f, #003366);
        color: #fff !important;
        padding: 14px 30px;
        border-radius: 30px;
        text-decoration: none;
        font-weight: bold;
        transition: all 0.3s ease;
        box-shadow: 0 4px 15px rgba(0,31,63,0.2);
    }
    .btn-buy-empty:hover {
        transform: translateY(-3px);
        box-shadow: 0 6px 20px rgba(0,31,63,0.3);
        text-decoration: none;
        filter: brightness(1.2);
    }
</style>

<div class="history-container">
    <div class="history-header">
        <h1 style="margin:0;"><i class="fas fa-history"></i> Mi Historial de Compras</h1>
        <p style="margin: 10px 0 0 0; opacity:0.8;">
            Consulta todas tus transacciones de viaje realizadas en la plataforma.
        </p>
    </div>

    {{foreach compras}}
    <div class="purchase-card">
        <div class="purchase-header">
            <div class="purchase-meta">
                <h5>Compra #{{compra_id}}</h5>
                <p><i class="far fa-calendar-alt"></i> {{fecha_compra}}</p>
                <p><i class="fas fa-receipt"></i> {{transaccion_id}} | {{metodo_pago}}</p>
            </div>
            <div>
                <span class="badge badge-success">{{estado_pago}}</span>
            </div>
        </div>
        
        <div class="purchase-body">
            {{foreach detalles}}
            <div class="ticket-row">
                <div class="ticket-info">
                    <div class="ticket-col">
                        <strong style="color: #001f3f; font-size: 1.1rem;">{{origen}} → {{destino}}</strong>
                        <span style="color: #666;"><i class="far fa-clock"></i> {{fecha_viaje}} a las {{hora_salida}}</span>
                        <span style="color: #888; font-size: 0.9rem;">{{cantidad}}x {{tipo_asiento}}</span>
                    </div>
                </div>
                <div style="text-align: right;">
                    <span style="display:block; font-size: 0.8rem; color: #888;">SUBTOTAL</span>
                    <strong style="font-size: 1.2rem; color: #333;">L. {{subtotal}}</strong>
                </div>
            </div>
            {{endfor detalles}}
        </div>

        <div class="total-section">
            <span style="margin-right: 10px; color: #666; font-weight: 500;">TOTAL PAGADO:</span>
            <strong style="font-size: 1.5rem; color: #001f3f;">L. {{total_compra}}</strong>
        </div>
    </div>
    {{endfor compras}}

    {{ifnot compras}}
    <div class="empty-state">
        <i class="fas fa-ticket-alt"></i>
        <h2>¡Aún no tienes aventuras registradas!</h2>
        <p>Parece que tu historial está vacío. Comienza a explorar nuestros destinos y reserva tu próximo viaje con nosotros.</p>
        <a href="index.php?page=Viajes_Index" class="btn-buy-empty">
            <i class="fas fa-search"></i> Buscar mi próximo viaje
        </a>
    </div>
    {{endifnot compras}}

</div>