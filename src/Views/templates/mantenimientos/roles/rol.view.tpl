<style>
.dashboard-card { max-width: 600px; margin: 2rem auto; background: #fff; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); padding: 30px; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
.dashboard-card h2 { border-bottom: 2px solid #eaeaea; padding-bottom: 10px; margin-top: 0; color: #333; margin-bottom: 20px; }
.form-group { margin-bottom: 15px; }
.form-group label { display: block; margin-bottom: 5px; font-weight: 600; color: #495057; }
.form-control { width: 100%; padding: 10px 12px; border: 1px solid #ced4da; border-radius: 4px; box-sizing: border-box; }
.form-control:disabled { background-color: #e9ecef; }
.alert-error { background-color: #f8d7da; color: #842029; padding: 10px; border-radius: 4px; margin-bottom: 15px; }
.form-actions { margin-top: 30px; text-align: right; padding-top: 15px; border-top: 1px solid #eaeaea; }
.btn { padding: 8px 16px; border-radius: 4px; text-decoration: none; font-size: 14px; font-weight: 500; cursor: pointer; border: none; transition: background-color 0.2s; display: inline-block; }
.btn-primary { background-color: #0d6efd; color: #ffffff; }
.btn-primary:hover { background-color: #0b5ed7; }
.btn-danger { background-color: #dc3545; color: white; }
.btn-danger:hover { background-color: #bb2d3b; }
.btn-secondary { background-color: #6c757d; color: white; }
.btn-secondary:hover { background-color: #5c636a; }
.btn,
.btn-secondary,
a.btn-secondary {
    border-radius: 4px !important;
    margin-left: 8px;
}
</style>

<section class="dashboard-card">
    <h2>{{title}}</h2>
    
    {{if error}}
    <div class="alert-error">{{error}}</div>
    {{endif error}}
    
    <form action="index.php?page=Mantenimientos_Roles_Rol" method="POST"
          {{if isDEL}}onsubmit="return confirm('¿Está seguro que desea realizar esta acción?');"{{endif isDEL}}>
        <input type="hidden" name="mode" value="{{mode}}" />
        
        <div class="form-group">
            <label for="rolescod">Código del Rol:</label>
            <input type="text" id="rolescod" name="rolescod" class="form-control" value="{{rolescod}}" {{ifnot isInsert}}readonly disabled{{endifnot isInsert}} maxlength="15" />
            {{ifnot isInsert}}
            <input type="hidden" name="rolescod" value="{{rolescod}}" />
            {{endifnot isInsert}}
        </div>
        
        <div class="form-group">
            <label for="rolesdsc">Descripción:</label>
            <input type="text" id="rolesdsc" name="rolesdsc" class="form-control" value="{{rolesdsc}}" {{if isReadonly}}readonly disabled{{endif isReadonly}} maxlength="45" />
        </div>
        
        <div class="form-group">
            <label for="rolesest">Estado:</label>
            <select id="rolesest" name="rolesest" class="form-control" {{if isReadonly}}disabled{{endif isReadonly}}>
                <option value="ACT" {{if isRoleAct}}selected{{endif isRoleAct}}>Activo</option>
                <option value="INA" {{if isRoleIna}}selected{{endif isRoleIna}}>Inactivo</option>
            </select>
            {{if isReadonly}}
            <input type="hidden" name="rolesest" value="{{rolesest}}" />
            {{endif isReadonly}}
        </div>
        
        <div class="form-actions">
            {{if isInsert}}
            <button type="submit" class="btn btn-primary">Crear</button>
            {{endif isInsert}}
            {{if isUPD}}
            <button type="submit" class="btn btn-primary">Guardar Cambios</button>
            {{endif isUPD}}
            {{if isDEL}}
            <button type="submit" class="btn btn-danger">Confirmar Eliminación</button>
            {{endif isDEL}}
            <a class="btn btn-secondary" href="index.php?page=Mantenimientos_Roles_Listado">Volver al listado</a>
        </div>
    </form>
</section>
