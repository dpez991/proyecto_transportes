<style>
.form-container {
    max-width: 600px;
    margin: 40px auto;
    background: #fff;
    padding: 30px;
    border-radius: 8px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
}

h2 {
    margin-bottom: 20px;
    border-bottom: 2px solid #eee;
    padding-bottom: 10px;
}

.form-group {
    margin-bottom: 15px;
}

label {
    font-weight: 600;
    display: block;
    margin-bottom: 5px;
}

input {
    width: 100%;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 6px;
}

input:disabled {
    background: #f1f1f1;
}

.actions {
    display: flex;
    justify-content: space-between;
    margin-top: 20px;
}

.btn {
    padding: 10px 16px;
    border-radius: 6px !important;
    text-decoration: none;
    color: #fff;
    border: none;
    cursor: pointer;
}

.btn-primary { background: #0074D9; }
.btn-back { background: #001f3f; }

.alert-error {
    background: #f8d7da;
    color: #842029;
    padding: 10px;
    border-radius: 6px;
    margin-bottom: 15px;
}
</style>

<div class="form-container">

    <h2>{{title}}</h2>

    {{if error}}
    <div class="alert-error">{{error}}</div>
    {{endif error}}

    <form method="POST">

        <div class="form-group">
            <label>Código</label>
            <input type="text" value="{{usercod}}" disabled>
        </div>

        <div class="form-group">
            <label>Correo</label>
            <input type="email" value="{{useremail}}" disabled>
        </div>

        <div class="form-group">
            <label>Nombre</label>
            <input type="text" name="username" value="{{username}}">
        </div>

        <div class="form-group">
            <label>Nueva Contraseña (opcional)</label>
            <input type="password" name="userpswd" placeholder="Dejar vacío para no cambiar">
        </div>

        <div class="form-group">
            <label>Estado</label>
            <input type="text" value="{{userest}}" disabled>
        </div>

        <div class="actions">

            <a href="index.php?page=Public_Home" class="btn btn-back">
                Volver
            </a>

            <button type="submit" class="btn btn-primary">
                Guardar Cambios
            </button>

        </div>

    </form>
</div>