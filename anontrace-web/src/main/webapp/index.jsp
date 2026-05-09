<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>AnonTrace - Seguridad Ciudadana</title>
    <link rel="stylesheet" href="style.css" type="text/css">
     <!-- Leaflet CSS -->
<link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" integrity="sha256-p4NxAoJBhIIN+hmNHrzRCf9tD/miZyoHS5obTRR9BMY=" crossorigin="" />
    
</head>
<body class="body-index">

    <div class="hero">
        <h1>AnonTrace</h1>
        <p>Sistema Inteligente de Reporte e Incidentes Ciudadanos</p>
    </div>

    <div class="main-options">
        <!-- Acceso al Visor Libre -->
        <a href="visor" class="card">
            <div class="icon">🌍</div>
            <h3>Ver Mapa</h3>
            <p>Acceso libre al visor de incidentes en tiempo real. Filtra por distrito y tipo de delito.</p>
        </a>

        <!-- Acceso al Registro Libre -->
     
        <a href="registrarIncidencia" class="card" >
            <div class="icon">🚨</div>
            <h3>Reportar Incidente</h3>
            <p>¿Fuiste testigo de un hecho? Regístralo de forma anónima para alertar a la comunidad.</p>
        </a>
    </div>

    <!-- El Login ahora es una opción secundaria -->
    
      <%-- Lógica de sesión para Administrador/Policía --%>
     <% if(session.getAttribute("adminUser") == null || session.getAttribute("policeUser") == null) { %>
       <div class="admin-link">
        <p style="font-size: 13px; color: #555;">¿Eres personal técnico o administrativo?</p>
        <a href="login" class="btn-admin">Acceso Administrador</a>
    </div>
    <% } %>
    
    
    

    <footer class="footer-legal">
    <div class="footer-content">
     <b>Información Legal:</b> El uso de esta plataforma es para reportes ciudadanos responsables.
    </div>
    </footer>
    
    <!-- Leaflet JS -->
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js" integrity="sha256-20nQCchB9co0qIjJZRGuk2/Z9VM+kNiyxNV1lvTlZBo=" crossorigin=""></script>
      
</body>
</html>
