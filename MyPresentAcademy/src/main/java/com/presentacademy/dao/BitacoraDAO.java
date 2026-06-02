package com.presentacademy.dao;

import com.presentacademy.datos.Conexion;
import com.presentacademy.modelo.Bitacora;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BitacoraDAO {

    public void registrarAccion(int usuarioId, String accion) {
        String sql = "INSERT INTO bitacora(usuario_id, accion, fecha) VALUES (?, ?, CURRENT_TIMESTAMP)";

        try {
            Connection con = new Conexion().getConexion();
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, usuarioId);
            ps.setString(2, accion);

            ps.executeUpdate();

        } catch (Exception e) {
            System.out.println("ERROR REGISTRAR BITACORA: " + e.getMessage());
        }
    }

    public List<Bitacora> listarBitacora() {
        List<Bitacora> lista = new ArrayList<Bitacora>();

        String sql = "SELECT * FROM bitacora ORDER BY fecha DESC";

        try {
            Connection con = new Conexion().getConexion();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Bitacora b = new Bitacora();

                b.setId(rs.getInt("id"));
                b.setUsuarioId(rs.getInt("usuario_id"));
                b.setAccion(rs.getString("accion"));
                b.setFecha(rs.getString("fecha"));

                lista.add(b);
            }

        } catch (Exception e) {
            System.out.println("ERROR LISTAR BITACORA: " + e.getMessage());
        }

        return lista;
    }
}