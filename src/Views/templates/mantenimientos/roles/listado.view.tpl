<style>
.dashboard-card { max-width: 1000px; margin: 2rem auto; background: #fff; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); padding: 30px; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
.dashboard-header { display: flex; justify-content: space-between; align-items: center; border-bottom: 2px solid #eaeaea; padding-bottom: 10px; margin-bottom: 20px; }
.dashboard-header h2 { margin: 0; color: #333; }
.table-container { overflow-x: auto; }
.styled-table { width: 100%; border-collapse: collapse; margin-top: 10px; }
.styled-table th { background-color: #f8f9fa; padding: 12px 15px; text-align: left; border-bottom: 2px solid #dee2e6; color: #495057; font-weight: 600; }
.styled-table td { padding: 12px 15px; border-bottom: 1px solid #dee2e6; vertical-align: middle; color: #212529; }
.styled-table tbody tr:hover { background-color: #f1f3f5; transition: background-color 0.2s; }
.btn-primary { background-color: #0d6efd; color: #ffffff; padding: 8px 16px; border-radius: 4px; text-decoration: none; font-size: 14px; font-weight: 500; display: inline-block; border: none; cursor: pointer; transition: background-color 0.2s; }
.btn-primary:hover { background-color: #0b5ed7; }
.btn-primary {
    color: #ffffff !important;
}
.btn-secondary { background-color: #6c757d; color: #fff; padding: 8px 16px; border-radius: 4px; text-decoration: none; font-size: 14px; font-weight: 500; display: inline-block; border: none; cursor: pointer; transition: background-color 0.2s; }
.btn-secondary:hover { background-color: #5c636a; }
.btn-success { background-color: #198754; color: #fff; padding: 8px 16px; border-radius: 4px; text-decoration: none; font-size: 14px; font-weight: 500; display: inline-block; border: none; cursor: pointer; transition: background-color 0.2s; }
.btn-success:hover { background-color: #157347; }
.btn-danger { background-color: #dc3545; color: #fff; padding: 8px 16px; border-radius: 4px; text-decoration: none; font-size: 14px; font-weight: 500; display: inline-block; border: none; cursor: pointer; transition: background-color 0.2s; }
.btn-danger:hover { background-color: #bb2d3b; }
.action-links { display: flex; gap: 8px; justify-content: center; align-items: center; flex-wrap: nowrap; }
</style>
<section class="dashboard-card">
    <div class="dashboard-header">
        <h2>Listado de Roles</h2>
        {{if ~showNew}}
        <a href="index.php?page=Mantenimientos_Roles_Rol&mode=INS" class="btn-success">Crear Nuevo Rol</a>
        {{endif ~showNew}}
    </div>
    <div class="table-container">
        <table class="styled-table">
            <thead>
                <tr>
                    <th>Código de Rol</th>
                    <th>Descripción</th>
                    <th>Estado</th>
                    <th style="text-align: center;">Acción</th>
                </tr>
            </thead>
            <tbody>
                {{foreach roles}}
                <tr>
                    <td><strong>{{rolescod}}</strong></td>
                    <td>{{rolesdsc}}</td>
                    <td>{{rolesest}}</td>
                    <td>
                        <div class="action-links">
                            {{if ~showMod}}
                            <a href="index.php?page=Mantenimientos_Roles_Rol&mode=UPD&id={{rolescod}}" class="btn-secondary">Modificar</a>
                            {{endif ~showMod}}
                            {{if ~showEdit}}
                            <a href="index.php?page=Mantenimientos_Roles_Formulario&mode=UPD&id={{rolescod}}" class="btn-primary">Gestionar Funciones</a>
                            {{endif ~showEdit}}
                            {{ifnot ~showEdit}}
                            <a href="index.php?page=Mantenimientos_Roles_Formulario&mode=DSP&id={{rolescod}}" class="btn-secondary">Mostrar Funciones</a>
                            {{endifnot ~showEdit}}
                            {{if ~showDel}}
                            <form action="index.php?page=Mantenimientos_Roles_Rol" method="POST" style="margin: 0; display: inline;" onsubmit="return confirm('¿Está seguro que desea realizar esta acción?');">
                                <input type="hidden" name="mode" value="DEL" />
                                <input type="hidden" name="rolescod" value="{{rolescod}}" />
                                <button type="submit" class="btn-danger">Eliminar</button>
                            </form>
                            {{endif ~showDel}}
                        </div>
                    </td>
                </tr>
                {{endfor roles}}
            </tbody>
        </table>
    </div>
</section>
