package com.elveloz.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DAOUtil {

    public static void cerrarRecursos(ResultSet rs, PreparedStatement ps, Connection con) {
        try {
            if (rs != null) {
                rs.close();
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log the error properly in a real application
        }
        try {
            if (ps != null) {
                ps.close();
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log the error properly
        }
        try {
            if (con != null && !con.isClosed()) {
                con.close();
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log the error properly
        }
    }

    public static void cerrarRecursos(PreparedStatement ps, Connection con) {
        cerrarRecursos(null, ps, con);
    }

    public static void cerrarRecursos(ResultSet rs, PreparedStatement ps) {
        cerrarRecursos(rs, ps, null);
    }

    public static void cerrarRecursos(PreparedStatement ps) {
        cerrarRecursos(null, ps, null);
    }

    public static void cerrarRecursos(Connection con) {
        cerrarRecursos(null, null, con);
    }

    public static void cerrarRecursos(ResultSet rs) {
        cerrarRecursos(rs, null, null);
    }
}