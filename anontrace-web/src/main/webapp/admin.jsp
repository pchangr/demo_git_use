<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // RF 42: Control de Acceso (Simulación de sesión)
    if (session.getAttribute("adminUser") == null) {
        // response.sendRedirect("LoginAdmin.jsp"); // Descomentar cuando tengas el Servlet
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Panel Administrativo - AnonTrace</title>
    <link rel="stylesheet" href="style.css" type="text/css">
</head>
<body class="body-admin">

<%@ include file="header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <div class="container-admin">
        <h2>Listado General de Incidentes</h2>
        
        <table>
            <thead>
                <tr>
                    <th>Categoría</th>
                    <th>Codigo</th>
                    <th>Tipo de Incidente</th>
                    <th>Distrito</th>
                    <th>Fecha de Incidente</th>
                    <th>Adjuntos</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            
            
            <tbody id="tablaReportes">
    			<c:forEach var="inc" items="${listarIncidentes}">
        <tr>
        	<td><span class="status-tag high">${inc.categoria}</span></td>
        	
            <td>${inc.codigo_reporte}</td>
            <td>${inc.nombre_incidente}</td>
            <td>${inc.nombre_distrito}</td>
            <td>${inc.fecha_incidente}</td>            
            <td>${inc.url_imagen}</td>
            
            <td>
                <button class="btn-edit" onclick="reclasificar('${inc.codigo_reporte}')">Reclasificar</button>
                 <span style="color: #ccc; font-size: 10px; margin-left: 10px;">Eliminar deshabilitado</span>
            </td>
        </tr>
    </c:forEach>
		</tbody>
            
        </table>
    </div>

      <script src="script.js"></script>
</body>
</html>
