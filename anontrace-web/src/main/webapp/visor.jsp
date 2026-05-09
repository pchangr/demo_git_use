<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Visor de Incidentes - AnonTrace</title>
    
    <link rel="stylesheet" href="style.css" type="text/css">
    
    
    <!-- Leaflet CSS -->
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" integrity="sha256-p4NxAoJBhIIN+hmNHrzRCf9tD/miZyoHS5obTRR9BMY=" crossorigin="" />

    
    
</head>
<body class="body-visor">

	<%@ include file="header.jsp" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	
    <!--Título -->
    <div class="titulo-visor">Visor de Incidentes Ciudadanos</div>

    <!--Controles y Carga -->
    <div class="controles-flotantes">
        <button class="btn-refresh" onclick="actualizarDatos()">🔄 Actualizar Mapa </button>
        <div id="loading">⌛ Cargando...</div>
        <button class="btn-refresh" style="background:#4caf50;" onclick="centrarCiudad()">📍 Centrar Ciudad </button>
    </div>

<script>
    // Convertimos la lista de Java a un array de objetos JS
    const incidenciasFiltradas = [
        <c:forEach var="inc" items="${listaIncidencias}" varStatus="status">
        {
            lat: ${inc.latitud},
            lng: ${inc.longitud},
            tipo: "${inc.nombre_incidente}",
            desc: "${inc.descripcion}"
        }${!status.last ? ',' : ''}
        </c:forEach>
    ];

    console.log("Datos recibidos en el mapa:", incidenciasFiltradas);
</script>

    <!--  Leyenda de Iconografía -->
    <div class="leyenda">
        <h4 style="margin: 0 0 10px 0;">Leyenda</h4>
        <div class="leyenda-item"><span>🏃‍♂️</span> Robo al paso</div>
        <div class="leyenda-item"><span>🏪</span> Asalto a tienda</div>
        <div class="leyenda-item"><span>💊</span> Venta de droga</div>
        <div class="leyenda-item"><span>📞</span> Extorsión</div>
        <div class="leyenda-item"><span>⚠️</span> Otros</div>
    </div>

    <!-- Panel de Filtros -->
<style>
    .panel-filtros {
        position: absolute; top: 250px; right: 20px; z-index: 1000;
        background: white; padding: 20px; border-radius: 10px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.2); width: 280px;
        max-height: 80vh; overflow-y: auto;
    }
    .filtro-group { margin-bottom: 12px; }
    .filtro-group label { display: block; font-size: 12px; font-weight: bold; margin-bottom: 5px; color: #555; }
    .filtro-group select, .filtro-group input { width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 5px; }
    .btn-filtrar { 
        width: 100%; background: #1a237e; color: white; border: none; 
        padding: 10px; border-radius: 5px; cursor: pointer; font-weight: bold; margin-top: 10px;
    }
</style>

<div class="panel-filtros">
    <h3 style="margin-top:0; color:#1a237e; font-size:16px;">🔍 Filtros de Búsqueda</h3>
    
    <!-- Filtros en Cascada -->
    <div class="filtro-group">
        <label>Provincia</label>
        <select id="filtroProvincia" onchange="cargarDistritos()">
            <option value="">-- Todas --</option>
            <c:forEach var="provincia" items="${listarProvincias}">
            <option value="${provincia.id_provincia}" ${provincia.id_provincia == idProvSelected ? 'selected' : ''} >${provincia.nombre}</option>
        </c:forEach>
        </select>
    </div>
    
     <!--<div class="filtro-group">
        <label>Distrito</label>
        <select id="filtroDistrito">
            <option value="">-- Seleccione Provincia --</option>
            <c:forEach var="distrito" items="${listarDistritos}">
            <option value="${distrito.id_distrito}">${distrito.nombre}</option>
        </c:forEach>
        </select>
    </div>-->
    
    <script>
    // Estas variables sí funcionarán aquí porque es un archivo JSP
    const provParaRestaurar = "${idProvSelected}";
    const distParaRestaurar = "${idDistSelected}";
</script>

<div class="filtro-group">
    <label>Distrito</label>
    <select id="filtroDistrito">
        <option value="" >-- Seleccione una provincia --</option>
    </select>
</div>
    <hr>

    <!-- Filtro por Tipo -->
    <div class="filtro-group">
        <label>Tipo de Incidente</label>
        <select id="filtroTipo">
            <option value="">-- Todos --</option>
            <c:forEach var="tipo" items="${listaTiposIncidentes}">
            <option value="${tipo.id_tipo}" ${tipo.id_tipo == idTipoSelected ? 'selected' : ''} >${tipo.nombre}</option>
        </c:forEach>
        </select>
    </div>

    <!-- Rango de Fechas -->

<div class="filtro-group">
    <label>Desde (Fecha)</label>
    <input type="date" id="fechaInicio" name="fechaInicio" value="${idFechaInicioSelected}">
</div>
<div class="filtro-group">
    <label>Hasta (Fecha)</label>
    <input type="date" id="fechaFin" name="fechaFin" value="${idFechaFinSelected}">
</div>

    <!-- Rango de Horarios -->
    <div class="filtro-group">
        <label>Rango Horario</label>
        <div style="display: flex; gap: 5px; align-items: center;">
            <input type="time" id="horaInicio" value="00:00"> 
            <span>a</span>
            <input type="time" id="horaFin" value="23:59">
        </div>
    </div>

    <button class="btn-filtrar" onclick="aplicarFiltros()">Aplicar Filtros</button>
    
    <button type="button" class="btn-refresh" 
        style="background: #6c757d; width: 100%; margin-top: 10px; color: white; border: none; padding: 10px; border-radius: 5px; cursor: pointer;" 
        onclick="limpiarFiltros()">
    🧹 Limpiar Filtros / Ver Todo
</button>

</div>


    <!-- Div mapa -->
    <div id="map"></div>

    <!-- Leaflet JS -->
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js" integrity="sha256-20nQCchB9co0qIjJZRGuk2/Z9VM+kNiyxNV1lvTlZBo=" crossorigin=""></script>
    <script src="visor.js"></script>
    
</body>
<!-- Pie de Página Legal -->
<footer class="footer-legal">
    <div class="footer-content">
    &copy; 2026 AnonTrace. <b>Información Legal:</b> El uso de esta plataforma es para reportes ciudadanos responsables. 
    Cualquier uso malintencionado o falsificación de reportes será sancionado bajo las leyes de seguridad vigentes.
    </div>
</footer>
</html>
