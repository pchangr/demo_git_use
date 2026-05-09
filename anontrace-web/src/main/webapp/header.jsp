<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head><link rel="stylesheet" href="style.css" type="text/css"></head>
<header class="header">
    <div class="logo">
        <strong style="font-size: 18px;">AnonTrace</strong>
    </div>
    
    <% String uri = request.getRequestURI();%>
    <nav style="display: flex; align-items: center; gap: 15px;">
 
    <% if (!uri.endsWith("index") && !uri.endsWith("/")) { %>
        <a href="inicio" style="color: white; text-decoration: none; font-size: 14px;">Inicio</a>
    <% } %>
    
     <% if (!uri.endsWith("registrarIncidencia") && !uri.endsWith("admin") ) { %>
        <a href="registrarIncidencia" style="color: white; text-decoration: none; font-size: 14px;">Reportar</a>
    <% } %>
 
    <% if (!uri.endsWith("visor")) { %>
        <a href="visor" style="color: white; text-decoration: none; font-size: 14px;">Mapa</a>
    <% } else { %>
        <span style="color: #ffca28; font-weight: bold; font-size: 14px;">📍 Estás en el Mapa</span>
    <% } %>



    <%-- Lógica de sesión para Administrador/Policía --%>
     <% if(session.getAttribute("adminUser") != null || session.getAttribute("policeUser") != null) { %>
        <button class="btn-logout" onclick="confirmarSalida()">Cerrar Sesión</button>
         <%--<a href="logoutController" style="background: #ed5565; padding: 4px 12px; border-radius: 4px; color: white; text-decoration: none; font-size: 13px; white-space: nowrap;">--%>

    <% } %>
 
    </nav>
</header>
</html>