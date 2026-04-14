<h1>Viajes disponibles</h1>

<table>
    <tr>
        <th>Ruta</th>
        <th>Fecha</th>
        <th>Hora</th>
        <th>Asientos</th>
        <th></th>
    </tr>

    {{foreach viajes}}
    <tr>
        <td>{{origen}} → {{destino}}</td>
        <td>{{fecha}}</td>
        <td>{{hora}}</td>
        <td>{{asientosDisponibles}}</td>
        <td>
            <a href="index.php?page=viajes.show&id={{viajeId}}">Ver</a>
        </td>
    </tr>
    {{endfor}}
</table>