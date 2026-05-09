<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Acceso Policial - AnonTrace</title>
    <link rel="stylesheet" href="style.css" type="text/css">
    <style>
    .header{
	background: #1a237e; 
    color: white; 
    padding: 8px 20px; 
    display: flex; 
    justify-content: space-between; 
    align-items: center;
    position: fixed  !important;
    top:0  !important; 
    width: 100%;
    box-sizing: border-box;
    z-index: 2000;
    margin: 0;
    }
    </style>
</head>
<body class="body-police">
<%@ include file="header.jsp" %>
<div class = "panel">
<div class="aviso-box">
        <div class="icon-policia">🚧</div>
        <h1>Módulo en Construcción</h1>
        <p>Estamos trabajando para integrar este sistema directamente con la Central de Emergencias de la Policía Nacional.</p>
        <p>Próximamente los agentes podrán gestionar patrullajes basados en los incidentes reportados aquí.</p>
        
        <a href="visor.jsp" class="btn-regresar">Volver al Visor</a>
    </div>

    <!-- Pie de página legal también aquí -->
    <div class="footer-v2">
        AnonTrace Legal &copy; 2026 - Uso Responsable de la Plataforma
    </div>
</div>
     <script src="script.js"></script>

</body>
</html>