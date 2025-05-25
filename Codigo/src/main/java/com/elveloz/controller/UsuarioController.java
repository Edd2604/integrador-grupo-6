package com.elveloz.controller;

import com.elveloz.dao.UsuarioDAO;
import com.elveloz.model.Usuario;
import com.google.gson.Gson;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.List;


@WebServlet(name = "usuarioControlador", urlPatterns = {"/usuarioControlador"})
public class UsuarioController extends HttpServlet {

    private final UsuarioDAO usuarioDAO = new UsuarioDAO();
    
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException { 
        
        String accion = request.getParameter("accion");
        
        switch (accion) {
            case "validarUsuario":
                System.out.println("Validaando Usuario....");
                validarUsuario(request, response);                     
                break;
            
            case "cerrarSesion":
                System.out.println("Cerrando Sesion....");
                cerrarSesion(request, response);                     
                break;
                
            case "agregarUsuario":
                System.out.println("Agregando Usuario...");
                agregarUsuario(request, response);
                break;
                
            case "listarActivos":
                System.out.println("Listando usuarios activos");
                listarUsuariosActivos(request, response);
                break;
                
            case "obtenerUsuario":
                System.out.println("Obteniendo datos de usuario por id");
                obtenerUsuario(request, response);
                break;
                
            case "actualizarUsuario":
                System.out.println("Actualizando datos del usuario");
                actualizarUsuario(request, response);
                break;
                
            case "eliminarUsuario":
                System.out.println("Desactivando usuarios activos");
                eliminarUsuario(request, response);
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
    
    

    public static String md5encryp(String input) {
        String output = "";
        
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] digest = md.digest(input.getBytes());
            StringBuilder sb = new StringBuilder();
            
            for(byte b : digest) {
                sb.append(String.format("%02x",b));
            }
            
            output = sb.toString();
            
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
        
        return output;
    }
    
    private void validarUsuario(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        String encryptedPassword = md5encryp(password);

        Usuario usuarioValidado = usuarioDAO.validarUsuario(username, encryptedPassword);

        if (usuarioValidado != null) {
            if (usuarioValidado.isActivo()) {
                HttpSession session = request.getSession();
                session.setAttribute("usuarioLogueado", usuarioValidado);
                response.sendRedirect("dashboard.jsp");
            } else {
                request.setAttribute("errorLogin", "Este usuario está inactivo. Contacte al administrador.");
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("errorLogin", "Nombre de usuario o contraseña incorrectos.");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }

     private void cerrarSesion(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false); 
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }
    
    private void agregarUsuario(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String password = request.getParameter("password");
        String confirmarPassword = request.getParameter("confirmarPassword");
        String rol = request.getParameter("rol");

        if (password != null && password.equals(confirmarPassword)) {
            String encryptedPassword = md5encryp(password);
            Usuario nuevoUsuario = new Usuario();
            nuevoUsuario.setUsername(username);
            nuevoUsuario.setNombre(nombre);
            nuevoUsuario.setApellido(apellido);
            nuevoUsuario.setPassword_e(encryptedPassword);
            try {
                nuevoUsuario.setId_rol(Integer.parseInt(rol));
            } catch (NumberFormatException e) {
                // Error: Formato de rol inválido
                request.getSession().setAttribute("notificationType", "error"); // Usamos "notificationType"
                request.getSession().setAttribute("notificationMessage", "Formato de rol inválido."); // Usamos "notificationMessage"
                response.sendRedirect(request.getContextPath() + "/usuarioControlador?accion=listarActivos");
                return;
            }
            nuevoUsuario.setActivo(true);

            if (usuarioDAO.agregarUsuario(nuevoUsuario)) {
                // Éxito al agregar usuario
                request.getSession().setAttribute("notificationType", "success"); // Usamos "notificationType"
                request.getSession().setAttribute("notificationMessage", "Usuario '" + username + "' agregado exitosamente.");
                response.sendRedirect(request.getContextPath() + "/usuarioControlador?accion=listarActivos");
            } else {
                // Error al agregar el usuario
                request.getSession().setAttribute("notificationType", "error"); // Usamos "notificationType"
                request.getSession().setAttribute("notificationMessage", "Error al agregar el usuario."); // Usamos "notificationMessage"
                response.sendRedirect(request.getContextPath() + "/usuarioControlador?accion=listarActivos");
            }
        } else {
            // Error: Las contraseñas no coinciden
            System.out.println("Las contraseñas no coinciden"); // Esto es solo para depuración en la consola
            request.getSession().setAttribute("notificationType", "error"); // Usamos "notificationType"
            request.getSession().setAttribute("notificationMessage", "Las contraseñas no coinciden."); // Usamos "notificationMessage"
            response.sendRedirect(request.getContextPath() + "/usuarioControlador?accion=listarActivos");
        }
    }

    protected void listarUsuariosActivos(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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

        UsuarioDAO usuarioDAO = new UsuarioDAO(); // Asegúrate de inicializar tu DAO correctamente
        List<Usuario> usuariosActivos = usuarioDAO.listarUsuariosActivosPaginado(filasPorPagina, offset);
        int totalUsuarios = usuarioDAO.contarUsuariosActivos();
        int totalPaginas = (int) Math.ceil((double) totalUsuarios / filasPorPagina);

        request.setAttribute("usuariosActivos", usuariosActivos);
        request.setAttribute("paginaActual", paginaActual);
        request.setAttribute("totalPaginas", totalPaginas);

        request.getRequestDispatcher("usuario.jsp").forward(request, response);
    }
    
    protected void obtenerUsuario(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idUsuario = Integer.parseInt(request.getParameter("id")); //porque aca es id nada mas
        UsuarioDAO usuarioDAO = new UsuarioDAO();
        Usuario usuario = usuarioDAO.obtenerUsuarioPorId(idUsuario); 

        // Convertir el objeto Usuario a JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        String json = new Gson().toJson(usuario);
        response.getWriter().write(json);
    }
    
    protected void actualizarUsuario(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("id_usuario: " + request.getParameter("id_usuario"));
        System.out.println("username: " + request.getParameter("username"));
        System.out.println("nombre: " + request.getParameter("nombre"));
        System.out.println("apellido: " + request.getParameter("apellido"));
        System.out.println("rol: " + request.getParameter("rol"));

        response.setContentType("text/plain"); // Indicamos que la respuesta será texto plano
        response.setCharacterEncoding("UTF-8");

        try {
            int idUsuario = Integer.parseInt(request.getParameter("id_usuario"));
            String username = request.getParameter("username");
            String nombre = request.getParameter("nombre");
            String apellido = request.getParameter("apellido");

            int idRol = 0; // Valor por defecto si no se proporciona o si el rol es opcional
            String rolParam = request.getParameter("rol");
            if (rolParam != null && !rolParam.trim().isEmpty()) {
                 try {
                     idRol = Integer.parseInt(rolParam);
                 } catch (NumberFormatException e) {
                     // Si el parámetro 'rol' no es un número válido pero no está vacío/nulo
                     throw new NumberFormatException("El valor del ROL no es un número válido: " + rolParam);
                 }
            } else {
                System.out.println("Advertencia: El parámetro 'rol' es nulo, vacío o solo espacios.");
                throw new IllegalArgumentException("El rol del usuario es obligatorio.");            
            }

            Usuario usuario = new Usuario();
            usuario.setId_usuario(idUsuario);
            usuario.setUsername(username);
            usuario.setNombre(nombre);
            usuario.setApellido(apellido);
            usuario.setId_rol(idRol); // Usamos el idRol parseado o por defecto

            UsuarioDAO usuarioDAO = new UsuarioDAO();
            boolean actualizado = usuarioDAO.actualizarUsuario(usuario);

            if (actualizado) {
                System.out.println("Usuario actualizado correctamente (DAO)");
                response.getWriter().write("SUCCESS");

            } else {
                System.out.println("Error al actualizar el usuario en la base de datos (DAO)");
                response.getWriter().write("ERROR: No se pudo actualizar el usuario en la base de datos.");

            }

        } catch (NumberFormatException e) {
            // Si falla el parseInt (id_usuario o rol si ocurrió en el bloque de arriba)
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // Código 400 para error del cliente (bad request)
            response.getWriter().write("ERROR: Datos numéricos inválidos. Verifique el ID de usuario o el ROL. Detalle: " + e.getMessage());
        } catch (IllegalArgumentException e) {
             // Si lanzas una excepción por datos obligatorios faltantes (como el rol si lo haces obligatorio)
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // Código 400
            response.getWriter().write("ERROR: Faltan datos obligatorios para la actualización. Detalle: " + e.getMessage());
        }
        // === MODIFICACIÓN: Capturar otras posibles excepciones inesperadas ===
        catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // Código 500 para error interno del servidor
            response.getWriter().write("ERROR: Ocurrió un error interno del servidor al procesar la solicitud.");
        }

    }

    
    protected void eliminarUsuario(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("id");

        if (idStr != null && !idStr.isEmpty()) {
            try {
                int idUsuario = Integer.parseInt(idStr);
                UsuarioDAO usuarioDAO = new UsuarioDAO();
                boolean desactivado = usuarioDAO.eliminarUsuario(idUsuario, false); // Llamando a tu método para desactivar

                if (desactivado) {
                    request.getSession().setAttribute("notificationType", "success");
                    request.getSession().setAttribute("notificationMessage", "Usuario desactivado exitosamente.");
                } else {
                    request.getSession().setAttribute("notificationType", "error"); 
                    request.getSession().setAttribute("notificationMessage", "No se pudo desactivar el usuario.");
                }       
                response.sendRedirect(request.getContextPath() + "/usuarioControlador?accion=listarActivos&pagina=" + request.getParameter("pagina")); // Mantener la página actual

            } catch (NumberFormatException e) {
                request.getSession().setAttribute("notificationType", "error"); 
                request.getSession().setAttribute("notificationMessage", "ID de usuario inválido.");
                response.sendRedirect(request.getContextPath() + "/usuarioControlador?accion=listarActivos");
            }
        } else {
            request.getSession().setAttribute("notificationType", "error"); 
            request.getSession().setAttribute("notificationMessage", "No se proporcionó el ID del usuario.");
            response.sendRedirect(request.getContextPath() + "/usuarioControlador?accion=listarActivos");
        }
    }
    
}