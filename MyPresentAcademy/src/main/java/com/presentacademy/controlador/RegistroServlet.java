package com.presentacademy.controlador;

import java.io.IOException;

import com.presentacademy.dao.UsuarioDAO;
import com.presentacademy.modelo.Usuario;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegistroServlet")
public class RegistroServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String nombre = request.getParameter("nombre");
        String correo = request.getParameter("correo");
        String clave = request.getParameter("clave");

        request.setAttribute("nombre", nombre);
        request.setAttribute("correo", correo);

        if (nombre == null || nombre.trim().isEmpty()) {
            request.setAttribute("msgError", "El nombre es obligatorio.");
            request.getRequestDispatcher("registro.jsp").forward(request, response);
            return;
        }

        if (correo == null || !correo.contains("@") || !correo.contains(".")) {
            request.setAttribute("msgError", "Ingrese un correo válido.");
            request.getRequestDispatcher("registro.jsp").forward(request, response);
            return;
        }

        if (clave == null || clave.length() < 8) {
            request.setAttribute("msgError", "La clave debe tener mínimo 8 caracteres.");
            request.getRequestDispatcher("registro.jsp").forward(request, response);
            return;
        }

        UsuarioDAO dao = new UsuarioDAO();

        if (dao.existeCorreo(correo)) {
            request.setAttribute("msgError", "El correo ya está registrado.");
            request.getRequestDispatcher("registro.jsp").forward(request, response);
            return;
        }

        Usuario usuario = new Usuario();
        usuario.setNombre(nombre);
        usuario.setCorreo(correo);
        usuario.setClave(clave);

        if (dao.registrar(usuario)) {
            response.sendRedirect("login.jsp?registro=ok");
        } else {
            request.setAttribute("msgError", "Error al registrar usuario. Revise la consola.");
            request.getRequestDispatcher("registro.jsp").forward(request, response);
        }
    }
}