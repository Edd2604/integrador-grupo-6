package com.elveloz.config;

import com.elveloz.config.Conexion;
import com.elveloz.model.Persona;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;

public class testConexion {
    public static void main(String[] args) {
        Conexion conexion = new Conexion();
        Connection con = conexion.getConnection();
        Scanner scanner = new Scanner(System.in);

        if (con != null) {
            try {
                // Insertar una nueva persona
                System.out.println("Ingrese los datos de la nueva persona:");
                System.out.print("Nombre: ");
                String nombre = scanner.nextLine();
                System.out.print("Email: ");
                String email = scanner.nextLine();
                System.out.print("Teléfono: ");
                String telefono = scanner.nextLine();
                System.out.print("Nacionalidad: ");
                String nacionalidad = scanner.nextLine();

                String insertSql = "INSERT INTO personas (nombre, email, telefono, nacionalidad) VALUES (?, ?, ?, ?)";
                PreparedStatement insertStatement = con.prepareStatement(insertSql);
                insertStatement.setString(1, nombre);
                insertStatement.setString(2, email);
                insertStatement.setString(3, telefono);
                insertStatement.setString(4, nacionalidad);

                int filasAfectadas = insertStatement.executeUpdate();

                if (filasAfectadas > 0) {
                    System.out.println("Persona agregada exitosamente.");

                    // Recuperar la persona recién insertada (opcional)
                    String selectLastIdSql = "SELECT LAST_INSERT_ID()";
                    PreparedStatement selectLastIdStatement = con.prepareStatement(selectLastIdSql);
                    ResultSet lastIdResult = selectLastIdStatement.executeQuery();
                    int lastInsertedId = -1;
                    if (lastIdResult.next()) {
                        lastInsertedId = lastIdResult.getInt(1);
                        System.out.println("ID de la persona recién insertada: " + lastInsertedId);

                        // Mostrar los datos de la persona recién insertada
                        String selectSql = "SELECT id_persona, nombre, email, telefono, nacionalidad FROM personas WHERE id_persona = ?";
                        PreparedStatement selectStatement = con.prepareStatement(selectSql);
                        selectStatement.setInt(1, lastInsertedId);
                        ResultSet resultSet = selectStatement.executeQuery();

                        if (resultSet.next()) {
                            Persona personaInsertada = new Persona();
                            personaInsertada.setId_persona(resultSet.getInt("id_persona"));
                            personaInsertada.setNombre(resultSet.getString("nombre"));
                            personaInsertada.setEmail(resultSet.getString("email"));
                            personaInsertada.setTelefono(resultSet.getString("telefono"));
                            personaInsertada.setNacionalidad(resultSet.getString("nacionalidad"));

                            System.out.println("\nDatos de la Persona recién insertada:");
                            System.out.println("ID: " + personaInsertada.getId_persona());
                            System.out.println("Nombre: " + personaInsertada.getNombre());
                            System.out.println("Email: " + personaInsertada.getEmail());
                            System.out.println("Teléfono: " + personaInsertada.getTelefono());
                            System.out.println("Nacionalidad: " + personaInsertada.getNacionalidad());

                            resultSet.close();
                            selectStatement.close();
                        }
                    }
                    lastIdResult.close();
                    selectLastIdStatement.close();
                } else {
                    System.out.println("Error al agregar la persona.");
                }

                insertStatement.close();

            } catch (SQLException e) {
                e.printStackTrace();
                System.out.println("Error al interactuar con la base de datos.");
            } finally {
                try {
                    con.close();
                    scanner.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}