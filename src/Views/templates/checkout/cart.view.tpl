<style>
.cart-header {
    background: linear-gradient(90deg, #001f3f, #003366);
    color: #fff;
    padding: 30px 20px;
    border-radius: 8px;
    margin-bottom: 30px;
    text-align: center;
    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
}
.cart-container {
    max-width: 1000px;
    margin: 0 auto;
}
.cart-item {
    background: #fff;
    border-radius: 8px;
    padding: 20px;
    margin-bottom: 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    box-shadow: 0 2px 10px rgba(0,0,0,0.05);
}
.cart-item-info h4 {
    margin: 0 0 10px 0;
    color: #001f3f;
    font-size: 1.2rem;
}
.cart-item-meta {
    color: #555;
    font-size: 0.95rem;
    margin: 3px 0;
}
.cart-item-price {
    font-size: 1.1rem;
    font-weight: bold;
    color: #0074D9;
}
.cart-submit-btn {
    background: linear-gradient(90deg, #28a745, #218838);
    color: #fff;
    border: none;
    padding: 12px 25px;
    font-size: 1.1rem;
    border-radius: 6px;
    cursor: pointer;
    font-weight: bold;
    box-shadow: 0 4px 10px rgba(40,167,69,0.3);
    transition: 0.3s;
    text-decoration: none;
    display: inline-block;
}
.cart-submit-btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 15px rgba(40,167,69,0.4);
}
.cart-remove-btn {
    background: none;
    border: none;
    color: #dc3545;
    cursor: pointer;
    font-size: 1.2rem;
    transition: 0.2s;
}
.cart-remove-btn:hover {
    color: #c82333;
    transform: scale(1.1);
}
.cart-summary {
    background: #f8f9fa;
    padding: 20px;
    border-radius: 8px;
    text-align: right;
    margin-top: 30px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.05);
}
.cart-total-label {
    font-size: 1.2rem;
    color: #555;
}
.cart-total-value {
    font-size: 1.8rem;
    font-weight: bold;
    color: #001f3f;
}
.empty-cart {
    text-align: center;
    padding: 50px 20px;
    background: #fff;
    border-radius: 8px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.05);
}
.empty-cart i {
    font-size: 3rem;
    color: #ccc;
    margin-bottom: 20px;
}
.empty-cart-text {
    font-size: 1.2rem;
    color: #666;
    margin-bottom: 30px;
}
.btn-primary {
    background: #0074D9;
    color: #fff;
    padding: 10px 20px;
    border-radius: 6px;
    text-decoration: none;
}
</style>

<div class="cart-container">
    <div class="cart-header">
        <h1><i class="fas fa-shopping-cart"></i> Tu Carrito de Compras</h1>
    </div>

    {{if hasItems}}
        {{foreach items}}
        <div class="cart-item" style="flex-wrap:wrap;">
            
            <form action="index.php?page=Checkout_Update" method="POST" style="flex:1; display:flex; flex-wrap:wrap; align-items:center; gap:15px;">
                <input type="hidden" name="carrito_id" value="{{carrito_id}}">
                <input type="hidden" name="horario_id" value="{{horario_id}}">
                
                <div class="cart-item-info" style="flex:1; min-width:300px;">
                    <h4><i class="fas fa-bus"></i> {{origen}} a {{destino}}</h4>
                    <p class="cart-item-meta"><i class="far fa-clock"></i> Hora de salida: {{hora}}</p>
                    
                    <div style="display:flex; gap:10px; margin-top:10px; align-items:center;">
                        <div>
                            <label style="font-size:0.85rem; color:#666;">Fecha</label><br>
                            <input type="date" name="fecha" value="{{fecha}}" style="padding:6px; border:1px solid #ccc; border-radius:4px; max-width:140px;" required>
                        </div>
                        <div>
                            <label style="font-size:0.85rem; color:#666;">Asiento</label><br>
                            <select name="tipo_asiento" style="padding:6px; border:1px solid #ccc; border-radius:4px;" required>
<option value="Normal" {{sel_normal}}>Normal</option>
<option value="Semi cama" {{sel_semi}}>Semi cama</option>
<option value="Cama" {{sel_cama}}>Cama</option>
                            </select>
                        </div>
                        <div>
                            <label style="font-size:0.85rem; color:#666;">Cantidad</label><br>
                            <input type="number" name="cantidad" value="{{cantidad}}" min="1" style="padding:6px; border:1px solid #ccc; border-radius:4px; max-width:70px;" required>
                        </div>
                        <div style="margin-top:auto;">
                            <button type="submit" style="background:#007bff; color:white; border:none; padding:8px 12px; border-radius:4px; cursor:pointer;" title="Actualizar Datos"><i class="fas fa-sync-alt"></i> Actualizar</button>
                        </div>
                    </div>
                </div>
            </form>

            <div style="text-align: right; min-width:120px; display:flex; flex-direction:column; align-items:flex-end; justify-content:center;">
                <p class="cart-item-price" style="margin-bottom:15px;">L. {{subtotal}}</p>
                <form action="index.php?page=Checkout_Remove" method="POST" style="display:inline;">
                    <input type="hidden" name="id" value="{{carrito_id}}">
                    <button type="submit" class="cart-remove-btn" title="Eliminar"><i class="fas fa-times-circle"></i> Eliminar</button>
                </form>
            </div>
        </div>
        {{endfor items}}

        <div class="cart-summary">
            <p class="cart-total-label">Total a Pagar:</p>
            <p class="cart-total-value">L. {{total}}</p>
            
            <form action="index.php?page=Checkout_Checkout" method="POST" style="margin-top: 20px;">
                <button type="submit" class="cart-submit-btn" style="background: linear-gradient(90deg, #ffc439, #f7b415); color:#001f3f;">
                    <i class="fab fa-paypal"></i> Ir a pagar con PayPal
                </button>
            </form>
        </div>

    {{endif hasItems}}

    {{ifnot hasItems}}
        <div class="empty-cart">
            <i class="fas fa-shopping-basket"></i>
            <p class="empty-cart-text">Tu carrito está vacío.</p>
            <a href="index.php?page=Viajes_Index" class="btn-primary">Explorar Viajes</a>
        </div>
    {{endifnot hasItems}}
</div>
