package com.presentacademy.controlador;

import java.io.IOException;

import com.presentacademy.dao.BitacoraDAO;
import com.presentacademy.dao.UsuarioDAO;
import com.presentacademy.modelo.Usuario;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ActualizarUsuarioServlet")
public class ActualizarUsuarioServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String accion = request.getParameter("accion");
        UsuarioDAO dao = new UsuarioDAO();
        BitacoraDAO bitacora = new BitacoraDAO();

        HttpSession sesion = request.getSession(false);
        Usuario admin = (sesion != null) ? (Usuario) sesion.getAttribute("usuario") : null;
        int adminId = (admin != null) ? admin.getId() : 0;

        if ("crear".equals(accion)) {
            String nombre = request.getParameter("nombre");
            String correo = request.getParameter("correo");
            String clave  = request.getParameter("clave");
            String rol    = request.getParameter("rol");

            if (nombre == null || nombre.trim().isEmpty() ||
                correo == null || !correo.contains("@") ||
                clave == null  || clave.length() < 8 ||
                rol == null    || rol.trim().isEmpty()) {
                response.sendRedirect("AdminServlet?error=datos_crear");
                return;
            }

            if (dao.existeCorreo(correo)) {
                response.sendRedirect("AdminServlet?error=correo_existe");
                return;
            }

            Usuario nuevo = new Usuario();
            nuevo.setNombre(nombre.trim());
            nuevo.setCorreo(correo.trim());
            nuevo.setClave(clave);
            nuevo.setRol(rol);

            boolean ok = dao.crearUsuarioAdmin(nuevo);
            if (ok && adminId > 0) {
                bitacora.registrarAccion(adminId, "Admin creó usuario: " + correo);
            }
            response.sendRedirect("AdminServlet?msg=" + (ok ? "creado" : "error_bd"));

        } else if ("editar".equals(accion)) {
            int id        = Integer.parseInt(request.getParameter("id"));
            String nombre = request.getParameter("nombre");
            String correo = request.getParameter("correo");
            String rol    = request.getParameter("rol");

            if (nombre == null || nombre.trim().isEmpty() ||
                correo == null || !correo.contains("@") ||
                rol == null    || rol.trim().isEmpty()) {
                response.sendRedirect("AdminServlet?error=datos_editar");
                return;
            }

            boolean ok = dao.actualizarUsuario(id, nombre.trim(), correo.trim(), rol);
            if (ok && adminId > 0) {
                bitacora.registrarAccion(adminId, "Admin actualizó usuario ID: " + id);
            }
            response.sendRedirect("AdminServlet?msg=" + (ok ? "actualizado" : "error_bd"));

        } else {
            response.sendRedirect("AdminServlet");
        }
    }
}
