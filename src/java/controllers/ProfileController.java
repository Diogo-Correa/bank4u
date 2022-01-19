/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import app.Administrador;
import app.User;
import app.Usuario;
import app.util.errors.EqualsLengthTextInputException;
import app.util.errors.MaxLengthTextInputException;
import app.util.errors.MinLengthTextInputException;
import app.util.errors.NullTextInputException;
import app.util.errors.UserNotFoundException;
import app.util.validate.UserFormValidate;
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
@WebServlet(name = "ProfileController", urlPatterns = {"/profile"})
public class ProfileController extends HttpServlet {

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
        
        if(!(boolean) request.getSession().getAttribute("isLoggedIn") || request.getSession().getAttribute("isLoggedIn") == null) {
            request.getSession().invalidate();
            request.getSession().setAttribute("error", "Voce nao tem permissao para acessar essa area!");
            response.sendRedirect("home");
        } else {
            String action = request.getParameter("action");
            
            if(action == null) index(request, response);
            else {
                switch(action) {
                }
            }
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
        if(!(boolean) request.getSession().getAttribute("isLoggedIn") || request.getSession().getAttribute("isLoggedIn") == null) {
            request.getSession().invalidate();
            request.getSession().setAttribute("error", "Voce nao tem permissao para acessar essa area!");
            response.sendRedirect("home");
        } else {
            String action = request.getParameter("action");
            
            if(action == null) index(request, response);
            else {
                switch(action) {
                    case "update":
                        update(request, response);
                        break;
                }
            }
        }
    }
    
    protected void index(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        User user = (User) request.getSession().getAttribute("authUser");

        request.getSession().setAttribute("nome", user.getNome());
        request.getSession().setAttribute("senha", user.getSenha());
        request.getSession().setAttribute("cpf", user.getCpf());
        request.getSession().setAttribute("id", user.getId());
        request.getSession().setAttribute("isAdmin", user.isAdmin());
        if(!user.isAdmin()) {
            ContaDAO contaDAO = new ContaDAO();
            request.getSession().setAttribute("contas", contaDAO.getByUserID(user.getId()));
        }

        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }
    
    protected void update(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            UsuarioDAO userDAO = new UsuarioDAO();
            AdministradorDAO adminDAO = new AdministradorDAO();
            User user = (User) request.getSession().getAttribute("authUser");
            UserFormValidate validate = new UserFormValidate();
            
            int id = user.getId();
            String nome = request.getParameter("nome");
            String senha = request.getParameter("senha");

            // Verifica se o usuario foi encontrado.
            if(user == null) throw new UserNotFoundException();
            
            if(nome != null) {
                // Validar campos do formulario
                if(!validate.validateNull(nome)) throw new NullTextInputException("nome");
                if(!validate.validateText(nome, 20)) throw new MaxLengthTextInputException("nome", 20);
                
                // Atualiza o usuario.
                user.setNome(nome);
            }
            
            if(senha != null) {
                if(!validate.validateNull(senha)) throw new NullTextInputException("senha");
                if(validate.validateText(senha, 2)) throw new MinLengthTextInputException("senha", 2);
                
                // Atualiza o usuario.
                user.setSenha(senha);
            }
            
            if(user.isAdmin()) adminDAO.update((Administrador) user); 
            else userDAO.update((Usuario) user);

            request.getSession().setAttribute("success", "Perfil atualizado!");
            response.sendRedirect("profile");
            
        } catch(Exception err) {
            request.getSession().setAttribute("error", err.getMessage());
            response.sendRedirect("profile");
        }
    }
}
