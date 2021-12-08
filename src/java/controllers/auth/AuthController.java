/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.auth;

import app.Administrador;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.UsuarioDAO;
import app.Usuario;
import models.AdministradorDAO;

/**
 *
 * @author Diogo
 */
@WebServlet(name = "AuthController", urlPatterns = {"/auth"})
public class AuthController extends HttpServlet {

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userCPF = request.getParameter("cpf");
        String userPassword = request.getParameter("senha");

        AdministradorDAO adminDAO = new AdministradorDAO();
        Administrador admin = adminDAO.getAdministradorAuth(userCPF, userPassword);
        
        UsuarioDAO userDAO = new UsuarioDAO();
        Usuario user = userDAO.getUsuarioAuth(userCPF, userPassword);

        if(user != null && user.getSuspenso().equals("S")) {
            request.getSession().setAttribute("isLoggedIn", false);
            request.getSession().setAttribute("error", "Voce esta suspenso do sistema!");
            response.sendRedirect("/banco");
        } else {
            if(user != null || admin != null) {
                request.getSession().setAttribute("authUser", (user != null) ? user : admin);
                request.getSession().setAttribute("isAdmin", (user != null) ? false : true);
                request.getSession().setAttribute("isLoggedIn", true);
                response.sendRedirect("home");
            } else {
                request.getSession().setAttribute("isLoggedIn", false);
                request.getSession().setAttribute("error", "Credenciais incorretas");
                response.sendRedirect("/banco");
            }
        }

    }

}
