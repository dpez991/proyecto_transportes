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
    padding: 8px 14px !important; 
    border-radius: 6px !important;
    text-decoration: none !important;
    font-weight: 600;
    font-size: 0.9rem;
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

.action-btn {
    padding: 6px 10px;
    border-radius: 5px;
    color: #fff;
    text-decoration: none;
    font-size: 0.85rem;
}

.btn-view { background: #6c757d; }
.btn-edit { background: #0074D9; }
.btn-del { background: #dc3545; }

.actions {
    display: flex;
    justify-content: center;
    gap: 6px;
}
</style>

<div class="admin-container">

    <div class="admin-header">
        <h2>Gestión de Viajes</h2>

        <a href="index.php?page=Mantenimientos_Viajes_Viaje&mode=INS" class="btn-main">
            + Nuevo Viaje
        </a>
    </div>

    <div class="table-wrapper">

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Ruta</th>
                    <th>Bus</th>
                    <th>Fecha</th>
                    <th>Hora</th>
                    <th>Asientos</th>
                    <th>Acciones</th>
                </tr>
            </thead>

            <tbody>
                {{foreach viajes}}
                <tr>
                    <td>#{{viajeId}}</td>
                    <td>{{origen}} - {{destino}}</td>
                    <td>{{codigo_bus}}</td>
                    <td>{{fecha}}</td>
                    <td>{{hora}}</td>
                    <td>{{asientosDisponibles}}</td>
                    <td>
                        <div class="actions">
                            <a href="index.php?page=Mantenimientos_Viajes_Viaje&mode=DSP&id={{viajeId}}" class="action-btn btn-view">Ver</a>
                            <a href="index.php?page=Mantenimientos_Viajes_Viaje&mode=UPD&id={{viajeId}}" class="action-btn btn-edit">Editar</a>
                            <a href="index.php?page=Mantenimientos_Viajes_Viaje&mode=DEL&id={{viajeId}}" class="action-btn btn-del">Eliminar</a>
                        </div>
                    </td>
                </tr>
                {{endfor viajes}}
            </tbody>

        </table>

    </div>
</div>