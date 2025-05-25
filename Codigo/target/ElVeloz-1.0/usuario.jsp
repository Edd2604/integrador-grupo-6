
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <%@include file="WEB-INF/jspf/enlace.jspf" %>
        <title>Usuarios</title>
    </head>
    <body class="">
        <%@include file="WEB-INF/jspf/sidebar.jspf" %>
        
        <div id="main-content" class="transition-all duration-300 sm:ml-64">
            <c:set var="pageTitle" value="Usuarios" scope="request"/>
            <%@include file="WEB-INF/jspf/navbar.jspf" %>
            
            <div class="container mx-auto flex-col items-center justify-center">
                <div class="p-8 rounded w-full">
                    <h2 class="text-2xl pl-4 font-semibold mb-14 text-gray-800">Registrar Usuario</h2>

                    <form class="max-w-6xl mx-auto" action="usuarioControlador?accion=agregarUsuario" method="POST">
                        <div class="flex flex-wrap justify-center md:justify-between gap-x-16 gap-y-6">
                            <div class="relative z-0 w-full md:w-[calc(50%-32px)] xl:w-[calc(33.33%-42.66px)] mb-6 group">
                                <input type="text" name="username" id="floating_username"
                                    class="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none focus:outline-none focus:ring-0 focus:border-neutral-900 peer"
                                    placeholder=" " required />
                                <label for="floating_username"
                                    class="peer-focus:font-medium absolute text-sm text-gray-500 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:start-0 rtl:peer-focus:translate-x-1/4 peer-focus:text-neutral-900 peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Usuario</label>
                            </div>
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
                                <input type="password" name="password" id="floating_password"
                                    class="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none focus:outline-none focus:ring-0 focus:border-neutral-900 peer"
                                    placeholder=" " required />
                                <label for="floating_password"
                                    class="peer-focus:font-medium absolute text-sm text-gray-500 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:start-0 rtl:peer-focus:translate-x-1/4 peer-focus:text-neutral-900 peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Contraseña</label>
                            </div>
                            <div class="relative z-0 w-full md:w-[calc(50%-32px)] xl:w-[calc(33.33%-42.66px)] mb-6 group">
                                <input type="password" name="confirmarPassword" id="floating_confirm_password"
                                    class="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none focus:outline-none focus:ring-0 focus:border-neutral-900 peer"
                                    placeholder=" " required />
                                <label for="floating_confirm_password"
                                    class="peer-focus:font-medium absolute text-sm text-gray-500 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:start-0 rtl:peer-focus:translate-x-1/4 peer-focus:text-neutral-900 peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Confirmar
                                    Contraseña</label>
                            </div>

                            <div class="relative z-0 w-full md:w-[calc(50%-32px)] xl:w-[calc(33.33%-42.66px)] mb-6 group">
                                <select name="rol" id="floating_role"
                                    class="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 focus:outline-none focus:ring-0 focus:border-neutral-900 peer"
                                    required>
                                    <option value="2" selected>Usuario</option>
                                    <option value="1">Administrador</option>
                                </select>
                                <label for="floating_role"
                                    class="peer-focus:font-medium absolute text-sm text-gray-500 duration-300 transform -translate-y-6 scale-75 top-3 origin-[0] peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Rol</label>
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
                <div/>
                
                <div class="relative overflow-x-auto lg:px-20 md:px-12 md:px-2 py-12">
                    <table class="w-full shadow-xl rounded-lg overflow-hidden text-sm text-left rtl:text-right text-gray-500">
                        <thead class="text-xs text-gray-200 uppercase bg-neutral-900">
                            <tr>
                                <th scope="col" class="px-3 py-3">Usuario</th>
                                <th scope="col" class="px-3 py-3">Nombre</th>
                                <th scope="col" class="px-3 py-3">Apellido</th>
                                <th scope="col" class="px-3 py-3">Rol</th>
                                <th scope="col" class="px-3 py-3 text-center">Acción</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="usuario" items="${usuariosActivos}">
                                <tr class="bg-white border-b border-gray-300 hover:bg-gray-100 hover:text-neutral-900 transition duration-700">
                                    <td class="px-3 py-4">
                                        <c:out value="${usuario.username}" />
                                    </td>
                                    <td class="px-3 py-4">
                                        <c:out value="${usuario.nombre}" />
                                    </td>
                                    <td class="px-3 py-4">
                                        <c:out value="${usuario.apellido}" />
                                    </td>
                                    <td class="px-3 py-4">
                                        <c:choose>
                                            <c:when test="${usuario.id_rol == 1}">Administrador</c:when>
                                            <c:when test="${usuario.id_rol == 2}">Usuario</c:when>
                                            <c:otherwise>Desconocido</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="py-4 flex gap-6 items-center justify-center">
                                        <button type="button" class="inline-flex items-center justify-center w-8 h-8 rounded-md bg-blue-100 text-blue-600 hover:bg-blue-200 focus:outline-none focus:ring-2 focus:ring-blue-500 transition-colors duration-200 btn-actualizar" data-id="${usuario.id_usuario}">
                                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-4 h-4">
                                                <path stroke-linecap="round" stroke-linejoin="round" d="M16.862 4.487l1.687-1.687a1.875 1.875 0 112.652 2.652L10.582 16.07a4.5 4.5 0 01-1.897 1.13L6 18l.8-2.685a4.5 4.5 0 011.13-1.897l8.932-8.932z" />
                                            </svg>
                                            <span class="sr-only">Modificar</span>
                                        </button>
                                        <a href="usuarioControlador?accion=eliminarUsuario&id=${usuario.id_usuario}&pagina=${paginaActual}" class="inline-flex items-center justify-center w-8 h-8 rounded-md bg-red-100 text-red-600 hover:bg-red-200 focus:outline-none focus:ring-2 focus:ring-red-500 transition-colors duration-200">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="w-4 h-4 lucide lucide-trash2-icon lucide-trash-2">
                                                <path d="M3 6h18"/>
                                                <path d="M19 6v14c0 1-1 2-2 2H7c-1 0-2-1-2-2V6"/>
                                                <path d="M8 6V4c0-1 1-2 2-2h4c1 0 2 1 2 2v2"/>
                                                <line x1="10" x2="10" y1="11" y2="17"/>
                                                <line x1="14" x2="14" y1="11" y2="17"/>
                                            </svg>
                                            <span class="sr-only">Eliminar</span>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty usuariosActivos}">
                                <tr><td colspan="5" class="px-3 py-4 text-center text-gray-500">No hay usuarios activos.</td></tr>
                            </c:if>
                        </tbody>
                    </table>

                        <div class="flex justify-center mt-4">
                            <c:if test="${totalPaginas > 1}">
                                <c:forEach var="i" begin="1" end="${totalPaginas}">
                                    <c:choose>
                                        <c:when test="${i == paginaActual}">
                                            <span class="px-3 py-2 text-gray-500 font-semibold border border-gray-300 rounded mr-2">${i}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="usuarioControlador?accion=listarActivos&pagina=${i}" class="px-3 py-2 text-blue-500 hover:text-blue-700 bg-white border border-gray-300 rounded mr-2">${i}</a>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </c:if>
                        </div>
                    
                </div>      
            </div>
            
            <div id="modal-modificar" tabindex="-1" aria-hidden="true"
                class="hidden overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-50
                       flex justify-center items-center
                       w-full md:inset-0 h-[calc(100%-1rem)] max-h-full
                       bg-black bg-opacity-50">
                <div class="relative p-4 w-full max-w-md max-h-full">
                     <div class="relative bg-white rounded-lg shadow-sm">
                          <div class="flex items-center justify-between p-4 md:p-5 border-b rounded-t border-gray-200">
                               <h3 class="text-lg font-semibold text-gray-900">
                                    Editar Usuario
                               </h3>
                               <button type="button"
                                    class="text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm w-8 h-8 ms-auto inline-flex justify-center items-center"
                                    onclick="document.getElementById('modal-modificar').classList.add('hidden')">
                                    <svg class="w-3 h-3" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 14 14">
                                         <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                              d="m1 1 6 6m0 0 6 6M7 7l6-6M7 7l-6 6" />
                                    </svg>
                                    <span class="sr-only">Cerrar modal</span>
                               </button>
                          </div>
                          <form class="p-4 md:p-5" id="formulario-modificar">
                               <input type="hidden" id="id_usuario" name="id_usuario" />
                               <div class="grid gap-4 mb-4">
                                    <div>
                                         <label for="username" class="block mb-2 text-sm font-medium text-gray-900">Usuario</label>
                                         <input type="text" id="username" name="username" placeholder="Nombre de usuario" required
                                              class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5" />
                                    </div>
                                    <div>
                                         <label for="nombre" class="block mb-2 text-sm font-medium text-gray-900 ">Nombre</label>
                                         <input type="text" id="nombre" name="nombre" placeholder="Nombre" required
                                              class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 " />
                                    </div>
                                    <div>
                                         <label for="apellido" class="block mb-2 text-sm font-medium text-gray-900">Apellido</label>
                                         <input type="text" id="apellido" name="apellido" placeholder="Apellido" required
                                              class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 " />
                                    </div>
                                    <div>
                                         <label for="rol" class="block mb-2 text-sm font-medium text-gray-900">Rol</label>
                                         <select id="rol" name="rol" required
                                              class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-primary-500 focus:border-primary-500 block w-full p-2.5"/>
                                              <option value="2">Usuario</option>
                                              <option value="1">Administrador</option>
                                         </select>
                                    </div>
                               </div>
                               <div class="flex items-center justify-end space-x-2">
                                    <button type="button"
                                         class="text-gray-700 bg-gray-200 hover:bg-gray-300 focus:ring-4 focus:outline-none focus:ring-gray-300 font-medium rounded-lg text-sm px-5 py-2.5 "
                                         onclick="document.getElementById('modal-modificar').classList.add('hidden')">
                                         Cancelar
                                    </button>
                                    <button type="button" id="guardar-usuario"
                                        class="flex items-center justify-center text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 ">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-save-icon lucide-save mr-2"><path d="M15.2 3a2 2 0 0 1 1.4.6l3.8 3.8a2 2 0 0 1 .6 1.4V19a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2z"/><path d="M17 21v-7a1 1 0 0 0-1-1H8a1 1 0 0 0-1 1v7"/><path d="M7 3v4a1 1 0 0 0 1 1h7"/></svg>
                                    Guardar
                                </button>
                               </div>
                          </form>
                     </div>
                </div>
           </div>
            
        <script src="js/actualizarUsuarioModal.js"></script>

        <%
        // Recuperar los mensajes de notificación de la sesión
        String notificationType = (String) session.getAttribute("notificationType");
        String notificationMessage = (String) session.getAttribute("notificationMessage");

        // Limpiar los atributos de sesión inmediatamente después de leerlos
        // para que la notificación no se muestre en la siguiente carga de página.
        session.removeAttribute("notificationType");
        session.removeAttribute("notificationMessage");

        if (notificationType != null && !notificationMessage.isEmpty()) {
    %>
        <div id="notification" class="notification-container px-4 py-3 rounded-lg flex items-center space-x-3 max-w-xs
            <%= "success".equals(notificationType) ? "notification-success" : "notification-error" %>">

            <div class="icon-wrapper <%= "success".equals(notificationType) ? "notification-success" : "notification-error" %> icon-circle-bg">
                <div class="icon-inner-circle <%= "success".equals(notificationType) ? "notification-success" : "notification-error" %> icon-bg">
                    <% if ("success".equals(notificationType)) { %>
                        <svg class="icon-svg" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
                        </svg>
                    <% } else { %>
                        <svg class="icon-svg" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
                            <path d="M2.93 17.07A10 10 0 1 1 17.07 2.93 10 10 0 0 1 2.93 17.07zM9 5v6h2V5H9zm0 8v2h2v-2H9z"/>
                        </svg>
                    <% } %>
                </div>
            </div>

            <div class="flex-grow">
                <% if ("success".equals(notificationType)) { %>
                    <strong class="font-bold">¡Éxito!</strong>
                <% } else { %>
                    <strong class="font-bold">¡Error!</strong>
                <% } %>
                <span class="block sm:inline"><%= notificationMessage %></span>
            </div>

            <button class="close-button" onclick="document.getElementById('notification').classList.remove('show')">
                <svg class="h-4 w-4 fill-current" role="button" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><title>Cerrar</title><path d="M14.348 14.849a1.2 1.2 0 0 1-1.697 0L10 11.697l-2.651 2.652a1.2 1.2 0 1 1-1.697-1.697L8.303 10 5.651 7.348a1.2 1.2 0 1 1 1.697-1.697L10 8.303l2.651-2.652a1.2 1.2 0 1 1 1.697 1.697L11.697 10l2.651 2.651a1.2 1.2 0 0 1 0 1.698z"/></svg>
            </button>
        </div>

        <script>
            document.addEventListener('DOMContentLoaded', function() {
                const notification = document.getElementById('notification');
                if (notification) {
                    setTimeout(() => {
                        notification.classList.add('show');
                    }, 100);

                    setTimeout(() => {
                        notification.classList.remove('show');
                    }, 5000); // 5 segundos
                }
            });
        </script>
    <%
        }
    %>
        
        
    </div>    
        
        
        
        
    </body>
</html>