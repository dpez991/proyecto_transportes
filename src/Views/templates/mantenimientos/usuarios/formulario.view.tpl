<style>
.dashboard-card { max-width: 1000px; margin: 2rem auto; background: #fff; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); padding: 30px; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
.dashboard-card h2 { border-bottom: 2px solid #eaeaea; padding-bottom: 10px; margin-top: 0; color: #333; margin-bottom: 20px; }
.info-section { background-color: #f8f9fa; border: 1px solid #e9ecef; border-radius: 6px; padding: 15px 20px; margin-bottom: 25px; }
.info-row { display: flex; align-items: center; margin-bottom: 15px; }
.info-row:last-child { margin-bottom: 0; }
.info-label { width: 140px; font-weight: 600; color: #495057; }
.info-value { flex: 1; }
.info-input { width: 100%; padding: 8px 12px; border: 1px solid #ced4da; border-radius: 4px; background-color: #e9ecef; color: #495057; box-sizing: border-box; }
.split-layout { display: flex; gap: 30px; flex-wrap: wrap; }
.split-column { flex: 1; min-width: 300px; }
.section-title { font-size: 18px; margin-bottom: 15px; padding-bottom: 8px; border-bottom: 2px solid; }
.title-assigned { color: #198754; border-color: #198754; }
.title-available { color: #0d6efd; border-color: #0d6efd; }
.styled-table { width: 100%; border-collapse: collapse; margin-bottom: 10px; }
.styled-table th { background-color: #f8f9fa; padding: 10px 12px; text-align: left; border-bottom: 2px solid #dee2e6; color: #495057; font-size: 14px; }
.styled-table td { padding: 10px 12px; border-bottom: 1px solid #dee2e6; vertical-align: middle; font-size: 14px; }
.styled-table tbody tr:hover { background-color: #f1f3f5; }
.btn { padding: 6px 12px; border-radius: 4px; text-decoration: none; font-size: 13px; font-weight: 500; cursor: pointer; border: none; transition: background-color 0.2s; }
.btn-danger { background-color: #dc3545; color: white; }
.btn-danger:hover { background-color: #bb2d3b; }
.btn-success { background-color: #198754; color: white; }
.btn-success:hover { background-color: #157347; }
.btn-secondary { background-color: #6c757d; color: white; padding: 8px 16px; font-size: 14px; display: inline-block; border-radius: 4px; }
.btn-secondary:hover { background-color: #5c636a; }
.btn-secondary {
    border-radius: 4px !important;
    display: inline-block !important;
}
.form-actions { margin-top: 30px; text-align: right; padding-top: 15px; border-top: 1px solid #eaeaea; }
form { margin: 0; }
.btn,
.btn-secondary,
a.btn-secondary {
    border-radius: 4px !important;
}
</style>
<section class="dashboard-card">
    <h2>Gestión de Roles para Usuario: {{username}}</h2>
    
    <div class="info-section">
        <div class="info-row">
            <div class="info-label">Código de Usuario:</div>
            <div class="info-value">
                <input class="info-input" type="text" value="{{usercod}}" disabled readonly />
            </div>
        </div>
        <div class="info-row">
            <div class="info-label">Email:</div>
            <div class="info-value">
                <input class="info-input" type="text" value="{{useremail}}" disabled readonly />
            </div>
        </div>
    </div>

    <div class="split-layout">
        <div class="split-column">
            <h3 class="section-title title-assigned">Roles Asignados</h3>
            <table class="styled-table">
                <thead>
                    <tr>
                        <th>Rol</th>
                        <th style="width: 100px; text-align: center;">Acción</th>
                    </tr>
                </thead>
                <tbody>
                    {{foreach rolesAsignados}}
                    <tr>
                        <td>{{rolesdsc}}</td>
                        <td style="text-align: center;">
                            {{if ~showEdit}}
                            <form action="index.php?page=Mantenimientos_Usuarios_Formulario&mode={{~mode}}&id={{~usercod}}" method="POST" onsubmit="return confirm('¿Está seguro que desea realizar esta acción?');">
                                <input type="hidden" name="action" value="remove" />
                                <input type="hidden" name="rolescod" value="{{rolescod}}" />
                                <button class="btn btn-danger" type="submit">Inactivar</button>
                            </form>
                            {{endif ~showEdit}}
                        </td>
                    </tr>
                    {{endfor rolesAsignados}}
                </tbody>
            </table>
        </div>

        <div class="split-column">
            <h3 class="section-title title-available">Roles Disponibles</h3>
            <table class="styled-table">
                <thead>
                    <tr>
                        <th>Rol</th>
                        <th style="width: 100px; text-align: center;">Acción</th>
                    </tr>
                </thead>
                <tbody>
                    {{foreach rolesDisponibles}}
                    <tr>
                        <td>{{rolesdsc}}</td>
                        <td style="text-align: center;">
                            {{if ~showEdit}}
                            <form action="index.php?page=Mantenimientos_Usuarios_Formulario&mode={{~mode}}&id={{~usercod}}" method="POST" onsubmit="return confirm('¿Está seguro que desea realizar esta acción?');">
                                <input type="hidden" name="action" value="assign" />
                                <input type="hidden" name="rolescod" value="{{rolescod}}" />
                                <button class="btn btn-success" type="submit">Asignar</button>
                            </form>
                            {{endif ~showEdit}}
                        </td>
                    </tr>
                    {{endfor rolesDisponibles}}
                </tbody>
            </table>
        </div>
    </div>
    
    <div class="form-actions">
        <a class="btn btn-secondary" href="index.php?page=Mantenimientos_Usuarios_Listado">Volver al listado</a>
    </div>
</section>
