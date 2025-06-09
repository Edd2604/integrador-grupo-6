
package com.elveloz.dao;

import com.elveloz.model.Paquete;
import com.elveloz.config.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;

public class PaqueteDAO {
    
    private Connection con;
    private final Conexion c = new Conexion();
    private PreparedStatement ps;
    private ResultSet rs;
    
    public PaqueteDAO() {
        this.con = c.getConnection();
    }
    
     public boolean agregarPaquete(Paquete paquete) {
        String sql = "INSERT INTO paquetes (id_peticion_envio, nombre, categoria, cantidad, peso) " +
                     "VALUES (?, ?, ?, ?, ?)";
        boolean agregado = false;
        
        try {
            ps = con.prepareStatement(sql, ps.RETURN_GENERATED_KEYS);
            
            ps.setInt(1, paquete.getId_peticion_envio());
            ps.setString(2, paquete.getNombre());
            ps.setString(3, paquete.getCategoria());
            ps.setInt(4, paquete.getCantidad());
            ps.setDouble(5, paquete.getPeso());
            
            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                agregado = true;
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        paquete.setId_paquete(rs.getInt(1));
                    }
                }
            }
            
        } catch (SQLException e) {
            System.err.println("Error al agregar Paquete en DAO: " + e.getMessage());
            e.printStackTrace();
        }
        return agregado;
            
    }
     
    public List<Paquete> listarPaquetesPorPeticionEnvio(int id_peticion_envio) {
        List<Paquete> listaPaquetes = new ArrayList<>();
        String sql = "SELECT id_paquete, id_peticion_envio, nombre, categoria, peso, cantidad " +
                     "FROM paquetes WHERE id_peticion_envio = ?";

        try {
            ps = con.prepareStatement(sql, ps.RETURN_GENERATED_KEYS);
            
            ps.setInt(1, id_peticion_envio); // Establece el id_peticion_envio en el PreparedStatement

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Paquete paquete = new Paquete();
                    paquete.setId_paquete(rs.getInt("id_paquete"));
                    paquete.setId_peticion_envio(rs.getInt("id_peticion_envio")); // Podría ser redundante ya que es el mismo que el input
                    paquete.setNombre(rs.getString("nombre"));
                    paquete.setCategoria(rs.getString("categoria"));
                    paquete.setPeso(rs.getDouble("peso"));
                    paquete.setCantidad(rs.getInt("cantidad"));
                    listaPaquetes.add(paquete);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al listar Paquetes por Petición de Envío en DAO: " + e.getMessage());
            e.printStackTrace();
        }
        return listaPaquetes;
    }
    
    public boolean eliminarPaquete(int idPaquete) {
        String sql = "DELETE FROM paquetes WHERE id_paquete = ?";
        try {
            ps = con.prepareStatement(sql, ps.RETURN_GENERATED_KEYS);
            ps.setInt(1, idPaquete);
            int filasAfectadas = ps.executeUpdate();
            return filasAfectadas > 0;
        } catch (SQLException e) {
            System.err.println("Error al eliminar paquete con ID " + idPaquete + ": " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
     
    
}
