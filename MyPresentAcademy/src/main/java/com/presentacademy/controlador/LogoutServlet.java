package com.presentacademy.controlador;

import java.io.IOException;

import com.presentacademy.dao.BitacoraDAO;
import com.presentacademy.modelo.Usuario;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public LogoutServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession sesion = request.getSession(false);

        if (sesion != null) {
            Usuario usuario = (Usuario) sesion.getAttribute("usuario");

            if (usuario != null) {
                BitacoraDAO bitacora = new BitacoraDAO();
                bitacora.registrarAccion(usuario.getId(), "Cierre de sesión");
            }

            sesion.invalidate();
        }

        response.sendRedirect("login.jsp");
    }
}