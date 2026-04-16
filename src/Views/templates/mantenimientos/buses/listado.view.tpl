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

.btn-main {
    background: #0074D9 !important;
    color: #fff !important;
    padding: 10px 18px !important;
    border-radius: 6px !important;
    text-decoration: none !important;
    font-weight: 600;
}

.table-wrapper {
    padding: 20px 30px;
}

table {
    width: 100%;
    border-collapse: collapse;
}

th {
    background: #f8f9fa;
    padding: 12px;
    text-align: center;
}

td {
    padding: 14px;
    border-bottom: 1px solid #eee;
    text-align: center;
}

</style>

<div class="admin-container">

    <div class="admin-header">
        <h2><i class="fas fa-bus"></i> Gestión de Buses</h2>

        <a href="index.php?page=Mantenimientos_Buses_Bus&mode=INS" class="btn-main">
            + Nuevo Bus
        </a>
    </div>

    <div class="table-wrapper">

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Código</th>
                    <th>Capacidad</th>
                    <th>Estado</th>
                    <th>Acciones</th>
                </tr>
            </thead>

            <tbody>
                {{foreach buses}}
                <tr>
                    <td>#{{busId}}</td>
                    <td>{{codigo_bus}}</td>
                    <td>{{capacidad}}</td>
                    <td>{{estado}}</td>
                    <td>
                        <div style="display:flex; justify-content:center; gap:6px;">
                            
                            <a href="index.php?page=Mantenimientos_Buses_Bus&mode=DSP&id={{busId}}" 
                               style="background:#6c757d; color:#fff; padding:6px 10px; border-radius:5px; text-decoration:none;">
                               Ver
                            </a>

                            <a href="index.php?page=Mantenimientos_Buses_Bus&mode=UPD&id={{busId}}" 
                               style="background:#0074D9; color:#fff; padding:6px 10px; border-radius:5px; text-decoration:none;">
                               Editar
                            </a>

                            <a href="index.php?page=Mantenimientos_Buses_Bus&mode=DEL&id={{busId}}" 
                               style="background:#dc3545; color:#fff; padding:6px 10px; border-radius:5px; text-decoration:none;">
                               Inactivar
                            </a>

                        </div>
                    </td>
                </tr>
                {{endfor buses}}
            </tbody>
        </table>

    </div>
</div>