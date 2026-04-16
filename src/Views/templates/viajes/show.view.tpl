<style>
.trip-detail-container {
    max-width: 900px;
    margin: 40px auto;
    padding: 0 20px;
}
.trip-card {
    background: #fff;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 4px 20px rgba(0,0,0,0.1);
    display: flex;
    flex-direction: column;
}
@media (min-width: 768px) {
    .trip-card {
        flex-direction: row;
    }
}
.trip-image-col {
    flex: 1;
    min-height: 300px;
    position: relative;
}
.trip-info-col {
    flex: 1;
    padding: 40px;
    display: flex;
    flex-direction: column;
}
.trip-route {
    font-size: 1.8rem;
    color: #001f3f;
    font-weight: 700;
    margin-bottom: 20px;
    display: flex;
    align-items: center;
    gap: 15px;
}
.trip-meta {
    margin-bottom: 30px;
}
.trip-meta-item {
    font-size: 1.1rem;
    color: #555;
    margin-bottom: 12px;
    display: flex;
    align-items: center;
    gap: 10px;
}
.trip-meta-item i {
    color: #0074D9;
    width: 20px;
    text-align: center;
}
.badge-disponible {
    background: #e8f5e9;
    color: #43a047;
    padding: 8px 15px;
    border-radius: 25px;
    font-weight: 600;
    display: inline-block;
}
.booking-section {
    margin-top: auto;
    background: #f8f9fa;
    padding: 20px;
    border-radius: 8px;
}
.form-group {
    margin-bottom: 15px;
}
.form-control {
    width: 100%;
    padding: 10px;
    border-radius: 6px;
}
.btn-buy {
    width: 100%;
    background: linear-gradient(90deg, #001f3f, #003366);
    color: #fff;
    padding: 14px;
    border-radius: 6px;
    cursor: pointer;
}
.back-link {
    display: inline-block;
    margin-bottom: 20px;
}

/* 🔥 CAROUSEL */
.carousel {
    width: 100%;
    height: 100%;
    overflow: hidden;
}
.carousel-img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    display: none;
}
.carousel-img.active {
    display: block;
}
.carousel-btn {
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
    background: rgba(0,0,0,0.5);
    color: white;
    border: none;
    padding: 10px;
    cursor: pointer;
}
.prev { left: 10px; }
.next { right: 10px; }
/* igual que el tuyo + pequeño ajuste */
.badge-disponible {
    background: #e8f5e9;
    color: #43a047;
    padding: 8px 15px;
    border-radius: 25px;
    font-weight: 600;
    display: inline-block;
}
</style>

<div class="trip-detail-container">
    <a href="index.php?page=Viajes_Index" class="back-link">← Volver</a>
    
    <div class="trip-card">

        <div class="trip-image-col">
            <div class="carousel">
                {{foreach imagenes}}
                    <img src="{{this}}" class="carousel-img">
                {{endfor imagenes}}
            </div>

            <button class="carousel-btn prev" onclick="moveSlide(-1)">❮</button>
            <button class="carousel-btn next" onclick="moveSlide(1)">❯</button>
        </div>

        <div class="trip-info-col">

            <div class="trip-route">
                {{origen}} → {{destino}}
            </div>

            <div class="trip-meta">
                <div class="trip-meta-item">⏰ {{hora}}</div>

                <!-- 🔥 NUEVO SELECTOR DE FECHA -->
                <div class="trip-meta-item">
                    📅 <input type="date" id="fecha" class="form-control">
                </div>

                <!-- 🔥 DINÁMICO -->
                <div class="trip-meta-item">
                    <span id="asientosBox" class="badge-disponible">
                        Selecciona una fecha
                    </span>
                </div>
            </div>

            <div class="booking-section">
                <!-- 🔥 FORMULARIO AGREGAR AL CARRITO -->
                <form action="index.php?page=Checkout_Add" method="POST">
                    <input type="hidden" name="horario_id" value="{{horario_id}}">
                    <input type="hidden" id="fecha_hidden" name="fecha" value="">
                    <input type="hidden" id="precio_hidden" name="precio_unitario" value="200">

                    <div class="form-group">
                        <label>Tipo de asiento</label>
                        <select name="tipo_asiento" id="tipo_asiento" class="form-control" onchange="document.getElementById('precio_hidden').value = this.options[this.selectedIndex].getAttribute('data-price');">
                            <option value="Normal" data-price="200">Normal (L.200)</option>
                            <option value="Semi cama" data-price="250">Semi cama (L.250)</option>
                            <option value="Cama" data-price="350">Cama (L.350)</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>Cantidad</label>
                        <input id="cantidad" name="cantidad" type="number" class="form-control" min="1" value="1" required>
                    </div>

                    <button type="submit" class="btn-buy" id="btnComprar" disabled>Seleccione Fecha para Agregar</button>
                </form>
            </div>

        </div>

    </div>
</div>

<script>
let currentSlide = 0;

function showSlide(index) {
    const slides = document.querySelectorAll('.carousel-img');
    slides.forEach(s => s.classList.remove('active'));
    currentSlide = (index + slides.length) % slides.length;
    slides[currentSlide].classList.add('active');
}

function moveSlide(step) {
    showSlide(currentSlide + step);
}

document.addEventListener("DOMContentLoaded", () => {
    showSlide(0);

    const fechaInput = document.getElementById("fecha");
    const box = document.getElementById("asientosBox");
    const btnComprar = document.getElementById("btnComprar");
    const fechaHidden = document.getElementById("fecha_hidden");
    const cantidad = document.getElementById("cantidad");

    fechaInput.addEventListener("change", async () => {

        const fecha = fechaInput.value;
        fechaHidden.value = fecha;

        if (!fecha) {
            btnComprar.disabled = true;
            btnComprar.innerHTML = "Seleccione Fecha para Agregar";
            box.innerHTML = "Selecciona una fecha";
            return;
        }

        const formData = new FormData();
        formData.append("horario_id", "{{horario_id}}");
        formData.append("fecha", fecha);

        const res = await fetch("index.php?page=Viajes_Show&id=0", {
            method: "POST",
            body: formData
        });

        const data = await res.json();

        if (data.success && data.asientos > 0) {
            box.innerHTML = data.asientos + " disponibles";
            box.style.color = "#43a047";
            box.style.background = "#e8f5e9";
            cantidad.max = data.asientos;
            btnComprar.disabled = false;
            btnComprar.innerHTML = "Agregar al carrito";
        } else {
            box.innerHTML = "No disponible o agotado";
            box.style.color = "#d32f2f";
            box.style.background = "#ffebee";
            btnComprar.disabled = true;
            btnComprar.innerHTML = "Agotado";
            cantidad.max = 0;
        }
    });
});
</script>