<style>
.dashboard-grid {
    max-width: 1000px;
    margin: 2rem auto;
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 20px;
}
.dashboard-card {
    background: #fff;
    border-radius: 8px;
    padding: 25px;
    text-align: center;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
}
.dashboard-card h3 {
    margin: 0 0 10px 0;
    color: #495057;
}
.dashboard-card .number {
    font-size: 40px;
    font-weight: bold;
    color: #0d6efd;
}
</style>

<section class="dashboard-grid">
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
</section>