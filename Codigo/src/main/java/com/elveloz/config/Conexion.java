package com.elveloz.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {

    private final String driver = "com.mysql.cj.jdbc.Driver";
    private static final String url = "jdbc:mysql://localhost:3306/el_veloz_db";
    private static final String user = "root";
    private static final String pass = "admin";

    public Connection getConnection(){
        Connection con = null;
        try {
            Class.forName(driver); // Cargar el driver JDBC
            con = DriverManager.getConnection(url, user, pass);
            System.out.println("Conexion Exitosa");
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            System.out.println("Error al ingresar a la base de datos");
        }
        return con;
    }

}