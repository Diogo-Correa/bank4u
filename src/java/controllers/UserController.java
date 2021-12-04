/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import app.Administrador;
import app.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.AdministradorDAO;
import models.UsuarioDAO;

/**
 *
 * @author Diogo
 */
@WebServlet(name = "UserController", urlPatterns = {"/userStore"})
public class UserController extends HttpServlet {


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
        String nome = request.getParameter("nome");
        String cpf = request.getParameter("cpf");
        String senha = request.getParameter("senha");
        String userRole = request.getParameter("role");
        System.out.println("Informe uma role valida." + nome);
        System.out.println("Informe uma role valida." + senha);
        System.out.println("Informe uma role valida." + cpf);
        System.out.println("Informe uma role valida." + userRole);
        
        if(userRole.equals("admin")) {
            AdministradorDAO adminDAO = new AdministradorDAO();
            Administrador admin = new Administrador();
            
            admin.setNome(nome);
            admin.setCpf(cpf);
            admin.setSenha(senha);
            
            adminDAO.store(admin);
        } else if(userRole.equals("user")) {
            UsuarioDAO userDAO = new UsuarioDAO();
            Usuario user = new Usuario();
            
            user.setNome(nome);
            user.setCpf(cpf);
            user.setSenha(senha);
            user.setSuspenso("N");
            
            userDAO.store(user);
        } else {
            System.out.println("Informe uma role valida.");
        }
        
        response.sendRedirect("settings.jsp");
        
    }

}
