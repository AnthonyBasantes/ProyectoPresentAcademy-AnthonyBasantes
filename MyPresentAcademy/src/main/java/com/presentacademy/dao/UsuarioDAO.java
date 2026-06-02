package com.presentacademy.dao;

import com.presentacademy.datos.Conexion;
import com.presentacademy.modelo.Usuario;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDAO {

    public boolean existeCorreo(String correo) {
        String sql = "SELECT id FROM usuarios WHERE correo=?";
        try {
            Conexion conexion = new Conexion();
            Connection con = conexion.getConexion();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, correo);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            System.out.println("ERROR EXISTE CORREO: " + e.getMessage());
            return false;
        }
    }

    public boolean registrar(Usuario usuario) {
        String sql = "INSERT INTO usuarios(nombre, correo, clave, rol, estado) VALUES (?, ?, ?, ?, ?)";
        try {
            Conexion conexion = new Conexion();
            Connection con = conexion.getConexion();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, usuario.getNombre());
            ps.setString(2, usuario.getCorreo());
            ps.setString(3, usuario.getClave());
            ps.setString(4, "estudiante");
            ps.setString(5, "activo");
            int filas = ps.executeUpdate();
            System.out.println("REGISTRO OK - FILAS: " + filas);
            return filas > 0;
        } catch (Exception e) {
            System.out.println("ERROR REAL REGISTRO: " + e.getMessage());
            return false;
        }
    }

    /* ── NUEVO: Admin crea usuario con rol configurable ── */
    public boolean crearUsuarioAdmin(Usuario usuario) {
        String sql = "INSERT INTO usuarios(nombre, correo, clave, rol, estado) VALUES (?, ?, ?, ?, 'activo')";
        try {
            Conexion conexion = new Conexion();
            Connection con = conexion.getConexion();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, usuario.getNombre());
            ps.setString(2, usuario.getCorreo());
            ps.setString(3, usuario.getClave());
            ps.setString(4, usuario.getRol());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("ERROR CREAR USUARIO ADMIN: " + e.getMessage());
            return false;
        }
    }

    /* ── NUEVO: Actualizar nombre, correo y rol ── */
    public boolean actualizarUsuario(int id, String nombre, String correo, String rol) {
        String sql = "UPDATE usuarios SET nombre=?, correo=?, rol=? WHERE id=?";
        try {
            Conexion conexion = new Conexion();
            Connection con = conexion.getConexion();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, nombre);
            ps.setString(2, correo);
            ps.setString(3, rol);
            ps.setInt(4, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("ERROR ACTUALIZAR USUARIO: " + e.getMessage());
            return false;
        }
    }

    /* ── NUEVO: Obtener un usuario por ID (para prellenar el modal de edición) ── */
    public Usuario obtenerPorId(int id) {
        String sql = "SELECT * FROM usuarios WHERE id=?";
        try {
            Conexion conexion = new Conexion();
            Connection con = conexion.getConexion();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Usuario u = new Usuario();
                u.setId(rs.getInt("id"));
                u.setNombre(rs.getString("nombre"));
                u.setCorreo(rs.getString("correo"));
                u.setClave(rs.getString("clave"));
                u.setRol(rs.getString("rol"));
                u.setEstado(rs.getString("estado"));
                return u;
            }
        } catch (Exception e) {
            System.out.println("ERROR OBTENER USUARIO: " + e.getMessage());
        }
        return null;
    }

    public Usuario login(String correo, String clave) {
        Usuario usuario = null;
        String sql = "SELECT * FROM usuarios WHERE correo=? AND clave=? AND estado='activo'";
        try {
            Conexion conexion = new Conexion();
            Connection con = conexion.getConexion();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, correo);
            ps.setString(2, clave);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                usuario = new Usuario();
                usuario.setId(rs.getInt("id"));
                usuario.setNombre(rs.getString("nombre"));
                usuario.setCorreo(rs.getString("correo"));
                usuario.setClave(rs.getString("clave"));
                usuario.setRol(rs.getString("rol"));
                usuario.setEstado(rs.getString("estado"));
            }
        } catch (Exception e) {
            System.out.println("ERROR LOGIN: " + e.getMessage());
        }
        return usuario;
    }

    public List<Usuario> listarUsuarios() {
        List<Usuario> lista = new ArrayList<Usuario>();
        String sql = "SELECT * FROM usuarios ORDER BY id ASC";
        try {
            Conexion conexion = new Conexion();
            Connection con = conexion.getConexion();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Usuario u = new Usuario();
                u.setId(rs.getInt("id"));
                u.setNombre(rs.getString("nombre"));
                u.setCorreo(rs.getString("correo"));
                u.setClave(rs.getString("clave"));
                u.setRol(rs.getString("rol"));
                u.setEstado(rs.getString("estado"));
                lista.add(u);
            }
        } catch (Exception e) {
            System.out.println("ERROR LISTAR USUARIOS: " + e.getMessage());
        }
        return lista;
    }

    public boolean bloquearUsuario(int id) {
        String sql = "UPDATE usuarios SET estado='bloqueado' WHERE id=?";
        try {
            Conexion conexion = new Conexion();
            Connection con = conexion.getConexion();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("ERROR BLOQUEAR: " + e.getMessage());
            return false;
        }
    }

    public boolean activarUsuario(int id) {
        String sql = "UPDATE usuarios SET estado='activo' WHERE id=?";
        try {
            Conexion conexion = new Conexion();
            Connection con = conexion.getConexion();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("ERROR ACTIVAR: " + e.getMessage());
            return false;
        }
    }
}
