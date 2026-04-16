<style>
.dashboard-container {
    max-width: 1400px;
    margin: 2rem auto;
    padding: 0 20px;
}

.dashboard-grid {
    display: flex;
    flex-direction: column;
    gap: 25px;
}

.dashboard-row {
    display: flex;
    justify-content: center;
    gap: 20px;
    flex-wrap: wrap;
}

.dashboard-card {
    flex: 1;
    min-width: 220px;
    max-width: 250px;

    background: #fff;
    border-radius: 10px;
    padding: 30px;
    text-align: center;
    box-shadow: 0 4px 15px rgba(0,0,0,0.1);

    transition: transform 0.2s;
}

.dashboard-card:hover {
    transform: translateY(-5px);
}

.dashboard-card h3 {
    margin-bottom: 10px;
    color: #555;
    font-size: 1rem;
}

.dashboard-card .number {
    font-size: 36px;
    font-weight: bold;
    color: #0074D9;
}

.dashboard-card.income .number {
    color: #28a745;
}

.dashboard-card.warning .number {
    color: #ffc107;
}
</style>
<div class="dashboard-container">

    <div class="dashboard-grid">

        <div class="dashboard-row">
            <div class="dashboard-card">
                <h3>Total Usuarios</h3>
                <div class="number">{{totalUsuarios}}</div>
            </div>

            <div class="dashboard-card">
                <h3>Total Viajes</h3>
                <div class="number">{{totalViajes}}</div>
            </div>

            <div class="dashboard-card">
                <h3>Total Compras</h3>
                <div class="number">{{totalCompras}}</div>
            </div>

            <div class="dashboard-card">
                <h3>Total Rutas</h3>
                <div class="number">{{totalRutas}}</div>
            </div>

            <div class="dashboard-card">
                <h3>Total Buses</h3>
                <div class="number">{{totalBuses}}</div>
            </div>
        </div>

        <div class="dashboard-row">
            <div class="dashboard-card income">
                <h3>Ingresos Totales</h3>
                <div class="number">L. {{ingresosTotales}}</div>
            </div>

            <div class="dashboard-card warning">
                <h3>Compras Hoy</h3>
                <div class="number">{{comprasHoy}}</div>
            </div>

            <div class="dashboard-card warning">
                <h3>Viajes Hoy</h3>
                <div class="number">{{viajesHoy}}</div>
            </div>
        </div>

    </div>

</div>