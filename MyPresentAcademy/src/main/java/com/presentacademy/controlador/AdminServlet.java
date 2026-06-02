package com.presentacademy.controlador;

import java.io.IOException;

import com.presentacademy.dao.BitacoraDAO;
import com.presentacademy.dao.UsuarioDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.presentacademy.modelo.Usuario;

@WebServlet("/AdminServlet")
public class AdminServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AdminServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession sesion = request.getSession(false);

        if (sesion == null || sesion.getAttribute("usuario") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Usuario usuario = (Usuario) sesion.getAttribute("usuario");

        if (!"admin".equals(usuario.getRol())) {
            response.sendRedirect("estudiante.jsp");
            return;
        }

        UsuarioDAO usuarioDAO = new UsuarioDAO();
        BitacoraDAO bitacoraDAO = new BitacoraDAO();

        request.setAttribute("usuarios", usuarioDAO.listarUsuarios());
        request.setAttribute("bitacoras", bitacoraDAO.listarBitacora());

        request.getRequestDispatcher("admin.jsp").forward(request, response);
    }
}