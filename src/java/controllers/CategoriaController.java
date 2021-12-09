/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import app.Categoria;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.CategoriaDAO;

/**
 *
 * @author Diogo
 */
@WebServlet(name = "CategoriaController", urlPatterns = {"/category"})
public class CategoriaController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        switch(action) {
            case "delete":
                deleteCategory(request,response);
                break;
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
        String descricao = request.getParameter("descricao");
        
        if(descricao == null || descricao.equals("")) {
            request.getSession().setAttribute("error", "O campo descricao nao pode ser nulo.");
            response.sendRedirect("home");
        } else {
            CategoriaDAO catDAO = new CategoriaDAO();
            Categoria tag = new Categoria();

            tag.setDescricao(descricao);
            catDAO.store(tag);

            request.getSession().setAttribute("success", "Categoria adicionada ao sistema!");
            response.sendRedirect("home");
        }
        
    }
    
    protected void deleteCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            
            CategoriaDAO catDAO = new CategoriaDAO();
            
            catDAO.delete(id);
            
            request.getSession().setAttribute("success", "Categoria removido do sistema!");
            response.sendRedirect("home");
            
            
        } catch(NumberFormatException e) {
            
            request.getSession().setAttribute("error", "ID informado nao eh um inteiro.");
            response.sendRedirect("home");
            
        } 
    }

}
