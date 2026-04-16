<style>
.dashboard-card { max-width: 1000px; margin: 2rem auto; background:#fff; border-radius:8px; box-shadow:0 4px 12px rgba(0,0,0,.1); padding:30px; }
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
    <h2>Listado de Buses</h2>

    <div class="top-actions">
        {{if showNew}}
        <a href="index.php?page=Mantenimientos_Buses_Bus&mode=INS" class="btn btn-primary">Nuevo Bus</a>
        {{endif showNew}}
    </div>

    <table class="styled-table">
        <thead>
            <tr>
                <th>ID</th>
                <th>Número</th>
                <th>Placa</th>
                <th>Capacidad</th>
                <th>Estado</th>
                <th>Acción</th>
            </tr>
        </thead>
        <tbody>
            {{foreach buses}}
            <tr>
                <td>{{busId}}</td>
                <td>{{numeroBus}}</td>
                <td>{{placa}}</td>
                <td>{{capacidad}}</td>
                <td>{{busest}}</td>
                <td>
                    <div class="action-links">
                        <a href="index.php?page=Mantenimientos_Buses_Bus&mode=DSP&id={{busId}}" class="btn btn-secondary">Ver</a>
                        {{if ~showEdit}}
                        <a href="index.php?page=Mantenimientos_Buses_Bus&mode=UPD&id={{busId}}" class="btn btn-primary">Editar</a>
                        {{endif ~showEdit}}
                        {{if ~showDel}}
                        <a href="index.php?page=Mantenimientos_Buses_Bus&mode=DEL&id={{busId}}" class="btn btn-danger">Eliminar</a>
                        {{endif ~showDel}}
                    </div>
                </td>
            </tr>
            {{endfor buses}}
        </tbody>
    </table>
</section>