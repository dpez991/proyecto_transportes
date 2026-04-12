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
    
    <form action="index.php?page=Mantenimientos_Usuarios_Usuario" method="POST"
          {{if isDEL}}onsubmit="return confirm('¿Está seguro que desea realizar esta acción?');"{{endif isDEL}}>
        <input type="hidden" name="mode" value="{{mode}}" />
        <input type="hidden" name="usercod" value="{{usercod}}" />
        
        <div class="form-group">
            <label for="username">Nombre de Usuario:</label>
            <input type="text" id="username" name="username" class="form-control" value="{{username}}" {{if isReadonly}}readonly disabled{{endif isReadonly}} maxlength="80" />
        </div>
        
        <div class="form-group">
            <label for="useremail">Email:</label>
            <input type="email" id="useremail" name="useremail" class="form-control" value="{{useremail}}" {{if isReadonly}}readonly disabled{{endif isReadonly}} maxlength="80" />
        </div>
        
        {{if isUPD}}
        <div class="form-group">
            <label for="userpswd">Nueva Contraseña (dejar en blanco para no cambiar):</label>
            <input type="password" id="userpswd" name="userpswd" class="form-control" value="" maxlength="128" />
        </div>
        {{endif isUPD}}
        
        <div class="form-group">
            <label for="userest">Estado actual:</label>
            <input type="text" class="form-control" value="{{userest}}" readonly disabled />
        </div>
        
        <div class="form-actions">
            {{if isUPD}}
            <button type="submit" class="btn btn-primary">Guardar Cambios</button>
            {{endif isUPD}}
            {{if isDEL}}
            <button type="submit" class="btn btn-danger">Confirmar Desactivación</button>
            {{endif isDEL}}
            <a class="btn btn-secondary" href="index.php?page=Mantenimientos_Usuarios_Listado">Volver al listado</a>
        </div>
    </form>
</section>
