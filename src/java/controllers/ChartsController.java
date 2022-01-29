/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.AdministradorDAO;
import models.ContaDAO;
import models.UsuarioDAO;

/**
 *
 * @author Diogo
 */
@WebServlet(name = "ChartsController", urlPatterns = {"/charts"})
public class ChartsController extends HttpServlet {

    private final String resource = "resources/charts/";
    
    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        if(request.getSession().getAttribute("authUser") == null || (request.getSession().getAttribute("isAdmin") == null || !(boolean) request.getSession().getAttribute("isAdmin")) || (!(boolean) request.getSession().getAttribute("isLoggedIn") || request.getSession().getAttribute("isLoggedIn") == null)) {
            request.getSession().setAttribute("error", "Voce nao tem permissao para acessar essa area!");
            response.sendRedirect("home");
        } else {
            request.setAttribute("usersCount", new UsuarioDAO().getAll().size());
            request.setAttribute("usersSuspendCount", new UsuarioDAO().getSuspendUsers().size());

            request.setAttribute("adminsCount", new AdministradorDAO().getAll().size());
            
            request.setAttribute("itauCount", new ContaDAO().getByBanco("341").size());
            request.setAttribute("bbCount", new ContaDAO().getByBanco("001").size());

            request.getRequestDispatcher(this.resource + "index.jsp").forward(request, response);
        }
    }

}
