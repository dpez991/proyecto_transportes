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
}

.actions {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.btn {
    padding: 10px 16px;
    border-radius: 6px;
    color: #fff;
    text-decoration: none;
    border: none;
    font-size: 0.9rem;
    cursor: pointer;
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

    <form method="POST">

        <input type="hidden" name="mode" value="{{mode}}">
        <input type="hidden" name="viajeId" value="{{viajeId}}">

        <label>Horario</label>
        <select name="horario_id" {{if isReadonly}}disabled{{endif isReadonly}}>
            {{foreach horarios}}
            <option value="{{id}}" {{if selected}}selected{{endif selected}}>
                {{origen}} → {{destino}} | {{hora}} | {{codigo_bus}}
            </option>
            {{endfor horarios}}
        </select>

        <label>Fecha</label>
        <input type="date" name="fecha" value="{{fecha}}" {{if isReadonly}}disabled{{endif isReadonly}}>

        <label>Asientos</label>
        <input type="number" name="asientos" value="{{asientos}}" {{if isReadonly}}disabled{{endif isReadonly}}>

        <div class="actions">

            <a href="index.php?page=Mantenimientos_Viajes_Listado" class="btn btn-back">
                Volver
            </a>

            <div>
                {{if isINS}}<button class="btn btn-primary">Guardar</button>{{endif isINS}}
                {{if isUPD}}<button class="btn btn-primary">Actualizar</button>{{endif isUPD}}
                {{if isDEL}}<button class="btn btn-danger">Eliminar</button>{{endif isDEL}}
            </div>

        </div>

    </form>
</div>