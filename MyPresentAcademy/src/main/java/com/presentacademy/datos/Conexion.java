package com.presentacademy.datos;

import java.sql.Connection;
import java.sql.DriverManager;

public class Conexion {

    private static final String DRIVER = "org.postgresql.Driver";

    private static final String URL =
            "jdbc:postgresql://localhost:5432/present_academy";

    private static final String USUARIO = "postgres";

    private static final String CLAVE = "1234";

    private Connection conexion;

    public Conexion() {
        conexion = conectar();
    }

    private Connection conectar() {

        try {

            Class.forName(DRIVER);

            Connection con = DriverManager.getConnection(
                    URL,
                    USUARIO,
                    CLAVE);

            System.out.println("✅ Conectado a PostgreSQL");

            return con;

        } catch (Exception e) {

            System.out.println("❌ Error de conexion: " + e.getMessage());

            return null;
        }
    }

    public Connection getConexion() {
        return conexion;
    }

}