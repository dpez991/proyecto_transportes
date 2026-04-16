<style>
.dashboard-card { max-width: 650px; margin:2rem auto; background:#fff; border-radius:8px; box-shadow:0 4px 12px rgba(0,0,0,.1); padding:30px; }
.form-group { margin-bottom:15px; }
.form-control { width:100%; padding:10px; border:1px solid #ced4da; border-radius:4px; }
.btn { padding:8px 16px; border:none; border-radius:4px; text-decoration:none; display:inline-block; cursor:pointer; }
.btn-primary { background:#0d6efd; color:#fff; }
.btn-secondary { background:#6c757d; color:#fff; }
.btn-danger { background:#dc3545; color:#fff; }
.alert-error { background:#f8d7da; color:#842029; padding:10px; border-radius:4px; margin-bottom:15px; }
.form-actions { margin-top:20px; text-align:right; }
</style>

<section class="dashboard-card">
    <h2>{{title}}</h2>

    {{if error}}
    <div class="alert-error">{{error}}</div>
    {{endif error}}

    <form action="index.php?page=Mantenimientos_Rutas_Ruta" method="POST"
          {{if isDEL}}onsubmit="return confirm('¿Está seguro que desea inactivar esta ruta?');"{{endif isDEL}}>
        <input type="hidden" name="mode" value="{{mode}}">
        <input type="hidden" name="rutaId" value="{{rutaId}}">

        <div class="form-group">
            <label>Origen</label>
            <input type="text" name="origen" class="form-control" value="{{origen}}" {{if isReadonly}}readonly disabled{{endif isReadonly}}>
        </div>

        <div class="form-group">
            <label>Destino</label>
            <input type="text" name="destino" class="form-control" value="{{destino}}" {{if isReadonly}}readonly disabled{{endif isReadonly}}>
        </div>

        <div class="form-group">
            <label>Estado</label>
            <select name="estado" class="form-control" {{if isReadonly}}disabled{{endif isReadonly}}>
                <option value="ACT" {{if isAct}}selected{{endif isAct}}>Activo</option>
                <option value="INA" {{if isIna}}selected{{endif isIna}}>Inactivo</option>
            </select>
        </div>

        <div class="form-actions">
            {{if isINS}}<button type="submit" class="btn btn-primary">Guardar</button>{{endif isINS}}
            {{if isUPD}}<button type="submit" class="btn btn-primary">Actualizar</button>{{endif isUPD}}
            {{if isDEL}}<button type="submit" class="btn btn-danger">Confirmar Inactivación</button>{{endif isDEL}}
            <a href="index.php?page=Mantenimientos_Rutas_Listado" class="btn btn-secondary">Volver</a>
        </div>
    </form>
</section>