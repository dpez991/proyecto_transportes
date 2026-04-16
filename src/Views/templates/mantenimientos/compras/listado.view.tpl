<style>
.dashboard-card { max-width: 1100px; margin: 2rem auto; background:#fff; border-radius:8px; box-shadow:0 4px 12px rgba(0,0,0,.1); padding:30px; }
.styled-table { width:100%; border-collapse: collapse; }
.styled-table th, .styled-table td { padding:12px; border-bottom:1px solid #dee2e6; }
.btn { padding:8px 14px; text-decoration:none; border-radius:4px; display:inline-block; border:none; cursor:pointer; }
.btn-primary { background:#0d6efd; color:#fff; }
</style>

<section class="dashboard-card">
    <h2>Listado de Compras</h2>

    <table class="styled-table">
        <thead>
            <tr>
                <th>ID</th>
                <th>Usuario</th>
                <th>Correo</th>
                <th>Ruta</th>
                <th>Fecha Viaje</th>
                <th>Hora</th>
                <th>Asientos</th>
                <th>Total</th>
                <th>Fecha Compra</th>
                <th>Estado</th>
                <th>Acción</th>
            </tr>
        </thead>
        <tbody>
            {{foreach compras}}
            <tr>
                <td>{{compraId}}</td>
                <td>{{username}}</td>
                <td>{{useremail}}</td>
                <td>{{origen}} - {{destino}}</td>
                <td>{{fecha}}</td>
                <td>{{hora}}</td>
                <td>{{cantidadAsientos}}</td>
                <td>{{total}}</td>
                <td>{{fechacompra}}</td>
                <td>{{compraest}}</td>
                <td>
                    {{if ~showDetail}}
                    <a href="index.php?page=Mantenimientos_Compras_Detalle&id={{compraId}}" class="btn btn-primary">Ver Detalle</a>
                    {{endif ~showDetail}}
                </td>
            </tr>
            {{endfor compras}}
        </tbody>
    </table>
</section>