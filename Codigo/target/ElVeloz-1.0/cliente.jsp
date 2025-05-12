
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <%@include file="WEB-INF/jspf/enlace.jspf" %>
        <title>Cliente</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/sidebar.jspf" %>
        
        <div id="main-content" class="transition-all duration-300 sm:ml-64">
            <c:set var="pageTitle" value="Clientes" scope="request"/>
            <%@include file="WEB-INF/jspf/navbar.jspf" %>
            
            <div class=" container mx-auto flex-col items-center justify-center">
                <h2 class="text-2xl font-semibold mb-14 text-gray-800">CONTENIDO</h2>
            </div>
        </div>
    </body>
</html>
