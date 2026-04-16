<style>
.dashboard-card { max-width: 1100px; margin: 2rem auto; background:#fff; border-radius:8px; box-shadow:0 4px 12px rgba(0,0,0,.1); padding:30px; }
.styled-table { width:100%; border-collapse: collapse; }
.styled-table th, .styled-table td { padding:12px; border-bottom:1px solid #dee2e6; }
.btn { padding:8px 14px; text-decoration:none; border-radius:4px; display:inline-block; border:none; cursor:pointer; }
.btn-primary { background:#0d6efd; color:#fff; }
.btn-secondary { background:#6c757d; color:#fff; }
.btn-danger { background:#dc3545; color:#fff; }
.action-links { display:flex; gap:8px; }
.top-actions { margin-bottom:15px; }
</style>

<section class="dashboard-card">
    <h2>Listado de Viajes</h2>

    <div class="top-actions">
        {{if showNew}}
        <a href="index.php?page=Mantenimientos_Viajes_Viaje&mode=INS" class="btn btn-primary">Nuevo Viaje</a>
        {{endif showNew}}
    </div>

    <table class="styled-table">
        <thead>
            <tr>
                <th>ID</th>
                <th>Ruta</th>
                <th>Bus ID</th>
                <th>Fecha</th>
                <th>Hora</th>
                <th>Asientos</th>
                <th>Estado</th>
                <th>Acción</th>
            </tr>
        </thead>
        <tbody>
            {{foreach viajes}}
            <tr>
                <td>{{viajeId}}</td>
                <td>{{origen}} - {{destino}}</td>
                <td>{{busId}}</td>
                <td>{{fecha}}</td>
                <td>{{hora}}</td>
                <td>{{asientosDisponibles}}</td>
                <td>{{estado}}</td>
                <td>
                    <div class="action-links">
                        <a href="index.php?page=Mantenimientos_Viajes_Viaje&mode=DSP&id={{viajeId}}" class="btn btn-secondary">Ver</a>
                        {{if ~showEdit}}
                        <a href="index.php?page=Mantenimientos_Viajes_Viaje&mode=UPD&id={{viajeId}}" class="btn btn-primary">Editar</a>
                        {{endif ~showEdit}}
                        {{if ~showDel}}
                        <a href="index.php?page=Mantenimientos_Viajes_Viaje&mode=DEL&id={{viajeId}}" class="btn btn-danger">Inactivar</a>
                        {{endif ~showDel}}
                    </div>
                </td>
            </tr>
            {{endfor viajes}}
        </tbody>
    </table>
</section>