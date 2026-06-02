package com.presentacademy.controlador;

import java.io.IOException;

import com.presentacademy.dao.UsuarioDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/BloquearUsuarioServlet")
public class BloquearUsuarioServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public BloquearUsuarioServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idTexto = request.getParameter("id");
        String accion = request.getParameter("accion");

        if (idTexto == null || accion == null) {
            response.sendRedirect("AdminServlet");
            return;
        }

        int id = Integer.parseInt(idTexto);

        UsuarioDAO dao = new UsuarioDAO();

        if ("bloquear".equals(accion)) {
            dao.bloquearUsuario(id);
        } else if ("activar".equals(accion)) {
            dao.activarUsuario(id);
        }

        response.sendRedirect("AdminServlet");
    }
}