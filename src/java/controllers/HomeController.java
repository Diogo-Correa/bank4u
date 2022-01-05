/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import app.Administrador;
import app.User;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.AdministradorDAO;
import models.CategoriaDAO;
import models.ContaDAO;
import models.UsuarioDAO;

/**
 *
 * @author Diogo
 */
@WebServlet(name = "HomeController", urlPatterns = {"/home"})
public class HomeController extends HttpServlet {


    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
        if(request.getSession().getAttribute("isLoggedIn") != null && (boolean) request.getSession().getAttribute("isLoggedIn") && request.getSession().getAttribute("authUser") != null) {
            
            User authUser = (User) request.getSession().getAttribute("authUser");
            
            request.getSession().removeAttribute("id");
            request.getSession().removeAttribute("nome");
            request.getSession().removeAttribute("cpf");
            request.getSession().removeAttribute("suspenso");
            request.getSession().removeAttribute("admin");
            
            if((boolean) request.getSession().getAttribute("isAdmin")) {
                
                request.setAttribute("users", new UsuarioDAO().getThreeUsers());
                request.setAttribute("usersCount", new UsuarioDAO().getAll().size());
                
                request.setAttribute("admins", new AdministradorDAO().getThreeAdmins());
                request.setAttribute("adminsCount", new AdministradorDAO().getAll().size());
                
                request.setAttribute("categories", new CategoriaDAO().getThreeTags());
                request.setAttribute("categoriesCount", new CategoriaDAO().getAll().size());
                
                request.getRequestDispatcher("settings.jsp").forward(request, response);
            } else {
                
                request.setAttribute("contas", new ContaDAO().getByUserID(authUser.getId()));
                request.setAttribute("categorias", new CategoriaDAO().getAll());
                
                request.getRequestDispatcher("dashboard.jsp").forward(request, response);
            }
        } else {
            response.sendRedirect("logout");
        }
    }

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
    }

}
