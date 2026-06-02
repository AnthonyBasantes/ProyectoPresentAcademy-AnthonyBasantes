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

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String correo = request.getParameter("correo");
        String clave = request.getParameter("clave");

        UsuarioDAO dao = new UsuarioDAO();
        Usuario usuario = dao.login(correo, clave);

        if (usuario != null) {
            HttpSession sesion = request.getSession();
            sesion.setAttribute("usuario", usuario);

            new BitacoraDAO().registrarAccion(usuario.getId(), "Inicio de sesión");

            if ("admin".equals(usuario.getRol())) {
                response.sendRedirect("AdminServlet");
            } else {
                response.sendRedirect("estudiante.jsp");
            }

        } else {
            response.sendRedirect("login.jsp?error=1");
        }
    }
}