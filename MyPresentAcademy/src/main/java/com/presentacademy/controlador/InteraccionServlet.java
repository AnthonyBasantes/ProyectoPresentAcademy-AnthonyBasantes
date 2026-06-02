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

@WebServlet("/InteraccionServlet")
public class InteraccionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public InteraccionServlet() {
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
        String tema = request.getParameter("tema");
        String pagina = request.getParameter("pagina");

        if (tema != null) {
            BitacoraDAO bitacora = new BitacoraDAO();
            bitacora.registrarAccion(usuario.getId(), "Ingresó al tema: " + tema);
        }

        if (pagina != null && !pagina.trim().isEmpty()) {
            response.sendRedirect(pagina);
        } else {
            response.sendRedirect("estudiante.jsp");
        }
    }
}