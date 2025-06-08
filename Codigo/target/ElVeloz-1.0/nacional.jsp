
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <%@include file="WEB-INF/jspf/enlace.jspf" %>
        <title>Proveedores</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/sidebar.jspf" %>
        
        <div id="main-content" class="transition-all duration-300 sm:ml-64">
            <c:set var="pageTitle" value="Clientes Nacionales" scope="request"/>
            <%@include file="WEB-INF/jspf/navbar.jspf" %>
            
            <div class=" container mx-auto flex-col items-center justify-center">
                
                <div class="p-8 rounded w-full">
                    <h2 class="text-2xl pl-4 font-semibold mb-14 text-gray-800">Registrar Cliente Nacional</h2>

                    <form class="max-w-6xl mx-auto" action="nacionalControlador?accion=agregarClienteNacional" method="POST">
                        <div class="flex flex-wrap justify-center md:justify-between gap-x-16 gap-y-6">
                            <div class="relative z-0 w-full md:w-[calc(50%-32px)] xl:w-[calc(33.33%-42.66px)] mb-6 group">
                                <input type="text" name="nombre" id="floating_nombre"
                                    class="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none focus:outline-none focus:ring-0 focus:border-neutral-900 peer"
                                    placeholder=" " required />
                                <label for="floating_nombre"
                                    class="peer-focus:font-medium absolute text-sm text-gray-500 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:start-0 rtl:peer-focus:translate-x-1/4 peer-focus:text-neutral-900 peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Nombre</label>
                            </div>

                            <div class="relative z-0 w-full md:w-[calc(50%-32px)] xl:w-[calc(33.33%-42.66px)] mb-6 group">
                                <input type="text" name="apellido" id="floating_apellido"
                                    class="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none focus:outline-none focus:ring-0 focus:border-neutral-900 peer"
                                    placeholder=" " required />
                                <label for="floating_apellido"
                                    class="peer-focus:font-medium absolute text-sm text-gray-500 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:start-0 rtl:peer-focus:translate-x-1/4 peer-focus:text-neutral-900 peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Apellido</label>
                            </div>

                            <div class="relative z-0 w-full md:w-[calc(50%-32px)] xl:w-[calc(33.33%-42.66px)] mb-6 group">
                                <input type="email" name="email" id="floating_email"
                                    class="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none focus:outline-none focus:ring-0 focus:border-neutral-900 peer"
                                    placeholder=" " required />
                                <label for="floating_email"
                                    class="peer-focus:font-medium absolute text-sm text-gray-500 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:start-0 rtl:peer-focus:translate-x-1/4 peer-focus:text-neutral-900 peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Email</label>
                            </div>

                            <div class="relative z-0 w-full md:w-[calc(50%-32px)] xl:w-[calc(33.33%-42.66px)] mb-6 group">
                                <input type="tel" name="telefono" id="floating_telefono"
                                    class="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none focus:outline-none focus:ring-0 focus:border-neutral-900 peer"
                                    placeholder=" " required />
                                <label for="floating_telefono"
                                    class="peer-focus:font-medium absolute text-sm text-gray-500 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:start-0 rtl:peer-focus:translate-x-1/4 peer-focus:text-neutral-900 peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Teléfono</label>
                            </div>
                            
                            <div class="relative z-0 w-full md:w-[calc(50%-32px)] xl:w-[calc(33.33%-42.66px)] mb-6 group">
                                <select name="nacionalidad" id="floating_nacionalidad"
                                    class="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 focus:outline-none focus:ring-0 focus:border-neutral-900 peer"
                                    required>
                                    <option value="" disabled selected>Selecciona una nacionalidad</option>
                                    <option value="Peru">Perú</option>
                                    <option value="Brasil">Brasil</option>
                                    <option value="Chile">Chile</option>
                                    <option value="Colombia">Colombia</option>
                                    <option value="Ecuador">Ecuador</option>
                                    <option value="Venezuela">Venezuela</option>
                                </select>
                                <label for="floating_nacionalidad"
                                    class="peer-focus:font-medium absolute text-sm text-gray-500 duration-300 transform -translate-y-6 scale-75 top-3 origin-[0] peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Nacionalidad</label>
                            </div>

                            <div class="relative z-0 w-full md:w-[calc(50%-32px)] xl:w-[calc(33.33%-42.66px)] mb-6 group">
                                <select name="tipo_documento" id="floating_tipo_documento"
                                    class="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 focus:outline-none focus:ring-0 focus:border-neutral-900 peer"
                                    required>
                                    <option value="" disabled selected>Selecciona un tipo de documento</option>
                                    <option value="DNI">DNI</option>
                                    <option value="Pasaporte">Pasaporte</option>
                                    <option value="Carnet de Extranjeria">Carnet de Extranjería</option>
                                </select>
                                <label for="floating_tipo_documento"
                                    class="peer-focus:font-medium absolute text-sm text-gray-500 duration-300 transform -translate-y-6 scale-75 top-3 origin-[0] peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Tipo
                                    de Documento</label>
                            </div>

                            <div class="relative z-0 w-full md:w-[calc(50%-32px)] xl:w-[calc(33.33%-42.66px)] mb-6 group">
                                <input type="text" name="numero_documento" id="floating_numero_documento"
                                    class="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none focus:outline-none focus:ring-0 focus:border-neutral-900 peer"
                                    placeholder=" " required />
                                <label for="floating_numero_documento"
                                    class="peer-focus:font-medium absolute text-sm text-gray-500 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:start-0 rtl:peer-focus:translate-x-1/4 peer-focus:text-neutral-900 peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Número
                                    de Documento</label>
                            </div>

                            <div class="w-full flex justify-start">
                                <button type="submit"
                                    class="flex items-center justify-center font-semibold hover:font-bold hover:bg-green-600 border-2 hover:border-green-600 bg-green-500 text-white focus:ring-4 focus:outline-none focus:ring-green-300 font-medium rounded-full text-sm w-full max-w-xs px-4 py-2 text-center transition duration-300">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
                                        stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                                        class="lucide lucide-user-round-plus-icon lucide-user-round-plus mr-2">
                                        <path d="M2 21a8 8 0 0 1 13.292-6" />
                                        <circle cx="10" cy="8" r="5" />
                                        <path d="M19 16v6" />
                                        <path d="M22 19h-6" />
                                    </svg>
                                    Agregar
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
                
                <div class="relative overflow-x-auto lg:px-20 md:px-12 py-12">
                    <table class="w-full shadow-xl rounded-lg overflow-hidden text-sm text-left rtl:text-right text-gray-500">
                        <thead class="text-xs text-gray-200 uppercase bg-neutral-900">
                            <tr>
                                <th scope="col" class="px-3 py-3">Nombre</th>
                                <th scope="col" class="px-3 py-3">Apellido</th>
                                <th scope="col" class="px-3 py-3">Email</th>
                                <th scope="col" class="px-3 py-3">Teléfono</th>
                                <th scope="col" class="px-3 py-3">Nacionalidad</th>
                                <th scope="col" class="px-3 py-3">Tipo Doc.</th>
                                <th scope="col" class="px-3 py-3">Número Doc.</th>
                                <th scope="col" class="px-3 py-3 text-center">Acción</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="cliente" items="${clientes}">
                                <tr class="bg-white border-b border-gray-300 hover:bg-gray-100 hover:text-neutral-900 transition duration-700">
                                    <td class="px-3 py-4">
                                        <c:out value="${cliente.nombre}" />
                                    </td>
                                    <td class="px-3 py-4">
                                        <c:out value="${cliente.apellido}" />
                                    </td>
                                    <td class="px-3 py-4">
                                        <c:out value="${cliente.email}" />
                                    </td>
                                    <td class="px-3 py-4">
                                        <c:out value="${cliente.telefono}" />
                                    </td>
                                    <td class="px-3 py-4">
                                        <c:out value="${cliente.nacionalidad}" />
                                    </td>
                                    <td class="px-3 py-4">
                                        <c:out value="${cliente.tipo_documento}" />
                                    </td>
                                    <td class="px-3 py-4">
                                        <c:out value="${cliente.numero_documento}" />
                                    </td>
                                    <td class="py-4 flex gap-6 items-center justify-center">
                                        <button type="button" class="inline-flex items-center justify-center w-8 h-8 rounded-md bg-blue-100 text-blue-600 hover:bg-blue-200 focus:outline-none focus:ring-2 focus:ring-blue-500 transition-colors duration-200 btn-actualizar-cliente-nacional" data-id="${cliente.id_cliente}">
                                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-4 h-4">
                                                <path stroke-linecap="round" stroke-linejoin="round" d="M16.862 4.487l1.687-1.687a1.875 1.875 0 112.652 2.652L10.582 16.07a4.5 4.5 0 01-1.897 1.13L6 18l.8-2.685a4.5 4.5 0 011.13-1.897l8.932-8.932z" />
                                            </svg>
                                            <span class="sr-only">Modificar Cliente</span>
                                        </button>
                                        <a href="nacionalControlador?accion=eliminarCliente&id=${cliente.id_cliente}&pagina=${paginaActual}" class="inline-flex items-center justify-center w-8 h-8 rounded-md bg-red-100 text-red-600 hover:bg-red-200 focus:outline-none focus:ring-2 focus:ring-red-500 transition-colors duration-200">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="w-4 h-4 lucide lucide-trash2-icon lucide-trash-2">
                                                <path d="M3 6h18"/>
                                                <path d="M19 6v14c0 1-1 2-2 2H7c-1 0-2-1-2-2V6"/>
                                                <path d="M8 6V4c0-1 1-2 2-2h4c1 0 2 1 2 2v2"/>
                                                <line x1="10" x2="10" y1="11" y2="17"/>
                                                <line x1="14" x2="14" y1="11" y2="17"/>
                                            </svg>
                                            <span class="sr-only">Eliminar Cliente</span>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                            <%-- Mensaje si no hay clientes --%>
                            <c:if test="${empty clientes}">
                                <tr><td colspan="8" class="px-3 py-4 text-center text-gray-500">No hay clientes registrados.</td></tr>
                            </c:if>
                        </tbody>
                    </table>

                    <%--- Paginación ---%>
                    <div class="flex justify-center mt-4">
                        <c:if test="${totalPaginas > 1}">
                            <c:forEach var="i" begin="1" end="${totalPaginas}">
                                <c:choose>
                                    <c:when test="${i == paginaActual}">
                                        <span class="px-3 py-2 text-gray-500 font-semibold border border-gray-300 rounded mr-2">${i}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <%-- Ajusta 'clienteControlador' si tu servlet para clientes tiene otro nombre --%>
                                        <a href="nacionalControlador?accion=listarClientesNacionales&pagina=${i}" class="px-3 py-2 text-blue-500 hover:text-blue-700 bg-white border border-gray-300 rounded mr-2">${i}</a>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </c:if>
                    </div>
                </div>              
            </div>
                    
        <div id="modal-modificar-cliente-nacional" tabindex="-1" aria-hidden="true"
            class="hidden overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-50
                   flex justify-center items-center
                   w-full md:inset-0 h-[calc(100%-1rem)] max-h-full
                   bg-black bg-opacity-50">
           <div class="relative p-4 w-full max-w-md max-h-full">
               <div class="relative bg-white rounded-lg shadow-sm">
                   <div class="flex items-center justify-between p-4 md:p-5 border-b rounded-t border-gray-200">
                       <h3 class="text-lg font-semibold text-gray-900">
                           Editar Cliente Nacional
                       </h3>
                       <button type="button"
                               class="text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm w-8 h-8 ms-auto inline-flex justify-center items-center"
                               onclick="document.getElementById('modal-modificar-cliente-nacional').classList.add('hidden')">
                           <svg class="w-3 h-3" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 14 14">
                               <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                     d="m1 1 6 6m0 0 6 6M7 7l6-6M7 7l-6 6" />
                           </svg>
                           <span class="sr-only">Cerrar modal</span>
                       </button>
                   </div>
                   <form class="p-4 md:p-5" id="formulario-modificar-cliente-nacional">
                       <input type="hidden" id="id_cliente_nacional_modal" name="id_cliente" />
                       <div class="grid gap-4 mb-4">
                           <div>
                               <label for="nombre_nacional_modal" class="block mb-2 text-sm font-medium text-gray-900">Nombre</label>
                               <input type="text" id="nombre_nacional_modal" name="nombre" placeholder="Nombre" required
                                      class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5" />
                           </div>
                           <div>
                               <label for="apellido_nacional_modal" class="block mb-2 text-sm font-medium text-gray-900">Apellido</label>
                               <input type="text" id="apellido_nacional_modal" name="apellido" placeholder="Apellido" required
                                      class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5" />
                           </div>
                           <div>
                               <label for="email_nacional_modal" class="block mb-2 text-sm font-medium text-gray-900">Email</label>
                               <input type="email" id="email_nacional_modal" name="email" placeholder="ejemplo@dominio.com" required
                                      class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5" />
                           </div>
                           <div>
                               <label for="telefono_nacional_modal" class="block mb-2 text-sm font-medium text-gray-900">Teléfono</label>
                               <input type="text" id="telefono_nacional_modal" name="telefono" placeholder="+XX XXXXXXXXX"
                                      class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5" />
                           </div>
                           <div>
                               <label for="nacionalidad_nacional_modal" class="block mb-2 text-sm font-medium text-gray-900">Nacionalidad</label>
                               <select id="nacionalidad_nacional_modal" name="nacionalidad" required
                                       class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-primary-500 focus:border-primary-500 block w-full p-2.5">
                                   <option value="">Seleccione</option>
                                   <option value="Peru">Perú</option>
                                   <option value="Brasil">Brasil</option>
                                   <option value="Chile">Chile</option>
                                   <option value="Colombia">Colombia</option>
                                   <option value="Ecuador">Ecuador</option>
                                   <option value="Venezuela">Venezuela</option>
                               </select>
                           </div>
                           <div>
                               <label for="tipo_documento_nacional_modal" class="block mb-2 text-sm font-medium text-gray-900">Tipo Documento</label>
                               <select id="tipo_documento_nacional_modal" name="tipo_documento" required
                                       class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-primary-500 focus:border-primary-500 block w-full p-2.5">
                                   <option value="">Seleccione</option>
                                   <option value="DNI">DNI</option>
                                   <option value="Pasaporte">Pasaporte</option>
                                   <option value="Carnet de Extranjeria">Carnet de Extranjería</option>
                               </select>
                           </div>
                           <div>
                               <label for="numero_documento_nacional_modal" class="block mb-2 text-sm font-medium text-gray-900">Número Documento</label>
                               <input type="text" id="numero_documento_nacional_modal" name="numero_documento" placeholder="Número de Documento" required
                                      class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5" />
                           </div>
                       </div>
                       <div class="flex items-center justify-end space-x-2">
                           <button type="button"
                                   class="text-gray-700 bg-gray-200 hover:bg-gray-300 focus:ring-4 focus:outline-none focus:ring-gray-300 font-medium rounded-lg text-sm px-5 py-2.5"
                                   onclick="document.getElementById('modal-modificar-cliente-nacional').classList.add('hidden')">
                               Cancelar
                           </button>
                           <button type="submit" id="guardar-cliente-nacional"
                                   class="flex items-center justify-center text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5">
                               <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-save-icon lucide-save mr-2"><path d="M15.2 3a2 2 0 0 1 1.4.6l3.8 3.8a2 2 0 0 1 .6 1.4V19a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2z"/><path d="M17 21v-7a1 1 0 0 0-1-1H8a1 1 0 0 0-1 1v7"/><path d="M7 3v4a1 1 0 0 0 1 1h7"/></svg>
                               Guardar Cambios
                           </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>        
        <script src="js/actualizarClienteNacionalModal.js"></script>
        <%@include file="WEB-INF/jspf/notificacion.jspf" %>
            
        </div>
    </body>
</html>
