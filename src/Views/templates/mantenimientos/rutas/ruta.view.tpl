<style>
.form-container {
    max-width: 600px;
    margin: 40px auto;
    background: #fff;
    padding: 30px;
    border-radius: 8px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
}

.form-group {
    margin-bottom: 15px;
}

label {
    font-weight: 600;
    display: block;
    margin-bottom: 5px;
}

input, select {
    width: 100%;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 6px;
}

.actions {
    margin-top: 20px;
    display: flex;
    justify-content: space-between;
}

.btn {
    padding: 10px 18px;
    border-radius: 6px;
    text-decoration: none;
    color: #fff;
    border: none;
}

.btn-primary { background: #0074D9; }
.btn-danger { background: #dc3545; }
.btn-back {
    background: #6c757d;
    color: #fff;
    padding: 10px 18px;
    border-radius: 6px !important;
    text-decoration: none;
    display: inline-block;
    font-weight: 500;
}
</style>

<div class="form-container">
    <h2>{{title}}</h2>

    {{if error}}
    <div style="color:red; margin-bottom:10px;">{{error}}</div>
    {{endif error}}

    <form method="POST" action="index.php?page=Mantenimientos_Rutas_Ruta">

        <input type="hidden" name="mode" value="{{mode}}">
        <input type="hidden" name="rutaId" value="{{rutaId}}">

        <div class="form-group">
            <label>Origen</label>
            <input type="text" name="origen" value="{{origen}}" {{if isReadonly}}disabled{{endif isReadonly}}>
        </div>

        <div class="form-group">
            <label>Destino</label>
            <input type="text" name="destino" value="{{destino}}" {{if isReadonly}}disabled{{endif isReadonly}}>
        </div>

        <div class="form-group">
            <label>Estado</label>
            <select name="estado" {{if isReadonly}}disabled{{endif isReadonly}}>
                <option value="ACT" {{if isAct}}selected{{endif isAct}}>Activo</option>
                <option value="INA" {{if isIna}}selected{{endif isIna}}>Inactivo</option>
            </select>
        </div>

        <div class="actions">
            <a href="index.php?page=Mantenimientos_Rutas_Listado" class="btn btn-back">Volver</a>

            {{if isINS}}
            <button type="submit" class="btn btn-primary">Guardar</button>
            {{endif isINS}}

            {{if isUPD}}
            <button type="submit" class="btn btn-primary">Actualizar</button>
            {{endif isUPD}}

            {{if isDEL}}
            <button type="submit" class="btn btn-danger">Confirmar</button>
            {{endif isDEL}}
        </div>

    </form>
</div>