
package com.elveloz.dao;

import com.elveloz.config.Conexion;
import com.elveloz.model.Cliente;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class ClienteDAO {
    
    private Connection con;
    private final Conexion c = new Conexion();
    private PreparedStatement ps;
    private ResultSet rs;
    
    public ClienteDAO(){
        this.con = c.getConnection();
    }
    
    
    public boolean agregarCliente(Cliente cliente) {
        boolean agregado = false;
        String sql = "INSERT INTO clientes (nombre, apellido, email, telefono, nacionalidad, tipo_documento, numero_documento, id_rol_cliente, activo) VALUES (?, ?, ?, ?, ?, ?, ?, ?,?)";
        try {
            ps = con.prepareStatement(sql);
            ps.setString(1, cliente.getNombre());
            ps.setString(2, cliente.getApellido());
            ps.setString(3, cliente.getEmail());
            ps.setString(4, cliente.getTelefono());
            ps.setString(5, cliente.getNacionalidad()); 
            ps.setString(6, cliente.getTipo_documento());
            ps.setString(7, cliente.getNumero_documento());
            ps.setInt(8, cliente.getId_rol_cliente()); 
            ps.setBoolean(9, cliente.isActivo());
            
            int filasAfectadas = ps.executeUpdate();
            if (filasAfectadas > 0) {
                agregado = true;
                System.out.println("Se agregó correctamente el cliente");
            }
        } catch (SQLException e) {
            System.err.println("Error al agregar cliente" + e.getMessage());
            e.printStackTrace(); 
        } finally {
            DAOUtil.cerrarRecursos(ps);
        }
        return agregado;
    }
    
    public List<Cliente> listarClientesPaginadoPorRol(int idRolCliente, int limit, int offset) {
        List<Cliente> clientes = new ArrayList<>();
        String sql = "SELECT id_cliente, nombre, apellido, email, telefono, nacionalidad, tipo_documento, numero_documento, id_rol_cliente, activo " +
                     "FROM clientes WHERE activo = true AND id_rol_cliente = ? ORDER BY id_cliente DESC LIMIT ? OFFSET ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idRolCliente); // Filtra por el rol del cliente
            ps.setInt(2, limit);
            ps.setInt(3, offset);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Cliente cliente = new Cliente();
                    cliente.setId_cliente(rs.getInt("id_cliente"));
                    cliente.setNombre(rs.getString("nombre"));
                    cliente.setApellido(rs.getString("apellido"));
                    cliente.setEmail(rs.getString("email"));
                    cliente.setTelefono(rs.getString("telefono"));
                    cliente.setNacionalidad(rs.getString("nacionalidad"));
                    cliente.setTipo_documento(rs.getString("tipo_documento"));
                    cliente.setNumero_documento(rs.getString("numero_documento"));
                    cliente.setId_rol_cliente(rs.getInt("id_rol_cliente"));
                    cliente.setActivo(rs.getBoolean("activo"));
                    clientes.add(cliente);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al listar clientes paginados por rol: " + e.getMessage());
            e.printStackTrace();
        }
        return clientes;
    }
    
    public int contarClientesPorRol(int idRolCliente) {
        int total = 0;
        String sql = "SELECT COUNT(*) FROM clientes WHERE activo = true AND id_rol_cliente = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idRolCliente);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    total = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al contar clientes por rol: " + e.getMessage());
            e.printStackTrace();
        }
        System.out.println("Número de clientes con rol " + idRolCliente + ": " + total);
        return total;
    }
    
    public Cliente obtenerClientePorId(int id) {
        Cliente cliente = null;
        // Seleccionamos todos los campos necesarios para pre-llenar el formulario.
        // Incluimos id_rol_cliente, aunque no se modificará, es bueno tener el dato.
        String sql = "SELECT id_cliente, nombre, apellido, email, telefono, nacionalidad, tipo_documento, numero_documento, id_rol_cliente FROM clientes WHERE id_cliente = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    cliente = new Cliente();
                    cliente.setId_cliente(rs.getInt("id_cliente"));
                    cliente.setNombre(rs.getString("nombre"));
                    cliente.setApellido(rs.getString("apellido"));
                    cliente.setEmail(rs.getString("email"));
                    cliente.setTelefono(rs.getString("telefono"));
                    cliente.setNacionalidad(rs.getString("nacionalidad"));
                    cliente.setTipo_documento(rs.getString("tipo_documento"));
                    cliente.setNumero_documento(rs.getString("numero_documento"));
                    cliente.setId_rol_cliente(rs.getInt("id_rol_cliente")); 
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener cliente por ID: " + e.getMessage());
            e.printStackTrace();
        }
        return cliente;
    }

    public boolean actualizarCliente(Cliente cliente) {
        System.out.println("Actualizando cliente con ID: " + cliente.getId_cliente());
        System.out.println("Nombre: " + cliente.getNombre());
        System.out.println("Apellido: " + cliente.getApellido());
        System.out.println("Email: " + cliente.getEmail());
        System.out.println("Teléfono: " + cliente.getTelefono());
        System.out.println("Nacionalidad: " + cliente.getNacionalidad());
        System.out.println("Tipo Documento: " + cliente.getTipo_documento());
        System.out.println("Número Documento: " + cliente.getNumero_documento());
        
        boolean actualizado = false;
        try {
            String sql = "UPDATE clientes SET nombre = ?, apellido = ?, email = ?, telefono = ?, " +
                         "nacionalidad = ?, tipo_documento = ?, numero_documento = ? WHERE id_cliente = ?";
            
            ps = con.prepareStatement(sql);
            ps.setString(1, cliente.getNombre());
            ps.setString(2, cliente.getApellido());
            ps.setString(3, cliente.getEmail());
            ps.setString(4, cliente.getTelefono());
            ps.setString(5, cliente.getNacionalidad());
            ps.setString(6, cliente.getTipo_documento());
            ps.setString(7, cliente.getNumero_documento());
            ps.setInt(8, cliente.getId_cliente()); 
            
            int filasAfectadas = ps.executeUpdate();
            if (filasAfectadas > 0) {
                actualizado = true;
                System.out.println("Cliente ID " + cliente.getId_cliente() + " actualizado correctamente.");
            }
        } catch (SQLException e) {
            System.err.println("Error al actualizar cliente: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DAOUtil.cerrarRecursos(ps);
        }
        return actualizado;
    }
    
    public boolean eliminarCliente(int id, boolean activo) {
        boolean actualizado = false;
        try {
            String sql = "UPDATE clientes SET activo = ? WHERE id_cliente = ?";
            ps = con.prepareStatement(sql);
            ps.setBoolean(1, activo); 
            ps.setInt(2, id); 
            
            int filasAfectadas = ps.executeUpdate();
            if (filasAfectadas > 0) {
                actualizado = true;
                System.out.println("Cliente con ID " + id + " actualizado a activo = " + activo);
            }
        } catch (SQLException e) {
            System.err.println("Error al actualizar el estado activo del cliente: " + e.getMessage());
            e.printStackTrace(); 
        } finally {
            DAOUtil.cerrarRecursos(ps); 
        }
        return actualizado;
    }
    
    public List<Cliente> listarClientesActivosParaComboBox(int idRolCliente) {
        List<Cliente> clientes = new ArrayList<>();
        String sql = "SELECT id_cliente, nombre, apellido FROM clientes WHERE activo = TRUE AND id_rol_cliente = ? ORDER BY nombre, apellido";

        try (PreparedStatement localPs = con.prepareStatement(sql)) {
            localPs.setInt(1, idRolCliente);
            try (ResultSet localRs = localPs.executeQuery()) {
                while (localRs.next()) {
                    Cliente cliente = new Cliente();
                    cliente.setId_cliente(localRs.getInt("id_cliente"));
                    cliente.setNombre(localRs.getString("nombre"));
                    cliente.setApellido(localRs.getString("apellido"));
                    clientes.add(cliente);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al listar clientes activos para combobox por rol: " + e.getMessage());
            e.printStackTrace();
        }
        return clientes;
    }
    
}
