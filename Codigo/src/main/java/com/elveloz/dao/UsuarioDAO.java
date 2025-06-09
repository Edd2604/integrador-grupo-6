package com.elveloz.dao;

import com.elveloz.config.Conexion;
import com.elveloz.model.Usuario;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDAO {

    private Connection con;
    private final Conexion c = new Conexion();
    private PreparedStatement ps;
    private ResultSet rs;

    public UsuarioDAO() {
        this.con = c.getConnection();
    }
    
    public Usuario validarUsuario(String username, String password) {
        Usuario usuario = null;
        try {
            String sql = "SELECT id_usuario, username, password_e, id_rol, activo, nombre, apellido FROM usuarios WHERE username = ? AND password_e = ?";
            ps = con.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);

            rs = ps.executeQuery();

            if (rs.next()) {
                usuario = new Usuario();
                usuario.setId_usuario(rs.getInt("id_usuario"));
                usuario.setUsername(rs.getString("username"));
                usuario.setPassword_e(rs.getString("password_e"));
                usuario.setId_rol(rs.getInt("id_rol"));
                usuario.setActivo(rs.getBoolean("activo"));
                usuario.setNombre(rs.getString("nombre"));
                usuario.setApellido(rs.getString("apellido"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error al validar usuario en la base de datos: " + e.getMessage());
        } finally {
            DAOUtil.cerrarRecursos(rs, ps);
        }
        return usuario;
    }
    
    public boolean agregarUsuario(Usuario usuario) {
        boolean agregado = false;
        try {
            String sql = "INSERT INTO usuarios (username, nombre, apellido, password_e, id_rol, activo) VALUES (?, ?, ?, ?, ?, ?)";
            ps = con.prepareStatement(sql);
            ps.setString(1, usuario.getUsername());
            ps.setString(2, usuario.getNombre());
            ps.setString(3, usuario.getApellido());
            ps.setString(4, usuario.getPassword_e());
            ps.setInt(5, usuario.getId_rol());
            ps.setBoolean(6, usuario.isActivo());
            int filasAfectadas = ps.executeUpdate();
            if (filasAfectadas > 0) {
                agregado = true;
                System.out.println("Se agrego correctamente el usuario");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DAOUtil.cerrarRecursos(ps);
        }
        return agregado;
    }
    
   public List<Usuario> listarUsuariosActivosPaginado(int limit, int offset) {
        List<Usuario> usuarios = new ArrayList<>();
        String sql = "SELECT id_usuario, username, nombre, apellido, id_rol FROM usuarios WHERE activo = true ORDER BY id_usuario DESC LIMIT ? OFFSET ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, limit);
            ps.setInt(2, offset);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Usuario usuario = new Usuario();
                usuario.setId_usuario(rs.getInt("id_usuario")); // ¡Asegúrate de tener este setter en tu clase Usuario!
                usuario.setUsername(rs.getString("username"));
                usuario.setNombre(rs.getString("nombre"));
                usuario.setApellido(rs.getString("apellido"));
                usuario.setId_rol(rs.getInt("id_rol"));
                usuarios.add(usuario);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return usuarios;
    }
   
    public int contarUsuariosActivos() {
        int total = 0;
        String sql = "SELECT COUNT(*) FROM usuarios WHERE activo = true";
        try (PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        System.out.println("Nunmero de filas: " + total);
        return total;
    }

    public Usuario obtenerUsuarioPorId(int id) {
        Usuario usuario = null;
        String sql = "SELECT id_usuario, username, nombre, apellido, id_rol FROM usuarios WHERE id_usuario = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                usuario = new Usuario();
                usuario.setId_usuario(rs.getInt("id_usuario"));
                usuario.setUsername(rs.getString("username"));
                usuario.setNombre(rs.getString("nombre"));
                usuario.setApellido(rs.getString("apellido"));
                usuario.setId_rol(rs.getInt("id_rol"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return usuario;
    }

    public boolean actualizarUsuario(Usuario usuario) {
        System.out.println("Actualizando usuario con ID: " + usuario.getId_usuario());
        System.out.println("Rol: " + usuario.getId_rol());
        
        boolean actualizado = false;
        try {
            String sql = "UPDATE usuarios SET username = ?, nombre = ?, apellido = ?, id_rol = ? WHERE id_usuario = ?";
            ps = con.prepareStatement(sql);
            ps.setString(1, usuario.getUsername());
            ps.setString(2, usuario.getNombre());
            ps.setString(3, usuario.getApellido());
            ps.setInt(4, usuario.getId_rol());
            ps.setInt(5, usuario.getId_usuario());
            int filasAfectadas = ps.executeUpdate();
            if (filasAfectadas > 0) {
                actualizado = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DAOUtil.cerrarRecursos(ps);
        }
        return actualizado;
    }

    public boolean eliminarUsuario(int id, boolean activo) {
        boolean actualizado = false;
        try {
            String sql = "UPDATE usuarios SET activo = ? WHERE id_usuario = ?";
            ps = con.prepareStatement(sql);
            ps.setBoolean(1, activo);
            ps.setInt(2, id);
            int filasAfectadas = ps.executeUpdate();
            if (filasAfectadas > 0) {
                actualizado = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DAOUtil.cerrarRecursos(ps);
        }
        return actualizado;
    }


    
}