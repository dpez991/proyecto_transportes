<style>
.admin-container {
    max-width: 1200px;
    margin: 40px auto;
    background: #fff;
    border-radius: 8px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    overflow: hidden;
}
.admin-header {
    background: #001f3f;
    color: #fff;
    padding: 20px 30px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}
.admin-header h2 {
    margin: 0;
    font-size: 1.5rem;
}
.table-wrapper {
    padding: 20px 30px;
    overflow-x: auto;
}
table.admin-table {
    width: 100%;
    border-collapse: collapse;
}
table.admin-table th {
    background: #f8f9fa;
    color: #333;
    text-transform: uppercase;
    font-size: 0.85rem;
    padding: 12px 15px;
    border-bottom: 2px solid #ddd;
    text-align: left;
}
table.admin-table td {
    padding: 15px;
    border-bottom: 1px solid #eee;
    color: #555;
    font-size: 0.95rem;
}
table.admin-table tr:hover {
    background: #fdfdfd;
}
.status-pill {
    padding: 5px 10px;
    border-radius: 12px;
    font-size: 0.8rem;
    font-weight: bold;
    display: inline-block;
}
.pill-completed { background: #d4edda; color: #155724; }
.pill-pending { background: #fff3cd; color: #856404; }

.btn-detalle {
    background: #007bff;
    color: #fff;
    padding: 6px 10px;
    border-radius: 5px;
    text-decoration: none;
    font-size: 0.85rem;
    transition: 0.2s;
}
.btn-detalle:hover {
    background: #0056b3;
}
</style>

<div class="admin-container">
    <div class="admin-header">
        <h2><i class="fas fa-clipboard-list"></i> Gestión Global de Compras</h2>
    </div>

    <div class="table-wrapper">

        <table class="admin-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Usuario</th>
                    <th>Fecha Registro</th>
                    <th>Estado Compra</th>
                    <th>Pago</th>
                    <th>Total</th>
                    <th>Transacción</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                {{foreach compras}}
                <tr>
                    <td><strong>#{{compra_id}}</strong></td>
                    <td>{{usuario}}</td>
                    <td>{{fecha_compra}}</td>
                    <td>{{estado_compra}}</td>
                    <td>
                        <span class="status-pill pill-completed">
                            {{metodo_pago}} - {{estado_pago}}
                        </span>
                    </td>
                    <td style="color:#28a745; font-weight:bold;">
                        L. {{total_compra}}
                    </td>
                    <td style="font-family:monospace; font-size:0.85rem;">
                        {{transaccion_id}}
                    </td>

                    <td>
                        <a href="index.php?page=Mantenimientos_Compras_Detalle&id={{compra_id}}" class="btn-detalle">
                            <i class="fas fa-eye"></i> Ver
                        </a>
                    </td>

                </tr>
                {{endfor compras}}
            </tbody>
        </table>

        {{ifnot compras}}
        <div style="text-align:center; padding: 40px;">
            <h3 style="color:#777;">No hay registros de compras en el sistema.</h3>
        </div>
        {{endifnot compras}}

    </div>
</div>