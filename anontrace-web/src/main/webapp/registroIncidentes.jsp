<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AnonTrace - Reporte Policial</title>
<link rel="stylesheet" href="style.css" type="text/css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
 <!-- Leaflet CSS -->
<link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" integrity="sha256-p4NxAoJBhIIN+hmNHrzRCf9tD/miZyoHS5obTRR9BMY=" crossorigin="" />

    
</head>
<body class="body-form">

	<%@ include file="header.jsp" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <div class="container-form">
  
    <div id="alertSuccess" class="alert alert-success">✅ Reporte enviado a la central policial</div>
	

        <div id="formRegistro">
          
            <h2 style="color: #4a89dc; border-bottom: 2px solid #4a89dc; padding-bottom: 10px;">Nuevo Reporte de Delincuencia</h2>
            
            <form id="incidenciaForm" action="registrarIncidencia" method="POST" onsubmit="return validarFormulario(event)">
                
                <!-- Mapa y Coordenadas -->
                <div class="form-group">
                    <label>Ubicación del Suceso :</label>
                    <div id="map-registro" class="map-placeholder" onclick="capturarCoordenadas()">
                        <span>📍 Clic aquí para simular GPS del patrullero</span>
                        <small id="statusMapa" style="color: #4a89dc;"></small>
                    </div>
                    <div style="display: flex; gap: 10px; margin-top: 10px;">
                        <input type="text" id="latitud" name="latitud" placeholder="Latitud" readonly class="readonly">
                        <input type="text" id="longitud" name="longitud" placeholder="Longitud" readonly class="readonly">
                    </div>
                </div>

<div class="form-group">
                    <label>Categoria de Incidente:</label>
                    <select id="catIncidente" name="catIncidente" required>
                        <optgroup label="Categoria de Incidente">                       
                            <option value="Bajo">Bajo</option>
                            <option value="Medio">Medio</option>
                            <option value="Alto">Alto</option>
                        </optgroup>
                    </select>
                </div>
                
                <!--  Selección Rápida de Incidentes -->
                 <div class="form-group">
                    <label>Selección Rápida de Delito:</label>
                    <div class="icon-selector">
                        <div class="icon-btn" onclick="seleccionarRapido('1', this)">
                            <span class="icon-emoji">🏃‍♂️💨</span> Robo al paso
                        </div>
                        <div class="icon-btn" onclick="seleccionarRapido('2', this)">
                            <span class="icon-emoji">🏪🔫</span> Asalto a tienda
                        </div>
                        <div class="icon-btn" onclick="seleccionarRapido('3', this)">
                            <span class="icon-emoji">💊💊</span> Venta de droga
                        </div>
                        <div class="icon-btn" onclick="seleccionarRapido('4', this)">
                            <span class="icon-emoji">📞💰</span> Extorsión
                        </div>
                    </div>
                </div>

<!--  Selección Rápida Dinámica -->
<!--<div class="form-group">
    <label>Selección Rápida de Delito:</label>
    <div class="icon-selector">
        <c:forEach var="tipo" items="${listaTipos}">
            <div class="icon-btn" onclick="seleccionarRapido('${tipo.id_tipo}', this)">
                <span class="icon-emoji">${tipo.icono_emoji}</span> ${tipo.nombre}
            </div>
        </c:forEach>
    </div>
</div>-->

                <!--  Menú Desplegable Policial -->
                <!--<div class="form-group">
                    <label>Tipo de Incidente Detallado:</label>
                    <select id="tipoIncidente" name="tipoIncidente" required>
                        <option value="">-- Seleccione tipo de delito --</option>
                        <optgroup label="Delitos Comunes">                       
                            <option value="1">Robo al paso</option>
                            <option value="2">Asalto a tienda</option>
                            <option value="3">Venta de droga</option>
                            <option value="4">Extorsión</option>
                        </optgroup>
                        <optgroup label="Seguridad Pública">
                            <option value="Vandalismo">Vandalismo / Daño a propiedad</option>
                            <option value="Pelea callejera">Pelea callejera / Disturbios</option>
                            <option value="Consumo de alcohol en vía pública">Consumo de alcohol en calle</option>
                            <option value="Sospechoso merodeando">Persona/Vehículo sospechoso</option>
                            <option value="Otro">Otro incidente policial</option>
                        </optgroup>
                    </select>
                </div>-->
                
                <!--  Menú Desplegable Dinámico -->
<div class="form-group">
    <label>Tipo de Incidente Detallado:</label>
    <select id="tipoIncidente" name="tipoIncidente" required>
        <option value="">-- Seleccione tipo de delito --</option>
        <c:forEach var="tipo" items="${listaTipos}">
            <option value="${tipo.id_tipo}">${tipo.nombre}</option>
        </c:forEach>
    </select>
</div>
 <!--  Fechas -->
<div class="filtro-group">
    <label>Fecha del Incidente)</label>
    <input type="date" id="fechaIncidente" name="fechaIncidente" value="${idFechaIncidente}">
</div>
                <!-- Descripción -->
                <div class="form-group">
                    <label>Descripción de los hechos:</label>
                    <textarea name="descripcion" rows="3" placeholder="Ej: Dos sujetos en moto lineal, vestimenta oscura..."></textarea>
                </div>

                <!--  Evidencia -->
                <div class="form-group">
                    <label>Enlace de Imagen/Evidencia:</label>
                    <input type="text" name="urlImagen" placeholder="URL de la foto o video de seguridad">
                </div>

                <!-- Acciones -->
                <div style="display: flex; gap: 15px; margin-top: 30px;">
                    <button type="submit" class="btn-save">CONFIRMAR REPORTE</button>                    
                    <!-- <button type="button" class="btn-cancel" onclick="cancelarRegistro()">CANCELAR</button> -->
                    <button type="button" class="btn-cancel" onclick="document.getElementById('incidenciaForm').reset()">CANCELAR</button>
                    
                </div>
            </form>
        </div>
    </div>

   <!-- Leaflet JS -->
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js" integrity="sha256-20nQCchB9co0qIjJZRGuk2/Z9VM+kNiyxNV1lvTlZBo=" crossorigin=""></script>
      <script src="script.js"></script>
      <script src="form.js"></script>
     
</body>
</html>
