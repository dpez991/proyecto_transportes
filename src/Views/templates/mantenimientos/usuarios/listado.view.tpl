<style>
.dashboard-card { max-width: 1000px; margin: 2rem auto; background: #fff; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); padding: 30px; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
.dashboard-card h2 { border-bottom: 2px solid #eaeaea; padding-bottom: 10px; margin-top: 0; color: #333; margin-bottom: 20px; }
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
.btn-success { background-color: #198754; color: #fff; padding: 8px 16px; border-radius: 4px; text-decoration: none; font-size: 14px; font-weight: 500; display: inline-block; border: none; cursor: pointer; transition: background-color 0.2s; }
.btn-success:hover { background-color: #157347; }
.btn-secondary { background-color: #6c757d; color: #fff; padding: 8px 16px; border-radius: 4px; text-decoration: none; font-size: 14px; font-weight: 500; display: inline-block; border: none; cursor: pointer; transition: background-color 0.2s; }
.btn-secondary:hover { background-color: #5c636a; }
.btn-danger { background-color: #dc3545; color: #fff; padding: 8px 16px; border-radius: 4px; text-decoration: none; font-size: 14px; font-weight: 500; display: inline-block; border: none; cursor: pointer; transition: background-color 0.2s; }
.btn-danger:hover { background-color: #bb2d3b; }
.action-links { display: flex; gap: 8px; justify-content: center; align-items: center; flex-wrap: nowrap; }
</style>
<section class="dashboard-card">
    <h2>Listado de Usuarios</h2>
    <div class="table-container">
        <table class="styled-table">
            <thead>
                <tr>
                    <th>Código</th>
                    <th>Email</th>
                    <th>Nombre</th>
                    <th>Roles Asignados</th>
                    <th>Estado</th>
                    <th style="text-align: center;">Acción</th>
                </tr>
            </thead>
            <tbody>
                {{foreach usuarios}}
                <tr>
                    <td>{{usercod}}</td>
                    <td>{{useremail}}</td>
                    <td>{{username}}</td>
                    <td><strong style="color: #495057;">{{userroles}}</strong></td>
                    <td>{{userest}}</td>
                    <td>
                        <div class="action-links">
                            {{if ~showMod}}
                            <a href="index.php?page=Mantenimientos_Usuarios_Usuario&mode=UPD&id={{usercod}}" class="btn-secondary">Modificar</a>
                            {{endif ~showMod}}
                            {{if ~showEdit}}
                            <a href="index.php?page=Mantenimientos_Usuarios_Formulario&mode=UPD&id={{usercod}}" class="btn-primary">Gestionar Roles</a>
                            {{endif ~showEdit}}
                            {{ifnot ~showEdit}}
                            <a href="index.php?page=Mantenimientos_Usuarios_Formulario&mode=DSP&id={{usercod}}" class="btn-secondary">Mostrar Roles</a>
                            {{endifnot ~showEdit}}
                            {{if ~showDel}}
                            {{if isActivo}}
                            <form action="index.php?page=Mantenimientos_Usuarios_Usuario" method="POST" style="margin: 0; display: inline;" onsubmit="return confirm('¿Está seguro que desea desactivar este usuario?');">
                                <input type="hidden" name="mode" value="DEL" />
                                <input type="hidden" name="usercod" value="{{usercod}}" />
                                <button type="submit" class="btn-danger">Desactivar</button>
                            </form>
                            {{endif isActivo}}
                            {{if isInactive}}
                            <form action="index.php?page=Mantenimientos_Usuarios_Usuario" method="POST" style="margin: 0; display: inline;" onsubmit="return confirm('¿Está seguro que desea activar este usuario?');">
                                <input type="hidden" name="mode" value="ACT" />
                                <input type="hidden" name="usercod" value="{{usercod}}" />
                                <button type="submit" class="btn-success">Activar</button>
                            </form>
                            {{endif isInactive}}
                            {{endif ~showDel}}
                        </div>
                    </td>
                </tr>
                {{endfor usuarios}}
            </tbody>
        </table>
    </div>
</section>
