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
    background: #0074D9;
    color: #fff;
    padding: 10px 18px;
    border-radius: 6px;
    text-decoration: none;
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
    text-align: left;
}

td {
    padding: 14px;
    border-bottom: 1px solid #eee;
}

.actions {
    display: flex;
    gap: 8px;
}

.btn {
    padding: 6px 12px;
    border-radius: 5px;
    text-decoration: none;
    font-size: 0.85rem;
}

.btn-view { background: #6c757d; color: #fff; }
.btn-edit { background: #0074D9; color: #fff; }
.btn-del { background: #dc3545; color: #fff; }
</style>

<div class="admin-container">
    <div class="admin-header">
        <h2>Gestión de Rutas</h2>
        <a href="index.php?page=Mantenimientos_Rutas_Ruta&mode=INS" class="btn-main">
            + Nueva Ruta
        </a>
    </div>

    <div class="table-wrapper">
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Origen</th>
                    <th>Destino</th>
                    <th>Estado</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                {{foreach rutas}}
                <tr>
                    <td>#{{rutaId}}</td>
                    <td>{{origen}}</td>
                    <td>{{destino}}</td>
                    <td>{{estado}}</td>
                    <td>
    <div style="display:flex; gap:6px;">
        <a href="index.php?page=Mantenimientos_Rutas_Ruta&mode=DSP&id={{rutaId}}" 
           style="background:#6c757d; color:#fff; padding:6px 10px; border-radius:5px; text-decoration:none;">
           Ver
        </a>

        <a href="index.php?page=Mantenimientos_Rutas_Ruta&mode=UPD&id={{rutaId}}" 
           style="background:#0074D9; color:#fff; padding:6px 10px; border-radius:5px; text-decoration:none;">
           Editar
        </a>

        <a href="index.php?page=Mantenimientos_Rutas_Ruta&mode=DEL&id={{rutaId}}" 
           style="background:#dc3545; color:#fff; padding:6px 10px; border-radius:5px; text-decoration:none;">
           Eliminar
        </a>
    </div>
</td>
                </tr>
                {{endfor rutas}}
            </tbody>
        </table>
    </div>
</div>