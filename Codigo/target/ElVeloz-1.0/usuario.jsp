
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <%@include file="WEB-INF/jspf/enlace.jspf" %>
        <title>Usuarios</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/sidebar.jspf" %>
        
        <div id="main-content" class="transition-all duration-300 sm:ml-64">
            <c:set var="pageTitle" value="Usuarios" scope="request"/>
            <%@include file="WEB-INF/jspf/navbar.jspf" %>
            
            <div class=" container mx-auto flex-col items-center justify-center">
                <div class="bg-white p-8 rounded w-full">
                    <h2 class="text-2xl font-semibold mb-14 text-gray-800">Registrar Usuario</h2>

                    <form class="max-w-6xl mx-auto px-4" action="usuarioControlador?accion=agregarUsuario" method="POST">
                        <div class="grid xl:grid-cols-3 grid md:grid-cols-2 md:gap-6">
                          <div class="relative z-0 w-full mb-6 group">
                            <input type="text" name="username" id="floating_username"
                              class="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none dark:text-white dark:border-gray-600 dark:focus:border-blue-500 focus:outline-none focus:ring-0 focus:border-blue-600 peer"
                              placeholder=" " required />
                            <label for="floating_username"
                              class="peer-focus:font-medium absolute text-sm text-gray-500 dark:text-gray-400 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:start-0 rtl:peer-focus:translate-x-1/4 peer-focus:text-blue-600 peer-focus:dark:text-blue-500 peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Usuario</label>
                          </div>
                          <div class="relative z-0 w-full mb-6 group">
                            <input type="text" name="nombre" id="floating_nombre"
                              class="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none dark:text-white dark:border-gray-600 dark:focus:border-blue-500 focus:outline-none focus:ring-0 focus:border-blue-600 peer"
                              placeholder=" " required />
                            <label for="floating_nombre"
                              class="peer-focus:font-medium absolute text-sm text-gray-500 dark:text-gray-400 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:start-0 rtl:peer-focus:translate-x-1/4 peer-focus:text-blue-600 peer-focus:dark:text-blue-500 peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Nombre</label>
                          </div>

                          <div class="relative z-0 w-full mb-6 group">
                            <input type="text" name="apellido" id="floating_apellido"
                              class="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none dark:text-white dark:border-gray-600 dark:focus:border-blue-500 focus:outline-none focus:ring-0 focus:border-blue-600 peer"
                              placeholder=" " required />
                            <label for="floating_apellido"
                              class="peer-focus:font-medium absolute text-sm text-gray-500 dark:text-gray-400 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:start-0 rtl:peer-focus:translate-x-1/4 peer-focus:text-blue-600 peer-focus:dark:text-blue-500 peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Apellido</label>
                          </div>
                          <div class="relative z-0 w-full mb-6 group">
                            <input type="password" name="password" id="floating_password"
                              class="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none dark:text-white dark:border-gray-600 dark:focus:border-blue-500 focus:outline-none focus:ring-0 focus:border-blue-600 peer"
                              placeholder=" " required />
                            <label for="floating_password"
                              class="peer-focus:font-medium absolute text-sm text-gray-500 dark:text-gray-400 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:start-0 rtl:peer-focus:translate-x-1/4 peer-focus:text-blue-600 peer-focus:dark:text-blue-500 peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Contraseña</label>
                          </div>
                          <div class="relative z-0 w-full mb-6 group">
                            <input type="password" name="confirmarPassword" id="floating_confirm_password"
                              class="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none dark:text-white dark:border-gray-600 dark:focus:border-blue-500 focus:outline-none focus:ring-0 focus:border-blue-600 peer"
                              placeholder=" " required />
                            <label for="floating_confirm_password"
                              class="peer-focus:font-medium absolute text-sm text-gray-500 dark:text-gray-400 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:start-0 rtl:peer-focus:translate-x-1/4 peer-focus:text-blue-600 peer-focus:dark:text-blue-500 peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Confirmar
                              Contraseña</label>
                          </div>
                          <div class="relative z-0 w-full mb-6 group">
                            <select name="rol" id="floating_role"
                              class="block py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none dark:text-white dark:border-gray-600 dark:focus:border-blue-500 focusBayes:outline-none focus:ring-0 focus:border-blue-600 peer"
                              required>
                              <option value="2" selected>Usuario</option>
                              <option value="1">Administrador</option>
                            </select>
                            <label for="floating_role"
                              class="peer-focus:font-medium absolute text-sm text-gray-500 dark:text-gray-400 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:start-0 rtl:peer-focus:translate-x-1/4 peer-focus:text-blue-600 peer-focus:dark:text-blue-500 peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Rol</label>
                          </div>
                        </div>
                        <div class="flex">
                            <button type="submit"
                                    class="flex items-center justify-center font-semibold text-green-500 bg-white border-2 border-green-500 hover:bg-green-500 hover:text-white focus:ring-4 focus:outline-none focus:ring-green-300 font-medium rounded-full text-sm w-full max-w-xs px-4 py-2 text-center transition duration-300">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-user-round-plus-icon lucide-user-round-plus mr-2"><path d="M2 21a8 8 0 0 1 13.292-6"/><circle cx="10" cy="8" r="5"/><path d="M19 16v6"/><path d="M22 19h-6"/></svg>
                                Agregar
                            </button>
                        </div>
                      </form>
                </div>              
                
                <div class="relative overflow-x-auto shadow-md sm:rounded-lg py-4 lg:px-20 md:px-12 px-2">
                    <table class="w-full rounded-lg overflow-hidden text-sm text-left rtl:text-right text-gray-500 pr-4">
                        <thead class="text-xs text-gray-200 uppercase bg-gray-800">
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
                                <tr class="bg-white border-b border-gray-300 hover:bg-gray-100 transition duration-700">
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
                     <div class="relative bg-white rounded-lg shadow-sm dark:bg-gray-700">
                          <div class="flex items-center justify-between p-4 md:p-5 border-b rounded-t border-gray-200 dark:border-gray-600">
                               <h3 class="text-lg font-semibold text-gray-900 dark:text-white">
                                    Editar Usuario
                               </h3>
                               <button type="button"
                                    class="text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm w-8 h-8 ms-auto inline-flex justify-center items-center dark:hover:bg-gray-600 dark:hover:text-white"
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
                                         <label for="username" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Usuario</label>
                                         <input type="text" id="username" name="username" placeholder="Nombre de usuario" required
                                              class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white" />
                                    </div>
                                    <div>
                                         <label for="nombre" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Nombre</label>
                                         <input type="text" id="nombre" name="nombre" placeholder="Nombre" required
                                              class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white" />
                                    </div>
                                    <div>
                                         <label for="apellido" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Apellido</label>
                                         <input type="text" id="apellido" name="apellido" placeholder="Apellido" required
                                              class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white" />
                                    </div>
                                    <div>
                                         <label for="rol" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Rol</label>
                                         <select id="rol" name="rol" required
                                              class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-primary-500 focus:border-primary-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white" >
                                              <option value="" disabled selected>Seleccione un rol</option>
                                              <option value="2">Usuario</option>
                                              <option value="1">Administrador</option>
                                         </select>
                                    </div>
                               </div>
                               <div class="flex items-center justify-end space-x-2">
                                    <button type="button"
                                         class="text-gray-700 bg-gray-200 hover:bg-gray-300 focus:ring-4 focus:outline-none focus:ring-gray-300 font-medium rounded-lg text-sm px-5 py-2.5 dark:bg-gray-600 dark:text-white dark:hover:bg-gray-700 dark:focus:ring-gray-800"
                                         onclick="document.getElementById('modal-modificar').classList.add('hidden')">
                                         Cancelar
                                    </button>
                                    <button type="button" id="guardar-usuario"
                                        class="flex items-center justify-center text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-save-icon lucide-save mr-2"><path d="M15.2 3a2 2 0 0 1 1.4.6l3.8 3.8a2 2 0 0 1 .6 1.4V19a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2z"/><path d="M17 21v-7a1 1 0 0 0-1-1H8a1 1 0 0 0-1 1v7"/><path d="M7 3v4a1 1 0 0 0 1 1h7"/></svg>
                                    Guardar
                                </button>
                               </div>
                          </form>
                     </div>
                </div>
           </div>
            
        <script src="js/actualizarUsuarioModal.js"></script>
            
    </div>    
        
        
        
        
    </body>
</html>