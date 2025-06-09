
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <%@include file="WEB-INF/jspf/enlace.jspf" %>
        <title>Peticiones de Envios</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/sidebar.jspf" %>
        
        <div id="main-content" class="transition-all duration-300 sm:ml-64">
            <c:set var="pageTitle" value="Petición de Envio" scope="request"/>
            <%@include file="WEB-INF/jspf/navbar.jspf" %>
            
            <div class=" container mx-auto flex-col items-center justify-center">
                <div class="p-8 rounded w-full">
                    <h2 class="text-2xl pl-4 font-semibold mb-14 text-gray-800">Registrar Petición de envio</h2>
                    
                    <form class="max-w-6xl mx-auto" action="${pageContext.request.contextPath}/peticionEnvioControlador?accion=agregarPeticionEnvio" method="POST">
                        <div class="flex flex-wrap justify-center md:justify-start gap-x-16 gap-y-6">


                            <div class="relative z-0 w-full md:w-[calc(50%-32px)] xl:w-[calc(33.33%-42.66px)] mb-6 group">
                                <select name="id_cliente_nacional" id="floating_cliente_nacional"
                                    class="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 focus:outline-none focus:ring-0 focus:border-neutral-900 peer"
                                    >
                                    <option value="">Seleccione Cliente Nacional</option>
                                    <c:forEach var="cliente" items="${clientesNacionales}">
                                        <option value="${cliente.id_cliente}">${cliente.nombre} ${cliente.apellido}</option>
                                    </c:forEach>
                                </select>
                                <label for="floating_cliente_nacional"
                                    class="peer-focus:font-medium absolute text-sm text-gray-500 duration-300 transform -translate-y-6 scale-75 top-3 origin-[0] peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Cliente Nacional</label>
                            </div>

                            <div class="relative z-0 w-full md:w-[calc(50%-32px)] xl:w-[calc(33.33%-42.66px)] mb-6 group">
                                <select name="id_cliente_extranjero" id="floating_cliente_extranjero"
                                    class="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 focus:outline-none focus:ring-0 focus:border-neutral-900 peer"
                                    >
                                    <option value="">Seleccione Cliente Extranjero</option>
                                    <c:forEach var="cliente" items="${clientesExtranjeros}">
                                        <option value="${cliente.id_cliente}">${cliente.nombre} ${cliente.apellido}</option>
                                    </c:forEach>
                                </select>
                                <label for="floating_cliente_extranjero"
                                    class="peer-focus:font-medium absolute text-sm text-gray-500 duration-300 transform -translate-y-6 scale-75 top-3 origin-[0] peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Cliente Extranjero</label>
                            </div>

                            <div class="relative z-0 w-full md:w-[calc(50%-32px)] xl:w-[calc(33.33%-42.66px)] mb-6 group">
                                <input type="text" name="fecha_creacion" id="floating_fecha_creacion" value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>"
                                    class="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none focus:outline-none focus:ring-0 focus:border-neutral-900 peer"
                                    placeholder=" " required readonly/>
                                <label for="floating_fecha_creacion"
                                    class="peer-focus:font-medium absolute text-sm text-gray-500 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:start-0 rtl:peer-focus:translate-x-1/4 peer-focus:text-neutral-900 peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Fecha de Creación</label>
                            </div>

                            <div class="relative z-0 w-full md:w-[calc(50%-32px)] xl:w-[calc(33.33%-42.66px)] mb-6 group">
                                <select name="tipo_envio" id="floating_tipo_envio"
                                    class="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 focus:outline-none focus:ring-0 focus:border-neutral-900 peer"
                                    required>
                                    <option value="">Seleccione Tipo de Envío</option>
                                    <option value="Envio Maritimo">Envío Marítimo</option>
                                    <option value="Envio Aereo">Envío Aéreo</option>
                                </select>
                                <label for="floating_tipo_envio"
                                    class="peer-focus:font-medium absolute text-sm text-gray-500 duration-300 transform -translate-y-6 scale-75 top-3 origin-[0] peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Tipo de Envío</label>
                            </div>

                            <div class="relative z-0 w-full md:w-[calc(50%-32px)] xl:w-[calc(33.33%-42.66px)] mb-6 group">
                                <select name="pais_envio" id="floating_pais_envio"
                                    class="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 focus:outline-none focus:ring-0 focus:border-neutral-900 peer"
                                    required>
                                    <option value="">Seleccione País</option>
                                    <option value="Brasil">Brasil</option>
                                    <option value="Chile">Chile</option>
                                    <option value="Colombia">Colombia</option>
                                    <option value="Ecuador">Ecuador</option>
                                    <option value="Venezuela">Venezuela</option>
                                </select>
                                <label for="floating_pais_envio"
                                    class="peer-focus:font-medium absolute text-sm text-gray-500 duration-300 transform -translate-y-6 scale-75 top-3 origin-[0] peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">País de Envío</label>
                            </div>

                            <div class="w-full flex justify-start">
                                <button type="submit"
                                    class="flex items-center justify-center font-semibold hover:font-bold hover:bg-green-600 border-2 hover:border-green-600 bg-green-500 text-white focus:ring-4 focus:outline-none focus:ring-green-300 font-medium rounded-full text-sm w-full max-w-xs px-4 py-2 text-center transition duration-300">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
                                        stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                                        class="lucide lucide-plus mr-2">
                                        <path d="M12 5v14" />
                                        <path d="M5 12h14" />
                                    </svg>
                                    Agregar Petición
                                </button>
                            </div>
                        </div>
                    </form>
                    
    
                                    
                                    
                </div>
            </div>
           <%@include file="WEB-INF/jspf/notificacion.jspf" %>
        </div>
    </body>
</html>