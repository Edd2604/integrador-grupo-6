
package com.elveloz.controller;

import com.elveloz.dao.PaqueteDAO;
import com.elveloz.model.Paquete;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet(name = "paqueteControlador", urlPatterns = {"/paqueteControlador"})
public class PaqueteController extends HttpServlet {

    private final PaqueteDAO paqueteDAO = new PaqueteDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");
        HttpSession session = request.getSession();
        
        switch (accion) {
            case "agregarPaquete":
                System.out.println("Agregando paquete....");
                agregarPaquete(request, response);                     
                break;
            
            case "listarPaquetes":
                System.out.println("Listando paquetes....");
                listarPaquetes(request, response);                     
                break;  
                
            case "eliminarPaquete":
                System.out.println("Eliminando paquete....");
                eliminarPaquete(request, response, session);
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


    private void agregarPaquete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        try {
            // Obtener los parámetros del formulario
            int id_peticion_envio = Integer.parseInt(request.getParameter("id_peticion_envio"));
            String nombre = request.getParameter("nombre");
            String categoria = request.getParameter("categoria");
            double peso = Double.parseDouble(request.getParameter("peso"));
            int cantidad = Integer.parseInt(request.getParameter("cantidad")); 

            Paquete nuevoPaquete = new Paquete();
            nuevoPaquete.setId_peticion_envio(id_peticion_envio);
            nuevoPaquete.setNombre(nombre);
            nuevoPaquete.setCategoria(categoria);
            nuevoPaquete.setPeso(peso);
            nuevoPaquete.setCantidad(cantidad);
            boolean agregado = paqueteDAO.agregarPaquete(nuevoPaquete);

            if (agregado) {
                session.setAttribute("notificationType", "success");
                session.setAttribute("notificationMessage", "Paquete agregado exitosamente.");
            } else {
                session.setAttribute("notificationType", "error");
                session.setAttribute("notificationMessage", "No se pudo agregar el paquete.");
            }
        } catch (NumberFormatException e) {
            session.setAttribute("notificationType", "error");
            session.setAttribute("notificationMessage", "Datos de paquete inválidos (formato numérico).");
            System.err.println("Error de formato de número al agregar paquete: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            session.setAttribute("notificationType", "error");
            session.setAttribute("notificationMessage", "Error al agregar paquete: " + e.getMessage());
            System.err.println("Error general al agregar paquete: " + e.getMessage());
            e.printStackTrace();
        } finally {
            response.sendRedirect(request.getContextPath() + "/peticionEnvioControlador?accion=mostrarDetallePeticion&id_peticion=" + request.getParameter("id_peticion_envio"));
        }
    }
    
    private void listarPaquetes(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String id_peticion_envio_str = request.getParameter("id_peticion_envio");

        if (id_peticion_envio_str == null || id_peticion_envio_str.isEmpty()) {
            session.setAttribute("notificationType", "error");
            session.setAttribute("notificationMessage", "ID de Petición de Envío no especificado para listar paquetes.");
            response.sendRedirect(request.getContextPath() + "/peticionEnvioControlador?accion=listarPeticiones"); // Redirige a una lista general de peticiones
            return;
        }

        try {
            int id_peticion_envio = Integer.parseInt(id_peticion_envio_str);
            
            List<Paquete> paquetes = paqueteDAO.listarPaquetesPorPeticionEnvio(id_peticion_envio);
            
            // Poner la lista de paquetes en el ámbito del request para que el JSP la use
            request.setAttribute("paquetes", paquetes);
            
            // Opcional: Si necesitas los detalles de la petición de envío para el JSP
            // También deberías obtener la petición de envío aquí y ponerla en el request
            // PeticionEnvioDAO peticionEnvioDAO = new PeticionEnvioDAO(); // Tendrías que instanciarlo o tenerlo como atributo
            // PeticionEnvio peticion = peticionEnvioDAO.obtenerPeticionEnvioPorId(id_peticion_envio);
            // request.setAttribute("peticion", peticion);

            // Redirigir al JSP donde se mostrarán los detalles y la lista de paquetes
            // Por ejemplo, si tienes un JSP llamado 'detallePeticionEnvio.jsp'
            request.getRequestDispatcher("/peticionEnvioAgregado.jsp").forward(request, response);
            // Asegúrate de que esta ruta sea la correcta para tu JSP
            // Nota: Aquí se usa forward, no sendRedirect, porque necesitamos que la JSP tenga acceso a los atributos del request.

        } catch (NumberFormatException e) {
            session.setAttribute("notificationType", "error");
            session.setAttribute("notificationMessage", "Formato de ID de Petición de Envío inválido.");
            System.err.println("Error de formato de ID al listar paquetes: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/peticionEnvioControlador?accion=listarPeticiones");
        } catch (Exception e) {
            session.setAttribute("notificationType", "error");
            session.setAttribute("notificationMessage", "Ocurrió un error al listar los paquetes.");
            System.err.println("Error inesperado al listar paquetes: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/peticionEnvioControlador?accion=listarPeticiones");
        }
    }
    
    private void eliminarPaquete(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {

        String idPaqueteStr = request.getParameter("id");
        String idPeticionEnvioStr = request.getParameter("idPeticion"); // Nombre exacto que pasas en el JSP: idPeticion

        if (idPaqueteStr == null || idPeticionEnvioStr == null || idPaqueteStr.isEmpty() || idPeticionEnvioStr.isEmpty()) {
            session.setAttribute("notificationType", "error");
            session.setAttribute("notificationMessage", "Parámetros de eliminación incompletos.");
            response.sendRedirect(request.getContextPath() + "/dashboard.jsp"); // Redirige a una página segura
            return;
        }

        try {
            int idPaquete = Integer.parseInt(idPaqueteStr);
            int idPeticionEnvio = Integer.parseInt(idPeticionEnvioStr); // ID de la petición de envío

            boolean eliminado = paqueteDAO.eliminarPaquete(idPaquete);

            if (eliminado) {
                session.setAttribute("notificationType", "success");
                session.setAttribute("notificationMessage", "Paquete eliminado exitosamente.");
            } else {
                session.setAttribute("notificationType", "error");
                session.setAttribute("notificationMessage", "No se pudo eliminar el paquete. Puede que no exista.");
            }

            // Redirigir de vuelta a la página de detalle de la PeticiónEnvio
            // Usamos PeticionEnvioControlador para volver a cargar la vista con el listado actualizado
            response.sendRedirect(request.getContextPath() + "/peticionEnvioControlador?accion=mostrarDetallePeticion&id_peticion=" + idPeticionEnvio);

        } catch (NumberFormatException e) {
            session.setAttribute("notificationType", "error");
            session.setAttribute("notificationMessage", "ID de paquete o ID de petición inválido.");
            response.sendRedirect(request.getContextPath() + "/dashboard.jsp"); // Redirige a una página segura
        } catch (Exception e) {
            System.err.println("Error al eliminar paquete: " + e.getMessage());
            e.printStackTrace();
            session.setAttribute("notificationType", "error");
            session.setAttribute("notificationMessage", "Ocurrió un error al intentar eliminar el paquete.");
            response.sendRedirect(request.getContextPath() + "/dashboard.jsp"); // Redirige a una página segura
        }
    }

}
