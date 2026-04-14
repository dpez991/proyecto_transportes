<?php include 'layout/header.php'; ?>

<div class="container my-5">
    <h2>Contáctanos</h2>
    <form action="index.php?page=send-contact" method="POST">
        <div class="mb-3">
            <label>Nombre</label>
            <input type="text" name="nombre" class="form-control" required>
        </div>
        <div class="mb-3">
            <label>Correo</label>
            <input type="email" name="correo" class="form-control" required>
        </div>
        <div class="mb-3">
            <label>Mensaje</label>
            <textarea name="mensaje" class="form-control"></textarea>
        </div>
        <button type="submit" class="btn btn-primary">Enviar</button>
    </form>
</div>

<?php include 'layout/footer.php'; ?>