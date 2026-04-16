<style>
.dashboard-card { max-width: 700px; margin:2rem auto; background:#fff; border-radius:8px; box-shadow:0 4px 12px rgba(0,0,0,.1); padding:30px; }
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

    <form action="index.php?page=Mantenimientos_Viajes_Viaje" method="POST"
          {{if isDEL}}onsubmit="return confirm('¿Está seguro que desea inactivar este viaje?');"{{endif isDEL}}>
        <input type="hidden" name="mode" value="{{mode}}">
        <input type="hidden" name="viajeId" value="{{viajeId}}">

        <div class="form-group">
            <label>Ruta</label>
            <select name="rutaId" class="form-control" {{if isReadonly}}disabled{{endif isReadonly}}>
                <option value="">Seleccione una ruta</option>
                {{foreach rutas}}
                <option value="{{rutaId}}" {{if selected}}selected{{endif selected}}>{{origen}} - {{destino}}</option>
                {{endfor rutas}}
            </select>
        </div>

        <div class="form-group">
            <label>Bus</label>
            <select name="busId" class="form-control" {{if isReadonly}}disabled{{endif isReadonly}}>
                <option value="0">Sin asignar</option>
                {{foreach buses}}
                <option value="{{busId}}" {{if selected}}selected{{endif selected}}>{{numeroBus}} - {{placa}}</option>
                {{endfor buses}}
            </select>
        </div>

        <div class="form-group">
            <label>Fecha</label>
            <input type="date" name="fecha" class="form-control" value="{{fecha}}" {{if isReadonly}}readonly disabled{{endif isReadonly}}>
        </div>

        <div class="form-group">
            <label>Hora</label>
            <input type="time" name="hora" class="form-control" value="{{hora}}" {{if isReadonly}}readonly disabled{{endif isReadonly}}>
        </div>

        {{if isUPD}}
        <div class="form-group">
            <label>Asientos Disponibles</label>
            <input type="number" name="asientosDisponibles" class="form-control" value="{{asientosDisponibles}}">
        </div>
        {{endif isUPD}}

        {{if isDSP}}
        <div class="form-group">
            <label>Asientos Disponibles</label>
            <input type="number" class="form-control" value="{{asientosDisponibles}}" readonly disabled>
        </div>
        {{endif isDSP}}

        {{if isDEL}}
        <div class="form-group">
            <label>Asientos Disponibles</label>
            <input type="number" class="form-control" value="{{asientosDisponibles}}" readonly disabled>
        </div>
        {{endif isDEL}}

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
            <a href="index.php?page=Mantenimientos_Viajes_Listado" class="btn btn-secondary">Volver</a>
        </div>
    </form>
</section>