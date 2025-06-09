
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <%@include file="WEB-INF/jspf/enlace.jspf" %>
        <title>Ver Peticiones de Envío</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/sidebar.jspf" %>
        
        <div id="main-content" class="transition-all duration-300 sm:ml-64">
            <c:set var="pageTitle" value="Ver Peticiones de Envío" scope="request"/>
            <%@include file="WEB-INF/jspf/navbar.jspf" %>
            
            <div class=" container mx-auto flex-col items-center justify-center">
                <div class="p-8 rounded w-full">
                    <h2 class="text-2xl pl-4 font-semibold mb-14 text-gray-800">Ver Peticiones</h2>
                    
                    <div class="relative overflow-x-auto lg:px-20 md:px-12 py-12">
            <table class="w-full shadow-xl rounded-lg overflow-hidden text-sm text-left rtl:text-right text-gray-500">
                <thead class="text-xs text-gray-200 uppercase bg-neutral-900">
                    <tr>
                        <th scope="col" class="px-3 py-3">Código Petición</th>
                        <th scope="col" class="px-3 py-3">Cliente Nacional</th>
                        <th scope="col" class="px-3 py-3">Cliente Extranjero</th>
                        <th scope="col" class="px-3 py-3">Fecha Creación</th>
                        <th scope="col" class="px-3 py-3">Precio Total</th>
                        <th scope="col" class="px-3 py-3">Tipo Envío</th>
                        <th scope="col" class="px-3 py-3">País Envío</th>
                        <th scope="col" class="px-3 py-3">Peso Total</th>
                        <th scope="col" class="px-3 py-3">Cantidad Paquetes</th>
                        <th scope="col" class="px-3 py-3 text-center">Detalle</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="peticion" items="${peticionesList}"> <%-- Usamos "peticionesList" como en el Servlet --%>
                        <tr class="bg-white border-b border-gray-300 hover:bg-gray-100 hover:text-neutral-900 transition duration-700">
                            <td class="px-3 py-4">
                                <c:out value="${peticion.codigo_peticion}" />
                            </td>
                            <td class="px-3 py-4">
                                <c:out value="${peticion.nombreClienteNacionalCompleto}" />
                            </td>
                            <td class="px-3 py-4">
                                <c:out value="${peticion.nombreClienteExtranjeroCompleto}" />
                            </td>
                            <td class="px-3 py-4">
                                <%-- Formatear la fecha para que se vea bien --%>
                                <fmt:formatDate value="${peticion.fecha_creacion}" pattern="dd/MM/yyyy" />
                            </td>
                            <td class="px-3 py-4">
                                <c:out value="${peticion.precio_total}" />
                            </td>
                            <td class="px-3 py-4">
                                <c:out value="${peticion.tipo_envio}" />
                            </td>
                            <td class="px-3 py-4">
                                <c:out value="${peticion.pais_envio}" />
                            </td>
                            <td class="px-3 py-4">
                                <c:out value="$${peticion.peso_total} Kg" />
                            </td>
                            <td class="px-3 py-4 justify-center">
                                <c:out value="${peticion.cantidad_paquetes}" />
                            </td>
                            <td class="py-4 flex gap-6 items-center justify-center">
                                <a href="peticionEnvioControlador?accion=verPaquetes&id_peticion=${peticion.id_peticion_envio}"
                                   class="inline-flex items-center justify-center w-8 h-8 rounded-md bg-green-100 text-green-600 hover:bg-green-200 focus:outline-none focus:ring-2 focus:ring-green-500 transition-colors duration-200"
                                   title="Ver Detalles">
                                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-4 h-4">
                                        <path stroke-linecap="round" stroke-linejoin="round" d="M2.036 12.322a1.012 1.012 0 010-.639C3.423 7.51 7.36 4.5 12 4.5c4.638 0 8.573 3.007 9.963 7.178.07.207.07.431 0 .639C20.577 16.49 16.64 19.5 12 19.5c-4.638 0-8.573-3.007-9.963-7.178z" />
                                        <path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                                    </svg>
                                    <span class="sr-only">Ver Detalles</span>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty peticionesList}">
                        <tr>
                            <td colspan="10" class="px-3 py-4 text-center text-gray-500">No hay peticiones de envío registradas.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>

            <%-- Paginación --%>
            <div class="flex justify-center mt-4">
                <c:if test="${totalPaginas > 1}">
                    <c:forEach var="i" begin="1" end="${totalPaginas}">
                        <c:choose>
                            <c:when test="${i == paginaActual}">
                                <span class="px-3 py-2 text-gray-500 font-semibold border border-gray-300 rounded mr-2">${i}</span>
                            </c:when>
                            <c:otherwise>
                                <a href="peticionEnvioControlador?accion=listarPeticiones&pagina=${i}" class="px-3 py-2 text-blue-500 hover:text-blue-700 bg-white border border-gray-300 rounded mr-2">${i}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </c:if>
            </div>
        </div>
                    
                </div>
            </div>
        </div>
    </body>
</html>
