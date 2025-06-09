
package com.elveloz.controller;

import com.elveloz.dao.ClienteDAO;
import com.elveloz.model.Cliente;
import com.google.gson.Gson;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;


@WebServlet(name = "extranjeroControlador", urlPatterns = {"/extranjeroControlador"})
public class ExtranjeroController extends HttpServlet {

    private final ClienteDAO clienteDAO = new ClienteDAO();
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");
        
        switch (accion) {   
            case "agregarClienteExtranjero":
                System.out.println("Agregando Cliente...");
                agregarClienteExtranjero(request, response);
                break;
                
            case "listarClientesExtranjeros":
                System.out.println("Listando Clientes Extranjeros");
                listarClientesExtranjeros(request, response);
                break;
            
            case "obtenerCliente":
                System.out.println("Obteniendo datos de cliente por id");
                obtenerCliente(request, response);
                break;
                
            case "actualizarCliente":
                System.out.println("Actualizando datos del cliente Nacional");
                actualizarCliente(request, response);
                break;     
                
            case "eliminarCliente":
                System.out.println("Desactivando Cliente activo");
                eliminarCliente(request, response);
                break; 
                
            case "listarClienteExtranjeroCbx":
                    listarClienteExtranjeroCbx(request, response);
                    break;
                
            default:
                request.setAttribute("error", "Acción no válida.");
                request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    private void agregarClienteExtranjero(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String email = request.getParameter("email");
        String telefono = request.getParameter("telefono");
        String nacionalidad = request.getParameter("nacionalidad");
        String tipoDocumento = request.getParameter("tipo_documento");
        String numeroDocumento = request.getParameter("numero_documento");


        Cliente nuevoCliente = new Cliente();
        nuevoCliente.setNombre(nombre);
        nuevoCliente.setApellido(apellido);
        nuevoCliente.setEmail(email);
        nuevoCliente.setTelefono(telefono);
        nuevoCliente.setNacionalidad(nacionalidad);
        nuevoCliente.setTipo_documento(tipoDocumento);
        nuevoCliente.setNumero_documento(numeroDocumento);
        nuevoCliente.setId_rol_cliente(2); 
        nuevoCliente.setActivo(true); 

        if (clienteDAO.agregarCliente(nuevoCliente)) {
            // Éxito al agregar cliente
            request.getSession().setAttribute("notificationType", "success");
            request.getSession().setAttribute("notificationMessage", "Cliente '" + nombre + " " + apellido + "' agregado exitosamente.");
            response.sendRedirect(request.getContextPath() + "/extranjeroControlador?accion=listarClientesExtranjeros"); 
        } else {
            // Error al agregar el cliente (posiblemente por un error en la BD o un dato inesperado)
            request.getSession().setAttribute("notificationType", "error");
            request.getSession().setAttribute("notificationMessage", "Error al agregar el cliente. Intente nuevamente.");
            response.sendRedirect(request.getContextPath() + "/extranjeroControlador?accion=listarClientesExtranjeros"); 
        }
    }
    
    private void listarClientesExtranjeros(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idRolCliente = 2; 
        
        int filasPorPagina = 10;
        String paginaStr = request.getParameter("pagina");
        int paginaActual = 1;
        if (paginaStr != null && !paginaStr.isEmpty()) {
            try {
                paginaActual = Integer.parseInt(paginaStr);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        int offset = (paginaActual - 1) * filasPorPagina;

        List<Cliente> clientesNacionales = clienteDAO.listarClientesPaginadoPorRol(idRolCliente, filasPorPagina, offset);
        int totalClientesNacionales = clienteDAO.contarClientesPorRol(idRolCliente);
        int totalPaginas = (int) Math.ceil((double) totalClientesNacionales / filasPorPagina);

        request.setAttribute("clientes", clientesNacionales); 
        request.setAttribute("paginaActual", paginaActual);
        request.setAttribute("totalPaginas", totalPaginas);

        // Envía a la JSP que mostrará la tabla de clientes nacionales (puedes crear una específica o reutilizar)
        request.getRequestDispatcher("/extranjero.jsp").forward(request, response);
    
     }
    
    protected void obtenerCliente(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("ERROR: ID de cliente no proporcionado.");
            return;
        }

        try {
            int idCliente = Integer.parseInt(idStr);
            Cliente cliente = clienteDAO.obtenerClientePorId(idCliente);

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            if (cliente != null) {
                String json = new Gson().toJson(cliente);
                response.getWriter().write(json);
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND); // Código 404 si el cliente no se encuentra
                response.getWriter().write("ERROR: Cliente no encontrado.");
            }
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("ERROR: ID de cliente inválido.");
            e.printStackTrace();
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("ERROR: Ocurrió un error al obtener el cliente.");
            e.printStackTrace();
        }
    }

    protected void actualizarCliente(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");

        try {
            int idCliente = Integer.parseInt(request.getParameter("id_cliente"));
            String nombre = request.getParameter("nombre");
            String apellido = request.getParameter("apellido");
            String email = request.getParameter("email");
            String telefono = request.getParameter("telefono");
            String nacionalidad = request.getParameter("nacionalidad");
            String tipoDocumento = request.getParameter("tipo_documento");
            String numeroDocumento = request.getParameter("numero_documento");

            // Validaciones básicas (puedes expandirlas)
            if (nombre == null || nombre.trim().isEmpty() ||
                apellido == null || apellido.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                telefono == null || telefono.trim().isEmpty() ||
                nacionalidad == null || nacionalidad.trim().isEmpty() ||
                tipoDocumento == null || tipoDocumento.trim().isEmpty() ||
                numeroDocumento == null || numeroDocumento.trim().isEmpty()) {
                throw new IllegalArgumentException("Todos los campos obligatorios deben ser completados.");
            }

            Cliente cliente = new Cliente();
            cliente.setId_cliente(idCliente);
            cliente.setNombre(nombre);
            cliente.setApellido(apellido);
            cliente.setEmail(email);
            cliente.setTelefono(telefono);
            cliente.setNacionalidad(nacionalidad);
            cliente.setTipo_documento(tipoDocumento);
            cliente.setNumero_documento(numeroDocumento);

            boolean actualizado = clienteDAO.actualizarCliente(cliente);

            if (actualizado) {
                System.out.println("Cliente ID " + idCliente + " actualizado correctamente (Servlet).");
                response.getWriter().write("SUCCESS");
            } else {
                System.err.println("Error al actualizar cliente ID " + idCliente + " en la base de datos (Servlet).");
                response.getWriter().write("ERROR: No se pudo actualizar el cliente.");
            }

        } catch (NumberFormatException e) {
            System.err.println("Error de formato numérico al actualizar cliente: " + e.getMessage());
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("ERROR: ID de cliente inválido.");
        } catch (IllegalArgumentException e) {
            System.err.println("Error de validación al actualizar cliente: " + e.getMessage());
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("ERROR: " + e.getMessage());
        } catch (Exception e) {
            System.err.println("Error inesperado al actualizar cliente: " + e.getMessage());
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("ERROR: Ocurrió un error interno del servidor al procesar la solicitud.");
            e.printStackTrace();
        }
    }
    
    protected void eliminarCliente(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("id");
        String paginaActualStr = request.getParameter("pagina");

        if (idStr != null && !idStr.isEmpty()) {
            try {
                int idCliente = Integer.parseInt(idStr);
                
                // Llamamos al método eliminarCliente del DAO, pasándole el ID y 'false' para desactivar
                boolean desactivado = clienteDAO.eliminarCliente(idCliente, false); 

                if (desactivado) {
                    request.getSession().setAttribute("notificationType", "success");
                    request.getSession().setAttribute("notificationMessage", "Cliente desactivado exitosamente.");
                } else {
                    request.getSession().setAttribute("notificationType", "error");
                    request.getSession().setAttribute("notificationMessage", "No se pudo desactivar el cliente.");
                }
                
                response.sendRedirect(request.getContextPath() + "/extranjeroControlador?accion=listarClientesExtranjeros" + (paginaActualStr != null ? "&pagina=" + paginaActualStr : "")); 

            } catch (NumberFormatException e) {
                request.getSession().setAttribute("notificationType", "error");
                request.getSession().setAttribute("notificationMessage", "ID de cliente inválido.");
                response.sendRedirect(request.getContextPath() + "/extranjeroControlador?accion=listarClientesExtranjeros"); 
            }
        } else {
            request.getSession().setAttribute("notificationType", "error");
            request.getSession().setAttribute("notificationMessage", "No se proporcionó el ID del cliente.");
            response.sendRedirect(request.getContextPath() + "/extranjeroControlador?accion=listarClientesExtranjeros"); 
        }
    }
    
    private void listarClienteExtranjeroCbx(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
    }

    
}
