/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import app.Administrador;
import app.Usuario;
import app.util.errors.*;
import app.util.validate.UserFormValidate;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
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
@WebServlet(name = "UserController", urlPatterns = {"/user"})
public class UsuarioController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        if((!(boolean) request.getSession().getAttribute("isAdmin") || request.getSession().getAttribute("isAdmin") == null) || (!(boolean) request.getSession().getAttribute("isLoggedIn") || request.getSession().getAttribute("isLoggedIn") == null)) {
            request.getSession().setAttribute("error", "Voce nao tem permissao para acessar essa area!");
            response.sendRedirect("home");
        } else {
        
            String action = request.getParameter("action");

            switch(action) {
                case "suspend":
                    suspend(request,response);
                    break;
                case "show":
                    show(request,response);
                    break;
                case "edit":
                    edit(request,response);
                    break;
                case "delete":
                    delete(request,response);
                    break;
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
        
        if((!(boolean) request.getSession().getAttribute("isAdmin") || request.getSession().getAttribute("isAdmin") == null) || (!(boolean) request.getSession().getAttribute("isLoggedIn") || request.getSession().getAttribute("isLoggedIn") == null)) {
            request.getSession().setAttribute("error", "Voce nao tem permissao para acessar essa area!");
            response.sendRedirect("home");
        } else {
        
            String action = request.getParameter("action");

            switch(action) {
                case "store":
                    store(request,response);
                    break;
                case "update":
                    update(request,response);
                    break;
            }
        }
    }
    
    protected void store(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        UserFormValidate validate = new UserFormValidate();
        
        String nome = request.getParameter("nome");
        String cpf = request.getParameter("cpf");
        String senha = request.getParameter("senha");
        String userRole = request.getParameter("role");
        
        AdministradorDAO adminDAO = new AdministradorDAO();
        Administrador admin = adminDAO.getByCPF(cpf);
        UsuarioDAO userDAO = new UsuarioDAO();
        Usuario user = userDAO.getByCPF(cpf);
        
        
        try {
            if(user != null || admin != null) { 
                throw new CPFCadastradoException();
            } else {
                
                // Validar campos do formulario
                if(!validate.validateText(nome, 20)) throw new MaxLengthTextInputException("nome", 20);
                if(!validate.validateTextEqualsLength(cpf, 14)) throw new EqualsLengthTextInputException("cpf", 11);
                if(validate.validateText(senha, 2)) throw new MinLengthTextInputException("senha", 2);
                if(userRole == null) throw new RoleException();
                
                switch (userRole) {
                    case "admin":
                        admin = new Administrador();
                        admin.setNome(nome);
                        admin.setCpf(cpf);
                        admin.setSenha(senha);
                        adminDAO.store(admin);
                        break;
                    case "user":
                        user = new Usuario();
                        user.setNome(nome);
                        user.setCpf(cpf);
                        user.setSenha(senha);
                        user.setSuspenso("N");
                        userDAO.store(user);
                        break;
                }

                request.getSession().setAttribute("success", "Usuario adicionado ao sistema!");
                response.sendRedirect("home");
            }
            
        } catch (CPFCadastradoException | MaxLengthTextInputException | EqualsLengthTextInputException | MinLengthTextInputException | RoleException err) {
            request.getSession().setAttribute("error", err.getMessage());
            response.sendRedirect("home");
        }
    }
    
    protected void suspend(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            
            UsuarioDAO userDAO = new UsuarioDAO();
            Usuario user = userDAO.getByID(id);
            
            if(userDAO.getByID(id) != null) {
                userDAO.suspendUser(user);
            
                request.getSession().setAttribute("success",(user.isSuspenso()) ? "Usuario ativo no sistema!" : "Usuario suspenso do sistema!");
                response.sendRedirect("home");
            } else {
                request.getSession().setAttribute("error", "Usuario nao encontrado!");
                response.sendRedirect("home");
            }
            
            
        } catch(NumberFormatException e) {
            
            request.getSession().setAttribute("error", "ID informado nao eh um inteiro.");
            response.sendRedirect("home");
            
        } 
    }
    
    protected void show(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            request.getSession().removeAttribute("suspenso");
            
            if(request.getParameter("admin") == null && request.getParameter("admin") != "true") {
                UsuarioDAO userDAO = new UsuarioDAO();
                Usuario user = userDAO.getByID(id);
                
                if(user != null) {
                    request.getSession().setAttribute("nome", user.getNome());
                    request.getSession().setAttribute("cpf", user.getCpf());
                    request.getSession().setAttribute("suspenso", user.getSuspenso());

                    request.getRequestDispatcher("resources/usuarios/show.jsp").forward(request, response);
                } else {
                    request.getSession().setAttribute("error", "Usuario nao encontrado!");
                    response.sendRedirect("home");
                }
            } else {
                AdministradorDAO adminDAO = new AdministradorDAO();
                Administrador admin = adminDAO.getByID(id);
                
                if(admin != null) {
                    request.getSession().setAttribute("nome", admin.getNome());
                    request.getSession().setAttribute("cpf", admin.getCpf());

                    request.getRequestDispatcher("resources/usuarios/show.jsp").forward(request, response);
                } else {
                    request.getSession().setAttribute("error", "Usuario nao encontrado!");
                    response.sendRedirect("home");
                }
                
            }
            
            
        } catch(NumberFormatException e) {
            request.getSession().setAttribute("error", "ID informado nao eh um inteiro.");
            response.sendRedirect("home");
        }
    }
    
    protected void edit(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            request.getSession().removeAttribute("suspenso");
            
            if(request.getParameter("admin") == null && request.getParameter("admin") != "true") {
                UsuarioDAO userDAO = new UsuarioDAO();
                Usuario user = userDAO.getByID(id);
                
                if(user != null) {
                    request.getSession().setAttribute("id", user.getId());
                    request.getSession().setAttribute("nome", user.getNome());
                    request.getSession().setAttribute("cpf", user.getCpf());
                    request.getSession().setAttribute("suspenso", user.getSuspenso());
                    request.getSession().setAttribute("admin", "false");

                    request.getRequestDispatcher("resources/usuarios/edit.jsp").forward(request, response);
                } else {
                    request.getSession().setAttribute("error", "Usuario nao encontrado!");
                    response.sendRedirect("home");
                }
            } else {
                AdministradorDAO adminDAO = new AdministradorDAO();
                Administrador admin = adminDAO.getByID(id);
                
                if(admin != null) {
                    request.getSession().setAttribute("id", admin.getId());
                    request.getSession().setAttribute("nome", admin.getNome());
                    request.getSession().setAttribute("cpf", admin.getCpf());
                    request.getSession().setAttribute("admin", "true");

                    request.getRequestDispatcher("resources/usuarios/edit.jsp").forward(request, response);
                } else {
                    request.getSession().setAttribute("error", "Usuario nao encontrado!");
                    response.sendRedirect("home");
                }
                
            }
            
            
        } catch(NumberFormatException e) {
            request.getSession().setAttribute("error", "ID informado nao eh um inteiro.");
            response.sendRedirect("home");
        }
    }
    
    protected void update(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String nome = request.getParameter("nome");
            String cpf = request.getParameter("cpf");

            if(request.getParameter("admin") == null && request.getParameter("admin") != "true") {
                    UsuarioDAO userDAO = new UsuarioDAO();
                    Usuario user = userDAO.getByID(id);

                    if(user != null) {
                        user.setNome(nome);
                        user.setCpf(cpf);
                        userDAO.update(user);
                        
                        request.getSession().setAttribute("success", "Usuario atualizado no sistema!");
                        response.sendRedirect("home");
                    } else {
                        request.getSession().setAttribute("error", "Usuario nao encontrado!");
                        response.sendRedirect("home");
                    }

            } else {
                    AdministradorDAO adminDAO = new AdministradorDAO();
                    Administrador admin = adminDAO.getByID(id);

                    if(admin != null) {
                        admin.setNome(nome);
                        admin.setCpf(cpf);
                        adminDAO.update(admin);
                        
                        request.getSession().setAttribute("success", "Admin atualizado no sistema!");
                        response.sendRedirect("home");
                    } else {
                        request.getSession().setAttribute("error", "Usuario nao encontrado!");
                        response.sendRedirect("home");
                    }
            }
            
        } catch(NumberFormatException e) {
            request.getSession().setAttribute("error", "ID informado nao eh um inteiro.");
            response.sendRedirect("home");
        }
    }
    
    protected void delete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            
            int id = Integer.parseInt(request.getParameter("id"));
            if(request.getParameter("admin") == null && request.getParameter("admin") != "true") {

                UsuarioDAO userDAO = new UsuarioDAO();

                if(userDAO.getByID(id) != null) {
                    userDAO.delete(id);

                    request.getSession().setAttribute("success", "Usuario removido do sistema!");
                    response.sendRedirect("home");
                } else {
                    request.getSession().setAttribute("error", "Usuario nao encontrado!");
                    response.sendRedirect("home");
                }
                
            } else {
                Administrador authAdmin = (Administrador) request.getSession().getAttribute("authUser");
                AdministradorDAO adminDAO = new AdministradorDAO();

                if(adminDAO.getByID(id) != null && id != authAdmin.getId()) {
                    adminDAO.delete(id);

                    request.getSession().setAttribute("success", "Administrador removido do sistema!");
                    response.sendRedirect("home");
                } else {
                    if(id != authAdmin.getId()) {
                        request.getSession().setAttribute("error", "Administrador nao encontrado!");
                        response.sendRedirect("home");
                    } else {
                        request.getSession().setAttribute("error", "Voce nao pode se remover do sistema!");
                        response.sendRedirect("home");
                    }
                }
            }
            
            
        } catch(NumberFormatException e) {
            request.getSession().setAttribute("error", "ID informado nao eh um inteiro.");
            response.sendRedirect("home");
            
        } 
    }
}
