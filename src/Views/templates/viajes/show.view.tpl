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
</style>

<div class="trip-detail-container">
    <a href="index.php?page=Viajes_Index" class="back-link">← Volver</a>
    
    <div class="trip-card">

        <!-- 🔥 CAROUSEL -->
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
                <div class="trip-meta-item">📅 {{fecha}}</div>
                <div class="trip-meta-item">⏰ {{hora}}</div>
                <div class="trip-meta-item">
                    <span class="badge-disponible">
                        {{asientos_disponibles}} disponibles
                    </span>
                </div>
            </div>

            <div class="booking-section">
                <div class="form-group">
                    <label>Tipo de asiento</label>
                    <select class="form-control">
                        <option>Normal (L.200)</option>
                        <option>Semi cama (L.250)</option>
                        <option>Cama (L.350)</option>
                    </select>
                </div>

                <div class="form-group">
                    <label>Cantidad</label>
                    <input type="number" class="form-control" min="1" max="{{asientos_disponibles}}" value="1">
                </div>

                <button class="btn-buy">Agregar al carrito</button>
            </div>

        </div>

    </div>
</div>

<script>
let currentSlide = 0;

function showSlide(index) {
    const slides = document.querySelectorAll('.carousel-img');
    if (slides.length === 0) return;

    slides.forEach(s => s.classList.remove('active'));

    currentSlide = (index + slides.length) % slides.length;

    slides[currentSlide].classList.add('active');
}

function moveSlide(step) {
    showSlide(currentSlide + step);
}

document.addEventListener("DOMContentLoaded", () => {
    showSlide(0);
});
</script>