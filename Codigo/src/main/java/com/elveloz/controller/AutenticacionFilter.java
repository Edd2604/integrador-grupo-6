package com.elveloz.controller;

import com.elveloz.model.Usuario;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(urlPatterns = {"/home.jsp", "/registroUsuario.jsp"})
public class AutenticacionFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Inicialización del filtro (opcional)
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        boolean usuarioLogueado = (session != null && session.getAttribute("usuarioLogueado") != null);
        String requestURI = httpRequest.getRequestURI();
        boolean paginaDeLogin = requestURI.endsWith("index.jsp");
        boolean esRecursoEstatico = requestURI.startsWith(httpRequest.getContextPath() + "/static/");

        if (paginaDeLogin || esRecursoEstatico) {
            chain.doFilter(request, response);
            return;
        }

        if (usuarioLogueado) {
            Usuario usuario = (Usuario) session.getAttribute("usuarioLogueado");
            int idRolUsuario = usuario.getId_rol();

            if (requestURI.endsWith("registroUsuario.jsp") || requestURI.endsWith("modificarUsuario.jsp")) {
                // Acceso restringido solo a administradores (rol ID 1)
                if (idRolUsuario == 1) {
                    chain.doFilter(request, response); // El admin tiene acceso
                } else {
                    httpResponse.sendRedirect(httpRequest.getContextPath() + "/accesoDenegado.jsp");
                }
            } else {
                // Acceso permitido a todos los usuarios logueados (tanto admin como usuarios normales - rol ID 2) para otras páginas (como home.jsp)
                chain.doFilter(request, response);
            }
        } else {
            // Usuario no logueado, redirige a la página de login
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/index.jsp");
        }
    }

    @Override
    public void destroy() {
        // Limpieza del filtro (opcional)
    }
}