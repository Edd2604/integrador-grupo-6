
package com.elveloz.dao;

import com.elveloz.config.Conexion;
import com.elveloz.model.PeticionEnvio;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class PeticionEnvioDAO {
    
    private Connection con;
    private final Conexion c = new Conexion();
    private PreparedStatement ps;
    private ResultSet rs;
    
    public PeticionEnvioDAO(){
        this.con = c.getConnection();
    }
    
    public int agregarPeticionEnvio(PeticionEnvio peticion) {
        String sql = "INSERT INTO peticiones_envio (" +
                     "id_cliente_nacional, id_cliente_extranjero, " +
                     "tipo_envio, pais_envio, id_usuario" +
                     ") VALUES (?, ?, ?, ?, ?)";

        int idGenerado = -1;

        try {
            ps = con.prepareStatement(sql, ps.RETURN_GENERATED_KEYS);

            // Setear parámetros
            if (peticion.getId_cliente_nacional() == 0) {
                ps.setNull(1, java.sql.Types.INTEGER);
            } else {
                ps.setInt(1, peticion.getId_cliente_nacional());
            }

            if (peticion.getId_cliente_extranjero() == 0) {
                ps.setNull(2, java.sql.Types.INTEGER);
            } else {
                ps.setInt(2, peticion.getId_cliente_extranjero());
            }

            ps.setString(3, peticion.getTipo_envio());
            ps.setString(4, peticion.getPais_envio());
            ps.setInt(5, peticion.getId_usuario());

            int filasAfectadas = ps.executeUpdate();

            if (filasAfectadas > 0) {
                rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    idGenerado = rs.getInt(1);
                    peticion.setId_peticion_envio(idGenerado);
                }
            }

        } catch (SQLException e) {
            System.err.println("Error al agregar PeticionEnvio en DAO: " + e.getMessage());
            e.printStackTrace();
        } 
        return idGenerado;
    }

    
    public PeticionEnvio obtenerPeticionEnvioPorId(int id_peticion) {
        PeticionEnvio peticion = null;
        String sql = "SELECT pe.*, " +
                     "       COALESCE(cn.nombre, '') AS nombre_cliente_nacional, COALESCE(cn.apellido, '') AS apellido_cliente_nacional, " +
                     "       COALESCE(ce.nombre, '') AS nombre_cliente_extranjero, COALESCE(ce.apellido, '') AS apellido_cliente_extranjero " +
                     "FROM peticiones_envio pe " +
                     "LEFT JOIN clientes cn ON pe.id_cliente_nacional = cn.id_cliente " +
                     "LEFT JOIN clientes ce ON pe.id_cliente_extranjero = ce.id_cliente " +
                     "WHERE pe.id_peticion_envio = ?";

        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1, id_peticion);
            rs = ps.executeQuery();

            if (rs.next()) {
                peticion = new PeticionEnvio();
                peticion.setId_peticion_envio(rs.getInt("id_peticion_envio"));
                peticion.setCodigo_peticion(rs.getString("codigo_peticion"));
                peticion.setId_cliente_nacional(rs.getInt("id_cliente_nacional"));
                peticion.setId_cliente_extranjero(rs.getInt("id_cliente_extranjero"));
                peticion.setTipo_envio(rs.getString("tipo_envio"));
                peticion.setPais_envio(rs.getString("pais_envio"));
                peticion.setId_usuario(rs.getInt("id_usuario"));
                peticion.setPeso_total(rs.getDouble("peso_total"));
                peticion.setCantidad_paquetes(rs.getInt("cantidad_paquetes"));
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener PeticionEnvio por ID en DAO: " + e.getMessage());
            e.printStackTrace();
        } 
        return peticion;
    }
    
    public String obtenerNombreCompletoCliente(int idCliente) {
        String nombreCompleto = "";
        String sql = "SELECT nombre, apellido FROM clientes WHERE id_cliente = ?";
        PreparedStatement tempPs = null;
        ResultSet tempRs = null;
        try {
            tempPs = con.prepareStatement(sql); // Usa la conexión 'con' del DAO
            tempPs.setInt(1, idCliente);
            tempRs = tempPs.executeQuery();
            if (tempRs.next()) {
                String nombre = tempRs.getString("nombre");
                String apellido = tempRs.getString("apellido");
                if (nombre != null) nombreCompleto += nombre;
                if (apellido != null && !apellido.isEmpty()) {
                    if (!nombreCompleto.isEmpty()) nombreCompleto += " ";
                    nombreCompleto += apellido;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener nombre de cliente en PeticionEnvioDAO (auxiliar): " + e.getMessage());
            e.printStackTrace();
        } 
        return nombreCompleto;
    }
    
    public boolean actualizarPeticionEnvio(PeticionEnvio peticion) {
        String sql = "UPDATE peticiones_envio SET peso_total = ?, precio_total = ?, cantidad_paquetes = ? WHERE id_peticion_envio = ?";
        try {
            ps = con.prepareStatement(sql);
            ps.setDouble(1, peticion.getPeso_total());
            ps.setDouble(2, peticion.getPrecio_total());
            ps.setInt(3, peticion.getCantidad_paquetes());
            ps.setInt(4, peticion.getId_peticion_envio());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error al actualizar PeticionEnvio en DAO: " + e.getMessage());
            e.printStackTrace();
            return false;
        } 
    }
    
    public boolean eliminarPeticionEnvio(int id_peticion_envio) {
        String sql = "DELETE FROM peticiones_envio WHERE id_peticion_envio = ?"; // Consulta DELETE
        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1, id_peticion_envio); 

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0; 
        } catch (SQLException e) {
            System.err.println("Error al eliminar PeticionEnvio en DAO: " + e.getMessage());
            e.printStackTrace();
            return false;
        } 
    }

    public List<PeticionEnvio> listarTodasPeticionesEnvioConDetalles() {
        List<PeticionEnvio> peticiones = new ArrayList<>();
        // Consulta SQL para MySQL, utilizando CONCAT_WS y los nombres de tus tablas/columnas
        String sql = "SELECT " +
                     "    pe.id_peticion_envio, " +
                     "    pe.codigo_peticion, " +
                     "    pe.id_cliente_nacional, " +
                     "    pe.id_cliente_extranjero, " +
                     "    pe.id_envio_consolidado, " +
                     "    pe.fecha_creacion, " +
                     "    pe.precio_total, " +
                     "    pe.tipo_envio, " +
                     "    pe.pais_envio, " +
                     "    pe.peso_total, " +
                     "    pe.cantidad_paquetes, " +
                     "    pe.id_usuario, " +
                     "    CONCAT_WS(' ', COALESCE(cn.nombre, ''), COALESCE(cn.apellido, '')) AS nombre_cliente_nacional_completo, " +
                     "    CONCAT_WS(' ', COALESCE(ce.nombre, ''), COALESCE(ce.apellido, '')) AS nombre_cliente_extranjero_completo " +
                     "FROM " +
                     "    peticiones_envio pe " +
                     "LEFT JOIN " +
                     "    clientes cn ON pe.id_cliente_nacional = cn.id_cliente " +
                     "LEFT JOIN " +
                     "    clientes ce ON pe.id_cliente_extranjero = ce.id_cliente " +
                     "ORDER BY " +
                     "    pe.id_peticion_envio DESC";

        try (PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                PeticionEnvio peticion = new PeticionEnvio();
                peticion.setId_peticion_envio(rs.getInt("id_peticion_envio"));
                peticion.setCodigo_peticion(rs.getString("codigo_peticion"));
                peticion.setId_cliente_nacional(rs.getInt("id_cliente_nacional"));
                peticion.setId_cliente_extranjero(rs.getInt("id_cliente_extranjero"));
                peticion.setId_envio_consolidado(rs.getObject("id_envio_consolidado") != null ? rs.getInt("id_envio_consolidado") : null);
                peticion.setFecha_creacion(rs.getTimestamp("fecha_creacion")); // TIMESTAMP en la DB se mapea bien a Date con getTimestamp()
                java.sql.Timestamp fechaTimestamp = rs.getTimestamp("fecha_creacion");
                
                System.out.println("DEBUG: ID Petición: " + peticion.getId_peticion_envio() + ", Fecha de creación (Timestamp): " + fechaTimestamp);
                
                peticion.setPrecio_total(rs.getDouble("precio_total"));
                peticion.setTipo_envio(rs.getString("tipo_envio"));
                peticion.setPais_envio(rs.getString("pais_envio"));
                peticion.setPeso_total(rs.getDouble("peso_total"));
                peticion.setCantidad_paquetes(rs.getInt("cantidad_paquetes"));
                peticion.setId_usuario(rs.getObject("id_usuario") != null ? rs.getInt("id_usuario") : null);

                // Setear los nuevos campos de nombres completos de cliente
                peticion.setNombreClienteNacionalCompleto(rs.getString("nombre_cliente_nacional_completo"));
                peticion.setNombreClienteExtranjeroCompleto(rs.getString("nombre_cliente_extranjero_completo"));

                peticiones.add(peticion);
            }
        } catch (SQLException e) {
            System.err.println("Error al listar todas las peticiones de envío: " + e.getMessage());
            e.printStackTrace();
        }
        return peticiones;
    }
}
