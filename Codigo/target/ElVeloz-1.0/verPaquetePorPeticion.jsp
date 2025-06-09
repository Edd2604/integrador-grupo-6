

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<!DOCTYPE html>
<html>
    <head>
        <%@include file="WEB-INF/jspf/enlace.jspf" %>
        <title>Dashboard</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/sidebar.jspf" %>
        
        <div id="main-content" class="transition-all duration-300 sm:ml-64">
            <c:set var="pageTitle" value="Ver Paquete por Envio" scope="request"/>
            <%@include file="WEB-INF/jspf/navbar.jspf" %>
            
            <div class=" container mx-auto flex-col items-center justify-center">
                <div class="p-8 rounded w-full">
                    <h2 class="text-2xl pl-4 font-semibold mb-14 text-gray-800">Ver Paquetes</h2>
                    <a href="peticionEnvioControlador?accion=listarPeticiones" class="p-4 border bg-blue-700">Volver</a>
                    <div class="relative overflow-x-auto lg:px-40 md:px-24 py-12">
                        <table class="w-full shadow-xl rounded-lg overflow-hidden text-sm text-left rtl:text-right text-gray-500">
                            <thead class="text-xs text-gray-200 uppercase bg-neutral-900">
                                <tr>
                                    <th scope="col" class="px-3 py-3">Nombre</th>
                                    <th scope="col" class="px-3 py-3">Categoría</th>
                                    <th scope="col" class="px-3 py-3">Peso (kg)</th>
                                    <th scope="col" class="px-3 py-3">Cantidad</th>
                                </tr>
                            </thead>
                            <tbody class="bg-white divide-y divide-gray-200">
                                <c:choose>
                                    <c:when test="${not empty paquetes}">
                                        <c:forEach var="paquete" items="${paquetes}">
                                            <tr class="bg-white border-b border-gray-300 hover:bg-gray-100 hover:text-neutral-900 transition duration-700">
                                                <td class="px-3 py-4 justify-center">${paquete.nombre}</td>
                                                <td class="px-3 py-4 justify-center">${paquete.categoria}</td>
                                                <td class="px-3 py-4 justify-center">
                                                    <fmt:formatNumber value="${paquete.peso}" pattern="#,##0.00" />
                                                </td>
                                                <td class="px-3 py-4 justify-center">${paquete.cantidad}</td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="5" class="px-6 py-4 whitespace-nowrap text-sm text-gray-500 text-center">No hay paquetes asociados a esta petición.</td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>
                
            </div>
        </div>
    </body>
</html>


