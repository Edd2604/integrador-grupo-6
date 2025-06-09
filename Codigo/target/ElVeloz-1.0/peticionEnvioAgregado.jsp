<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <%@include file="WEB-INF/jspf/enlace.jspf" %>
        <title>Petición de Envío</title>
    </head>
    <body>
        <%-- Calcula el costo total de los paquetes --%>
        <c:set var="costoUnitarioPorKg" value="0.0" />
        <c:choose>
            <c:when test="${peticion.tipo_envio eq 'Envio Aereo'}">
                <c:set var="costoUnitarioPorKg" value="10.0" />
            </c:when>
            <c:when test="${peticion.tipo_envio eq 'Envio Maritimo'}">
                <c:set var="costoUnitarioPorKg" value="5.0" />
            </c:when>
        </c:choose>
        <c:set var="totalCostoCalculado" value="${totalPesoPaquetes * costoUnitarioPorKg}" />
        
        <%@include file="WEB-INF/jspf/sidebar.jspf" %>
        
        <div id="main-content" class="transition-all duration-300 sm:ml-64">
            <c:set var="pageTitle" value="Dashboard" scope="request"/>
            <%@include file="WEB-INF/jspf/navbar.jspf" %>
            
            <div class=" container mx-auto flex-col items-center justify-center">
                <div class="p-8 rounded w-full">
                    <h2 class="text-2xl pl-4 font-semibold mb-14 text-gray-800">Registrar Petición de envio</h2>
                     
                        <c:if test="${peticion == null}">
                            <p class="text-center text-red-500">No se encontró la petición de envío.</p>
                            <div class="text-center mt-6">
                                <a href="${pageContext.request.contextPath}/dashboard.jsp"
                                   class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline">
                                    Volver al Dashboard
                                </a>
                            </div>
                        </c:if>


                        <c:if test="${peticion != null}">
                            <form class="max-w-6xl mx-auto" action="${pageContext.request.contextPath}/peticionEnvioControlador" method="POST">
                                <input type="hidden" name="accion" value="actualizarDetallePeticion">

                                <div class="flex flex-wrap justify-center md:justify-start gap-x-16 gap-y-6">

                                    <div class="relative z-0 w-full md:w-[calc(50%-32px)] xl:w-[calc(33.33%-42.66px)] mb-6 group hidden">
                                        <input type="text" name="id_peticion_envio" id="floating_id_peticion_envio" value="${peticion.id_peticion_envio}"
                                            class="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none focus:outline-none focus:ring-0 focus:border-neutral-900 peer"
                                            placeholder=" " readonly />
                                        <label for="floating_id_peticion_envio"
                                            class="peer-focus:font-medium absolute text-sm text-gray-500 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:start-0 rtl:peer-focus:translate-x-1/4 peer-focus:text-neutral-900 peer-placeholder-shown:scale-100
                                            peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Id Petición de Envío:</label>
                                    </div>

                                    <div class="relative z-0 w-full md:w-[calc(50%-32px)] xl:w-[calc(33.33%-42.66px)] mb-6 group">
                                        <input type="text" name="codigo_peticion" id="floating_codigo_peticion" value="${peticion.codigo_peticion}"
                                            class="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none focus:outline-none focus:ring-0 focus:border-neutral-900 peer"
                                            placeholder=" " readonly />
                                        <label for="floating_codigo_peticion"
                                            class="peer-focus:font-medium absolute text-sm text-gray-500 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:start-0 rtl:peer-focus:translate-x-1/4 peer-focus:text-neutral-900 peer-placeholder-shown:scale-100
                                            peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Código de Petición:</label>
                                    </div>

                                    <div class="relative z-0 w-full md:w-[calc(50%-32px)] xl:w-[calc(33.33%-42.66px)] mb-6 group">
                                        <input type="text" name="cliente_nacional_display" id="floating_cliente_nacional_display" value="${nombreClienteNacional}"
                                            class="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none focus:outline-none focus:ring-0 focus:border-neutral-900 peer"
                                            placeholder=" " readonly />
                                        <label for="floating_cliente_nacional_display"
                                            class="peer-focus:font-medium absolute text-sm text-gray-500 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:start-0 rtl:peer-focus:translate-x-1/4 peer-focus:text-neutral-900 peer-placeholder-shown:scale-100
                                            peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Cliente Nacional:</label>
                                         <input type="hidden" name="id_cliente_nacional" value="${peticion.id_cliente_nacional}">
                                    </div>

                                    <div class="relative z-0 w-full md:w-[calc(50%-32px)] xl:w-[calc(33.33%-42.66px)] mb-6 group">
                                        <input type="text" name="cliente_extranjero_display" id="floating_cliente_extranjero_display" value="${nombreClienteExtranjero}"
                                            class="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none focus:outline-none focus:ring-0 focus:border-neutral-900 peer"
                                            placeholder=" " readonly />
                                        <label for="floating_cliente_extranjero_display"
                                            class="peer-focus:font-medium absolute text-sm text-gray-500 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:start-0 rtl:peer-focus:translate-x-1/4 peer-focus:text-neutral-900 peer-placeholder-shown:scale-100
                                            peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Cliente Extranjero:</label>
                                         <input type="hidden" name="id_cliente_extranjero" value="${peticion.id_cliente_extranjero}">
                                    </div>

                                    <div class="relative z-0 w-full md:w-[calc(50%-32px)] xl:w-[calc(33.33%-42.66px)] mb-6 group">
                                        <input type="text" name="tipo_envio" id="floating_tipo_envio" value="${peticion.tipo_envio}"
                                            class="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none focus:outline-none focus:ring-0 focus:border-neutral-900 peer"
                                            placeholder=" " readonly />
                                        <label for="floating_tipo_envio"
                                            class="peer-focus:font-medium absolute text-sm text-gray-500 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:start-0 rtl:peer-focus:translate-x-1/4 peer-focus:text-neutral-900 peer-placeholder-shown:scale-100
                                            peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Tipo de Envío:</label>
                                    </div>

                                    <div class="relative z-0 w-full md:w-[calc(50%-32px)] xl:w-[calc(33.33%-42.66px)] mb-6 group">
                                        <input type="text" name="pais_envio" id="floating_pais_envio" value="${peticion.pais_envio}"
                                            class="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none focus:outline-none focus:ring-0 focus:border-neutral-900 peer"
                                            placeholder=" " readonly />
                                        <label for="floating_pais_envio"
                                            class="peer-focus:font-medium absolute text-sm text-gray-500 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:start-0 rtl:peer-focus:translate-x-1/4 peer-focus:text-neutral-900 peer-placeholder-shown:scale-100
                                            peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">País de Envío:</label>
                                    </div>

                                    <div class="relative z-0 w-full md:w-[calc(50%-32px)] xl:w-[calc(33.33%-42.66px)] mb-6 group">
                                        <input type="text" name="fecha_creacion_display" id="floating_fecha_creacion_display" value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>"
                                            class="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none focus:outline-none focus:ring-0 focus:border-neutral-900 peer"
                                            placeholder=" " readonly/>
                                        <label for="floating_fecha_creacion_display"
                                            class="peer-focus:font-medium absolute text-sm text-gray-500 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:start-0 rtl:peer-focus:translate-x-1/4 peer-focus:text-neutral-900 peer-placeholder-shown:scale-100
                                            peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Fecha de Creación:</label>
                                        <%-- <input type="hidden" name="fecha_creacion_db" value="<fmt:formatDate value="${peticion.fecha_creacion}" pattern="yyyy-MM-dd HH:mm:ss"/>"> --%>
                                    </div>

                                    <div class="relative z-0 w-full md:w-[calc(50%-32px)] xl:w-[calc(33.33%-42.66px)] mb-6 group hidden">
                                        <input type="text" name="id_usuario_display" id="floating_id_usuario_display" value="${peticion.id_usuario}"
                                            class="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none focus:outline-none focus:ring-0 focus:border-neutral-900 peer"
                                            placeholder=" " readonly />
                                        <label for="floating_id_usuario_display"
                                            class="peer-focus:font-medium absolute text-sm text-gray-500 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:start-0 rtl:peer-focus:translate-x-1/4 peer-focus:text-neutral-900 peer-placeholder-shown:scale-100
                                            peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">ID Usuario:</label>
                                        <input type="hidden" name="id_usuario" value="${peticion.id_usuario}">
                                    </div>

                                    <div class="relative z-0 w-full md:w-[calc(50%-32px)] xl:w-[calc(33.33%-42.66px)] mb-6 group">
                                        <input type="number" step="0.01" name="peso_total" id="floating_peso_total" value="${totalPesoPaquetes}"
                                            class="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none focus:outline-none focus:ring-0 focus:border-neutral-900 peer"
                                            placeholder=" " readonly/>
                                        <label for="floating_peso_total"
                                            class="peer-focus:font-medium absolute text-sm text-gray-500 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:start-0 rtl:peer-focus:translate-x-1/4 peer-focus:text-neutral-900 peer-placeholder-shown:scale-100
                                            peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Peso Total (kg):</label>
                                    </div>
                                            
                                    <div class="relative z-0 w-full md:w-[calc(50%-32px)] xl:w-[calc(33.33%-42.66px)] mb-6 group">
                                        <input type="number" step="0.01" name="precio_total" id="floating_precio_total" value="${totalCostoCalculado}"
                                            class="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none focus:outline-none focus:ring-0 focus:border-neutral-900 peer"
                                            placeholder=" " readonly/>
                                        <label for="floating_pecio_total"
                                            class="peer-focus:font-medium absolute text-sm text-gray-500 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:start-0 rtl:peer-focus:translate-x-1/4 peer-focus:text-neutral-900 peer-placeholder-shown:scale-100
                                            peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Precio Total ($):</label>
                                    </div>        

                                    <div class="relative z-0 w-full md:w-[calc(50%-32px)] xl:w-[calc(33.33%-42.66px)] mb-6 group">
                                        <input type="number" name="cantidad_paquetes" id="floating_cantidad_paquetes" value="${cantidadTotalPaquetes}"
                                            class="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none focus:outline-none focus:ring-0 focus:border-neutral-900 peer"
                                            placeholder=" " min="0" readonly/>
                                        <label for="floating_cantidad_paquetes"
                                            class="peer-focus:font-medium absolute text-sm text-gray-500 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:start-0 rtl:peer-focus:translate-x-1/4 peer-focus:text-neutral-900 peer-placeholder-shown:scale-100
                                            peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Cantidad de Paquetes:</label>
                                    </div>

                                   <div class="w-full flex flex-col md:flex-row justify-start items-center gap-4">
                                        <button type="submit"
                                            class="flex items-center justify-center font-semibold hover:font-bold hover:bg-green-600 border-2 hover:border-green-600 bg-green-500 text-white focus:ring-4 focus:outline-none focus:ring-green-300 font-medium rounded-full text-sm w-full md:w-auto px-4 py-2 text-center transition duration-300">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
                                                stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                                                class="lucide lucide-check-circle mr-2">
                                                <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14" />
                                                <path d="m9 11 3 3L22 4" />
                                            </svg>
                                            Actualizar Datos
                                        </button>

                                        <button type="button"
                                            onclick="openAgregarPaqueteModal(${peticion.id_peticion_envio})" 
                                            class="flex items-center justify-center font-semibold hover:font-bold hover:bg-blue-600 border-2 hover:border-blue-600 bg-blue-500 text-white focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-full text-sm w-full md:w-auto px-4 py-2 text-center transition duration-300">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
                                                stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                                                class="lucide lucide-plus mr-2">
                                                <path d="M12 5v14" />
                                                <path d="M5 12h14" />
                                            </svg>
                                            Agregar Paquete
                                        </button>

                                        <a href="peticionEnvioControlador?accion=eliminarPeticion&id_peticion_envio=${peticion.id_peticion_envio}"
                                            class="flex items-center justify-center font-semibold hover:font-bold hover:bg-red-600 border-2 hover:border-red-600 bg-red-500 text-white focus:ring-4 focus:outline-none focus:ring-red-300 font-medium rounded-full text-sm w-full md:w-auto px-4 py-2 text-center transition duration-300">
                                             <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
                                                 stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                                                 class="lucide lucide-x-circle mr-2">
                                                 <circle cx="12" cy="12" r="10" />
                                                 <path d="m15 9-6 6" />
                                                 <path d="m9 9 6 6" />
                                             </svg>
                                             Cancelar Petición
                                         </a>
                                    </div>
                                </div>
                            </form>
                        </c:if>
     
                        <div class="relative overflow-x-auto lg:px-20 md:px-12 py-12">
                            <c:if test="${not empty paquetes}">
                                <table class="w-full shadow-xl rounded-lg overflow-hidden text-sm text-left rtl:text-right text-gray-500">
                                    <thead class="text-xs text-gray-200 uppercase bg-neutral-900">
                                        <tr>
                                            <th scope="col" class="px-3 py-3">Nombre</th>
                                            <th scope="col" class="px-3 py-3">Categoría</th>
                                            <th scope="col" class="px-3 py-3">Cantidad</th>
                                            <th scope="col" class="px-3 py-3">Peso (kg)</th>
                                            <th scope="col" class="px-3 py-3">Eliminar</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="paquete" items="${paquetes}">
                                            <tr class="bg-white border-b border-gray-300 hover:bg-gray-100 hover:text-neutral-900 transition duration-700">
                                                <td class="px-3 py-4">${paquete.nombre}</td>
                                                <td class="px-3 py-4">${paquete.categoria}</td>
                                                <td class="px-3 py-4">${paquete.cantidad}</td>
                                                <td class="px-3 py-4">${paquete.peso} Kg</td>
                                                <td class="py-4 flex gap-6 items-center justify-start">
                                                   <a href="paqueteControlador?accion=eliminarPaquete&id=${paquete.id_paquete}&idPeticion=${peticion.id_peticion_envio}" class="inline-flex items-center justify-center w-8 h-8 rounded-md bg-red-100 text-red-600 hover:bg-red-200 focus:outline-none focus:ring-2 focus:ring-red-500 transition-colors duration-200">
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="w-4 h-4 lucide lucide-trash2-icon lucide-trash-2">
                                                            <path d="M3 6h18"/>
                                                            <path d="M19 6v14c0 1-1 2-2 2H7c-1 0-2-1-2-2V6"/>
                                                            <path d="M8 6V4c0-1 1-2 2-2h4c1 0 2 1 2 2v2"/>
                                                            <line x1="10" x2="10" y1="11" y2="17"/>
                                                            <line x1="14" x2="14" y1="11" y2="17"/>
                                                        </svg>
                                                        <span class="sr-only">Eliminar</span
                                                   </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </c:if>
                            <c:if test="${empty paquetes}">
                                <p class="px-3 py-4 text-center text-gray-500">No hay paquetes asociados a esta petición de envío.</p>
                            </c:if>    
                        </div>
                        
    
                </div>
                    
            </div>
            
            <div id="modal-agregar-paquete" tabindex="-1" aria-hidden="true"
                class="hidden overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-50
                       flex justify-center items-center
                       w-full md:inset-0 h-[calc(100%-1rem)] max-h-full
                       bg-black bg-opacity-50">
               <div class="relative p-4 w-full max-w-md max-h-full">
                   <div class="relative bg-white rounded-lg shadow-sm">
                       <div class="flex items-center justify-between p-4 md:p-5 border-b rounded-t border-gray-200">
                           <h3 class="text-lg font-semibold text-gray-900">
                               Agregar Nuevo Paquete
                           </h3>
                           <button type="button"
                                   class="text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm w-8 h-8 ms-auto inline-flex justify-center items-center"
                                   onclick="document.getElementById('modal-agregar-paquete').classList.add('hidden')">
                               <svg class="w-3 h-3" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 14 14">
                                   <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                         d="m1 1 6 6m0 0 6 6M7 7l6-6M7 7l-6 6" />
                               </svg>
                               <span class="sr-only">Cerrar modal</span>
                           </button>
                       </div>
                       <form class="p-4 md:p-5" id="formulario-agregar-paquete" action="${pageContext.request.contextPath}/paqueteControlador?accion=agregarPaquete" method="POST">
                           <input type="hidden" name="accion" value="agregarPaquete">
                           <input type="hidden" id="paquete_id_peticion_envio" name="id_peticion_envio" value=""> 

                           <div class="grid gap-4 mb-4">
                               <div>
                                   <label for="paquete_nombre" class="block mb-2 text-sm font-medium text-gray-900">Nombre de la prenda</label>
                                   <input type="text" id="paquete_nombre" name="nombre" placeholder="Ej: Pantalón, Camisa" required
                                          class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5" />
                               </div>

                               <div>
                                   <label for="paquete_categoria" class="block mb-2 text-sm font-medium text-gray-900">Categoría</label>
                                   <select id="paquete_categoria" name="categoria" required
                                           class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-primary-500 focus:border-primary-500 block w-full p-2.5">
                                       <option value="">Selecciona una categoría</option>
                                       <option value="Caballero">Caballero</option>
                                       <option value="Dama">Dama</option>
                                       <option value="Niño">Niño</option>
                                       <option value="Niña">Niña</option>
                                       <option value="Bebé">Bebé</option>
                                   </select>
                               </div>
                               
                               <div>
                                    <label for="paquete_cantidad" class="block mb-2 text-sm font-medium text-gray-900">Cantidad</label>
                                    <input type="number" id="paquete_cantidad" name="cantidad" placeholder="Ej: 1, 5" required min="1" step="1"
                                           class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5" />
                                </div>

                               <div>
                                   <label for="paquete_peso" class="block mb-2 text-sm font-medium text-gray-900">Peso (kg)</label>
                                   <input type="number" step="0.01" id="paquete_peso" name="peso" placeholder="Ej: 2.5" required min="0.01"
                                          class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5" />
                               </div>

                               </div>

                           <div class="flex items-center justify-end space-x-2">
                               <button type="button"
                                       class="text-gray-700 bg-gray-200 hover:bg-gray-300 focus:ring-4 focus:outline-none focus:ring-gray-300 font-medium rounded-lg text-sm px-5 py-2.5"
                                       onclick="document.getElementById('modal-agregar-paquete').classList.add('hidden')">
                                   Cancelar
                               </button>
                               <button type="submit" id="guardar-paquete"
                                       class="flex items-center justify-center text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5">
                                   <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-save-icon lucide-save mr-2"><path d="M15.2 3a2 2 0 0 1 1.4.6l3.8 3.8a2 2 0 0 1 .6 1.4V19a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2z"/><path d="M17 21v-7a1 1 0 0 0-1-1H8a1 1 0 0 0-1 1v7"/><path d="M7 3v4a1 1 0 0 0 1 1h7"/></svg>
                                   Guardar Paquete
                               </button>
                           </div>
                       </form>
                   </div>
               </div>
           </div>
                <script>
                    function openAgregarPaqueteModal(id_peticion_envio) {
                        // Establecer el valor del campo oculto id_peticion_envio en el modal
                        document.getElementById('paquete_id_peticion_envio').value = id_peticion_envio;

                        // Mostrar el modal
                        document.getElementById('modal-agregar-paquete').classList.remove('hidden');
                    }

                    // Opcional: Para cerrar el modal también con la tecla ESC
                    document.addEventListener('keydown', function(event) {
                        if (event.key === 'Escape') {
                            document.getElementById('modal-agregar-paquete').classList.add('hidden');
                        }
                    });
                </script>
            
        </div>
        <%@include file="WEB-INF/jspf/notificacion.jspf" %>
    </body>
</html>