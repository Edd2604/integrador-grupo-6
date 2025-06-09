
package com.elveloz.controller;

import com.elveloz.dao.ClienteDAO;
import com.elveloz.dao.PaqueteDAO;
import com.elveloz.dao.PeticionEnvioDAO;
import com.elveloz.model.Cliente;
import com.elveloz.model.PeticionEnvio;
import com.elveloz.model.Usuario;
import com.elveloz.model.Paquete;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.util.List;
import java.util.Date;



@WebServlet(name = "peticionEnvioControlador", urlPatterns = {"/peticionEnvioControlador"})
public class PeticionEnvioController extends HttpServlet {

    private final ClienteDAO clienteDAO = new ClienteDAO();
    private final PeticionEnvioDAO peticionEnvioDAO = new PeticionEnvioDAO();
    private final PaqueteDAO paqueteDAO = new PaqueteDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        
         switch (accion) {               
            case "listarClientesCombobox":
                System.out.println("Listando Clientes en las combobox");
                cargarComboBoxesPeticionEnvio(request, response);
                break;
            
            case "agregarPeticionEnvio":
                System.out.println("Procesando nueva Petición de Envío...");
                agregarPeticionEnvio(request, response, peticionEnvioDAO);
                break;
                
            case "mostrarDetallePeticion":
                System.out.println("Mostrando Petición de Envío...");
                mostrarDetallePeticion(request, response, peticionEnvioDAO);
                break;
            
            case "actualizarDetallePeticion":
                actualizarDetallePeticion(request, response);
                break;
                
            case "eliminarPeticion":
                eliminarPeticion(request, response);
                break;
                
            case "listarPeticiones":
                listarPeticiones(request, response);
                break;
                
            case "verPaquetes":
                verPaquetesPorPeticion(request, response); // Pasa peticionEnvioDAO como parámetro
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

    private void cargarComboBoxesPeticionEnvio(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            final int ROL_NACIONAL = 1; // ID de rol para clientes nacionales
            final int ROL_EXTRANJERO = 2; // ID de rol para clientes extranjeros

            // Obtener lista de clientes nacionales activos para el combobox
            List<Cliente> clientesNacionales = clienteDAO.listarClientesActivosParaComboBox(ROL_NACIONAL);
            request.setAttribute("clientesNacionales", clientesNacionales);
            System.out.println("Cargados " + clientesNacionales.size() + " clientes nacionales para el combobox.");

            // Obtener lista de clientes extranjeros activos para el combobox
            List<Cliente> clientesExtranjeros = clienteDAO.listarClientesActivosParaComboBox(ROL_EXTRANJERO);
            request.setAttribute("clientesExtranjeros", clientesExtranjeros);
            System.out.println("Cargados " + clientesExtranjeros.size() + " clientes extranjeros para el combobox.");

            // Envía al JSP del formulario de Petición de Envío
            // ASEGÚRATE DE QUE ESTA RUTA SEA LA CORRECTA A TU ARCHIVO .jsp
            RequestDispatcher dispatcher = request.getRequestDispatcher("/peticionEnvio.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            System.err.println("Error en cargarComboBoxesPeticionEnvio: " + e.getMessage());
            e.printStackTrace();
            // Re-lanzar la excepción para que sea capturada por el bloque try-catch superior
            throw new ServletException("Error al cargar datos de clientes para los comboboxes de petición de envío.", e);
        }
    }
    
     private void agregarPeticionEnvio(HttpServletRequest request, HttpServletResponse response, PeticionEnvioDAO peticionEnvioDAO)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Integer idUsuarioLogeado = null;

        if (session != null) {
            Usuario usuarioLogeado = (Usuario) session.getAttribute("usuarioLogueado");
            if (usuarioLogeado != null) {
                idUsuarioLogeado = usuarioLogeado.getId_usuario();
            }
        }

        if (idUsuarioLogeado == null) {
            request.getSession().setAttribute("notificationType", "error");
            request.getSession().setAttribute("notificationMessage", "Debe iniciar sesión para crear una petición de envío.");
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        String idClienteNacionalStr = request.getParameter("id_cliente_nacional");
        String idClienteExtranjeroStr = request.getParameter("id_cliente_extranjero");
        String tipoEnvio = request.getParameter("tipo_envio");
        String paisEnvio = request.getParameter("pais_envio");

        int idClienteNacional = 0;
        if (idClienteNacionalStr != null && !idClienteNacionalStr.isEmpty()) {
            try {
                idClienteNacional = Integer.parseInt(idClienteNacionalStr);
            } catch (NumberFormatException e) {
                request.getSession().setAttribute("notificationType", "error");
                request.getSession().setAttribute("notificationMessage", "Cliente Nacional inválido.");
                response.sendRedirect(request.getContextPath() + "/peticionEnvioControlador?accion=mostrarFormularioPeticion");
                return;
            }
        }

        int idClienteExtranjero = 0;
        if (idClienteExtranjeroStr != null && !idClienteExtranjeroStr.isEmpty()) {
            try {
                idClienteExtranjero = Integer.parseInt(idClienteExtranjeroStr);
            } catch (NumberFormatException e) {
                request.getSession().setAttribute("notificationType", "error");
                request.getSession().setAttribute("notificationMessage", "Cliente Extranjero inválido.");
                response.sendRedirect(request.getContextPath() + "/peticionEnvioControlador?accion=mostrarFormularioPeticion");
                return;
            }
        }

        if (idClienteNacional == 0 && idClienteExtranjero == 0) {
            request.getSession().setAttribute("notificationType", "error");
            request.getSession().setAttribute("notificationMessage", "Debe seleccionar un cliente nacional o un cliente extranjero.");
            response.sendRedirect(request.getContextPath() + "/peticionEnvioControlador?accion=mostrarFormularioPeticion");
            return;
        }

        PeticionEnvio nuevaPeticion = new PeticionEnvio();
        nuevaPeticion.setId_cliente_nacional(idClienteNacional);
        nuevaPeticion.setId_cliente_extranjero(idClienteExtranjero);
        nuevaPeticion.setTipo_envio(tipoEnvio);
        nuevaPeticion.setPais_envio(paisEnvio);
        nuevaPeticion.setId_usuario(idUsuarioLogeado);
        nuevaPeticion.setFecha_creacion(new Timestamp(System.currentTimeMillis()));

        try {
            int idNuevaPeticion = peticionEnvioDAO.agregarPeticionEnvio(nuevaPeticion);

            if (idNuevaPeticion != -1) {
                request.getSession().setAttribute("notificationType", "success");
                request.getSession().setAttribute("notificationMessage", "Petición de envío creada. Agregue detalles.");
                response.sendRedirect(request.getContextPath() + "/peticionEnvioControlador?accion=mostrarDetallePeticion&id_peticion=" + idNuevaPeticion);
            } else {
                request.getSession().setAttribute("notificationType", "error");
                request.getSession().setAttribute("notificationMessage", "Error al guardar la petición de envío en la base de datos.");
                response.sendRedirect(request.getContextPath() + "/peticionEnvioControlador?accion=mostrarFormularioPeticion");
            }
        } catch (Exception e) {
            System.err.println("Error al agregar PeticionEnvio en el controlador: " + e.getMessage());
            e.printStackTrace();
            request.getSession().setAttribute("notificationType", "error");
            request.getSession().setAttribute("notificationMessage", "Error interno al procesar la petición de envío.");
            response.sendRedirect(request.getContextPath() + "/peticionEnvioControlador?accion=mostrarFormularioPeticion");
        }
    }

     private void mostrarDetallePeticion(HttpServletRequest request, HttpServletResponse response, PeticionEnvioDAO peticionEnvioDAO)
            throws ServletException, IOException {
        
        String id_peticion_str = request.getParameter("id_peticion");
        if (id_peticion_str == null || id_peticion_str.isEmpty()) {
            request.getSession().setAttribute("notificationType", "error");
            request.getSession().setAttribute("notificationMessage", "ID de petición no especificado.");
            response.sendRedirect(request.getContextPath() + "/dashboard.jsp");
            return;
        }

        try {
            int id_peticion = Integer.parseInt(id_peticion_str);
            PeticionEnvio peticion = peticionEnvioDAO.obtenerPeticionEnvioPorId(id_peticion);

            if (peticion != null) {
                request.setAttribute("peticion", peticion);

                String nombreClienteNacional = "";
                if (peticion.getId_cliente_nacional() != 0) {
                    nombreClienteNacional = peticionEnvioDAO.obtenerNombreCompletoCliente(peticion.getId_cliente_nacional());
                }
                request.setAttribute("nombreClienteNacional", nombreClienteNacional);

                String nombreClienteExtranjero = "";
                if (peticion.getId_cliente_extranjero() != 0) {
                    nombreClienteExtranjero = peticionEnvioDAO.obtenerNombreCompletoCliente(peticion.getId_cliente_extranjero());
                }
                request.setAttribute("nombreClienteExtranjero", nombreClienteExtranjero);

                // --- Obtener y listar paquetes ---
                List<Paquete> paquetes = paqueteDAO.listarPaquetesPorPeticionEnvio(id_peticion);
                request.setAttribute("paquetes", paquetes); // Pone la lista en el request

                // --- NUEVO: Calcular totales de los paquetes ---
                double totalPesoPaquetes = 0.0;
                //double totalCostoPaquetes = 0.0; // Para la suma de costo_por_peso de todos los paquetes
                int cantidadTotalPaquetes = 0;   // Cantidad de *registros* de paquetes

                if (paquetes != null && !paquetes.isEmpty()) {
                    cantidadTotalPaquetes = paquetes.size(); // Cantidad de registros de paquetes
                    for (Paquete pkg : paquetes) {
                        totalPesoPaquetes += pkg.getPeso();
                    }
                }
                
                // Establecer los totales en el request para que el JSP pueda acceder a ellos
                request.setAttribute("totalPesoPaquetes", totalPesoPaquetes);
                request.setAttribute("cantidadTotalPaquetes", cantidadTotalPaquetes); // Nombre claro para la cantidad de registros

                // --- FIN NUEVO ---

                RequestDispatcher dispatcher = request.getRequestDispatcher("/peticionEnvioAgregado.jsp");
                dispatcher.forward(request, response);
            } else {
                request.getSession().setAttribute("notificationType", "error");
                request.getSession().setAttribute("notificationMessage", "Petición de envío no encontrada.");
                response.sendRedirect(request.getContextPath() + "/dashboard.jsp");
            }
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("notificationType", "error");
            request.getSession().setAttribute("notificationMessage", "ID de petición inválido.");
            response.sendRedirect(request.getContextPath() + "/dashboard.jsp");
        } catch (Exception e) {
            System.err.println("Error al mostrar detalle de PeticionEnvio: " + e.getMessage());
            e.printStackTrace();
            request.getSession().setAttribute("notificationType", "error");
            request.getSession().setAttribute("notificationMessage", "Error al cargar los detalles de la petición.");
            response.sendRedirect(request.getContextPath() + "/dashboard.jsp");
        }
    }
     
    private void actualizarDetallePeticion(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        try {
            // Obtener el ID de la petición (viene del campo oculto y es requerido para la actualización)
            int id_peticion_envio = Integer.parseInt(request.getParameter("id_peticion_envio"));

            // Obtener los datos editables del formulario
            double peso_total = Double.parseDouble(request.getParameter("peso_total"));
            double precio_total = Double.parseDouble(request.getParameter("precio_total"));
            int cantidad_paquetes = Integer.parseInt(request.getParameter("cantidad_paquetes"));

            // Crear un objeto PeticionEnvio con los datos a actualizar
            PeticionEnvio peticionAActualizar = new PeticionEnvio();
            peticionAActualizar.setId_peticion_envio(id_peticion_envio);
            peticionAActualizar.setPeso_total(peso_total);
            peticionAActualizar.setPrecio_total(precio_total);
            peticionAActualizar.setCantidad_paquetes(cantidad_paquetes);

            // Llamar al DAO para realizar la actualización
            boolean actualizado = peticionEnvioDAO.actualizarPeticionEnvio(peticionAActualizar);

            if (actualizado) {
                session.setAttribute("notificationType", "success");
                session.setAttribute("notificationMessage", "Petición de envío actualizada exitosamente.");
            } else {
                session.setAttribute("notificationType", "error");
                session.setAttribute("notificationMessage", "Error al actualizar la petición de envío.");
            }

            // Redirigir de nuevo a la página de detalle para ver los cambios
            response.sendRedirect(request.getContextPath() + "/peticionEnvioControlador?accion=listarClientesCombobox");

        } catch (NumberFormatException e) {
            session.setAttribute("notificationType", "error");
            session.setAttribute("notificationMessage", "Error de formato en los datos (ID, peso o cantidad).");
            System.err.println("Error de formato al actualizar PeticionEnvio: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/peticionEnvioControlador?accion=listarClientesCombobox"); // Redirige a la lista si hay un error grave
        } catch (Exception e) {
            session.setAttribute("notificationType", "error");
            session.setAttribute("notificationMessage", "Ocurrió un error inesperado al actualizar la petición.");
            System.err.println("Error al actualizar PeticionEnvio en Controller: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/peticionEnvioControlador?accion=listarClientesCombobox"); // Redirige a la lista
        }
    }
    
    private void eliminarPeticion(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {       
        String idParam = request.getParameter("id_peticion_envio");
        HttpSession session = request.getSession();

        if (idParam != null && !idParam.isEmpty()) {
            try {
                int id = Integer.parseInt(idParam);
                boolean eliminada = peticionEnvioDAO.eliminarPeticionEnvio(id);

                if (eliminada) {
                    session.setAttribute("notificationType", "success");
                    session.setAttribute("notificationMessage", "Petición de envío cancelada exitosamente.");
                    response.sendRedirect(request.getContextPath() + "/peticionEnvioControlador?accion=listarClientesCombobox");
                } else {
                    session.setAttribute("notificationType", "error");
                    session.setAttribute("notificationMessage", "No se pudo eliminar la petición de envío.");
                    System.err.println("No se pudo eliminar la petición con ID: " + id);
                    response.sendRedirect(request.getContextPath() + "/peticionEnvioControlador?accion=mostrarDetallePeticion&id_peticion_envio=" + id);
                }
            } catch (NumberFormatException e) {
                session.setAttribute("notificationType", "error");
                session.setAttribute("notificationMessage", "ID de petición inválido para eliminación.");
                System.err.println("ID de petición inválido para eliminación: " + idParam);
                response.sendRedirect(request.getContextPath() + "/peticionEnvioControlador?accion=listarClientesCombobox");
            }
        } else {
            session.setAttribute("notificationType", "error");
            session.setAttribute("notificationMessage", "ID de petición no proporcionado para la eliminación.");
            System.err.println("ID de petición no proporcionado para la eliminación.");
            response.sendRedirect(request.getContextPath() + "/peticionEnvioControlador?accion=listarClientesCombobox");
        }
    }

    private void listarPeticiones(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<PeticionEnvio> peticiones = peticionEnvioDAO.listarTodasPeticionesEnvioConDetalles();
            request.setAttribute("peticionesList", peticiones); // Nombre para la lista en el JSP

            RequestDispatcher dispatcher = request.getRequestDispatcher("/verPeticionEnvio.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            System.err.println("Error al listar peticiones de envío: " + e.getMessage());
            e.printStackTrace();
            // Puedes añadir un mensaje de error a la sesión para mostrarlo al usuario
            request.getSession().setAttribute("notificationType", "error");
            request.getSession().setAttribute("notificationMessage", "Error al cargar el listado de peticiones.");
            response.sendRedirect(request.getContextPath() + "/dashboard.jsp"); // Redirige a una página segura
        }
    }
    
    private void verPaquetesPorPeticion(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id_peticion_str = request.getParameter("id_peticion");
        if (id_peticion_str == null || id_peticion_str.isEmpty()) {
            request.getSession().setAttribute("notificationType", "error");
            request.getSession().setAttribute("notificationMessage", "ID de petición no especificado para ver paquetes.");
            response.sendRedirect(request.getContextPath() + "/dashboard.jsp");
            return;
        }

        try {
            int id_peticion = Integer.parseInt(id_peticion_str);

            // Obtener la petición de envío (para mostrar el tipo de envío y otros datos de la cabecera)
            PeticionEnvio peticion = peticionEnvioDAO.obtenerPeticionEnvioPorId(id_peticion);

            if (peticion != null) {
                request.setAttribute("peticion", peticion); // Pasa la petición completa

                // --- Obtener y listar paquetes para esta petición ---
                List<Paquete> paquetes = paqueteDAO.listarPaquetesPorPeticionEnvio(id_peticion);
                request.setAttribute("paquetes", paquetes); // Pone la lista de paquetes en el request

                // Redirigir al JSP específico para ver los paquetes por petición
                RequestDispatcher dispatcher = request.getRequestDispatcher("/verPaquetePorPeticion.jsp");
                dispatcher.forward(request, response);
            } else {
                request.getSession().setAttribute("notificationType", "error");
                request.getSession().setAttribute("notificationMessage", "Petición de envío no encontrada para ver paquetes.");
                response.sendRedirect(request.getContextPath() + "/dashboard.jsp");
            }
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("notificationType", "error");
            request.getSession().setAttribute("notificationMessage", "ID de petición inválido para ver paquetes.");
            response.sendRedirect(request.getContextPath() + "/dashboard.jsp");
        } catch (Exception e) {
            System.err.println("Error al ver paquetes por PeticionEnvio: " + e.getMessage());
            e.printStackTrace();
            request.getSession().setAttribute("notificationType", "error");
            request.getSession().setAttribute("notificationMessage", "Error al cargar los paquetes de la petición.");
            response.sendRedirect(request.getContextPath() + "/dashboard.jsp");
        }
    }

    
}
