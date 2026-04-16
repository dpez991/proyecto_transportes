<style>
.form-container {
    max-width: 600px;
    margin: 40px auto;
    background: #fff;
    padding: 30px;
    border-radius: 8px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
}

input, select {
    width: 100%;
    padding: 10px;
    margin-bottom: 15px;
    border: 1px solid #ccc;
    border-radius: 6px;
}

.actions {
    margin-top: 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.btn {
    padding: 10px 16px;
    border-radius: 6px !important;
    color:#fff;
    text-decoration:none;
    border: none;
    cursor: pointer;
}

.btn-primary { background:#0074D9; }
.btn-danger { background:#dc3545; }
.btn-back { background:#001f3f; }
</style>

<div class="form-container">

    <h2>{{title}}</h2>

    {{if error}}
    <div style="color:red; margin-bottom:10px;">{{error}}</div>
    {{endif error}}

    <form method="POST">

        <input type="hidden" name="mode" value="{{mode}}">
        <input type="hidden" name="busId" value="{{busId}}">

        <label>Código Bus</label>
        <input type="text" name="codigo_bus" value="{{codigo_bus}}" {{if isReadonly}}disabled{{endif isReadonly}}>

        <label>Capacidad</label>
        <input type="number" name="capacidad" value="{{capacidad}}" {{if isReadonly}}disabled{{endif isReadonly}}>

        <label>Estado</label>
        <select name="estado" {{if isReadonly}}disabled{{endif isReadonly}}>
            <option value="ACT" {{if isAct}}selected{{endif isAct}}>Activo</option>
            <option value="INA" {{if isIna}}selected{{endif isIna}}>Inactivo</option>
        </select>

        <div class="actions">

            <a href="index.php?page=Mantenimientos_Buses_Listado" class="btn btn-back">
                ← Volver
            </a>

            <div style="display:flex; gap:10px;">
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

        </div>

    </form>
</div>