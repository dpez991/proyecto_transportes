<style>
.catalog-container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
}
.catalog-header {
    text-align: center;
    margin-bottom: 40px;
}
.catalog-header h1 {
    color: #001f3f;
    font-size: 2.5rem;
    margin-bottom: 10px;
}
.catalog-header p {
    color: #555;
    font-size: 1.1rem;
}
.viajes-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
    gap: 30px;
}
.viaje-card {
    background: #fff;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    display: flex;
    flex-direction: column;
}
.viaje-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 8px 25px rgba(0,0,0,0.15);
}
.viaje-image {
    width: 100%;
    height: 200px;
    object-fit: cover;
}
.viaje-content {
    padding: 20px;
    flex-grow: 1;
    display: flex;
    flex-direction: column;
}
.viaje-route {
    font-size: 1.2rem;
    font-weight: 700;
    color: #001f3f;
    margin-bottom: 10px;
    display: flex;
    align-items: center;
    gap: 10px;
}
.viaje-info {
    margin-bottom: 15px;
    color: #666;
    font-size: 0.95rem;
    display: flex;
    flex-direction: column;
    gap: 8px;
}
.viaje-info-item {
    display: flex;
    align-items: center;
    gap: 8px;
}
.viaje-info-item i {
    color: #0074D9;
    width: 16px;
}
.viaje-asientos {
    margin-top: auto;
    margin-bottom: 20px;
}
.badge-asientos {
    background-color: #e0f7fa;
    color: #00838f;
    padding: 5px 12px;
    border-radius: 20px;
    font-size: 0.85rem;
    font-weight: 600;
    display: inline-block;
}
.btn-ver-detalle {
    display: block;
    width: 100%;
    text-align: center;
    background: linear-gradient(90deg, #001f3f, #003366);
    color: #fff;
    padding: 12px;
    border-radius: 6px;
    text-decoration: none;
    font-weight: 600;
    transition: background 0.3s ease;
}
.btn-ver-detalle:hover {
    background: linear-gradient(90deg, #003366, #001f3f);
    color: #fff;
}
</style>

<div class="catalog-container">
    <div class="catalog-header">
        <h1>Nuestros Viajes</h1>
        <p>Encuentra tu próximo destino con nosotros</p>
    </div>

    <div class="viajes-grid">
        {{foreach viajes}}
        <div class="viaje-card">
            <img src="{{imagenUrl}}" alt="{{destino}}" class="viaje-image">
            <div class="viaje-content">
                <div class="viaje-route">
                    {{origen}} <i class="fas fa-arrow-right"></i> {{destino}}
                </div>
                
                <div class="viaje-info">
                    <div class="viaje-info-item">
                        <i class="far fa-calendar-alt"></i> {{fecha_fmt}}
                    </div>
                    <div class="viaje-info-item">
                        <i class="far fa-clock"></i> {{hora_fmt}}
                    </div>
                </div>

                <div class="viaje-asientos">
                    <span class="badge-asientos">
                        <i class="fas fa-chair"></i> {{asientos_disponibles}} disponibles
                    </span>
                </div>

                <a href="index.php?page=Viajes_Show&id={{id}}" class="btn-ver-detalle">Ver Detalle</a>
            </div>
        </div>
        {{endfor viajes}}
    </div>
</div>
