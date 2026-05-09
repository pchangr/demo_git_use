<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>AnonTrace - Acceso Técnico</title>
    <link rel="stylesheet" href="style.css" type="text/css">
</head>
<body class="body-login">
    <div class="login-box">
        <h2>Acceso Admin</h2>
        
        <%-- Muestra error si la validación falla --%>
        <% if(request.getAttribute("error") != null) { %>
            <div class="error"><%= request.getAttribute("error") %></div>
        <% } %>

        <form action="login" method="POST">
            <input type="text" name="txtUsuario" placeholder="Usuario" required>
            <input type="password" name="txtPassword" placeholder="Contraseña" required>
            <button type="submit">Ingresar</button>
        </form>
    </div>
</body>
</html>
