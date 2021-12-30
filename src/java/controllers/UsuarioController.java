/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import app.Administrador;
import app.Usuario;
import app.User;
import app.util.errors.*;
import app.util.validate.UserFormValidate;
import java.io.IOException;
import java.util.ArrayList;
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
    
    private final String resource = "resources/usuarios/";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        if((!(boolean) request.getSession().getAttribute("isAdmin") || request.getSession().getAttribute("isAdmin") == null) || (!(boolean) request.getSession().getAttribute("isLoggedIn") || request.getSession().getAttribute("isLoggedIn") == null)) {
            request.getSession().setAttribute("error", "Voce nao tem permissao para acessar essa area!");
            response.sendRedirect("home");
        } else {
        
            String action = request.getParameter("action");

            if(action == null) index(request, response);
            else {
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
    
    
    // Controle de rota GET para index route.
    protected void index(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
            ArrayList<Object> res = new ArrayList<>();    
        
            AdministradorDAO adminDAO = new AdministradorDAO();
            UsuarioDAO userDAO = new UsuarioDAO();
            
            adminDAO.getAll().forEach((admin) -> {
                res.add(admin);
            });
            
            userDAO.getAll().forEach((user) -> {
                res.add(user);
            });
        
            request.getSession().setAttribute("users", res);
            
            request.getRequestDispatcher(this.resource + "index.jsp").forward(request, response);
    }
    
    
    // Controle de rota POST para armazenar no bd.
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
            if(user != null || admin != null) throw new CPFCadastradoException();
            else {
                
                // Validar campos do formulario
                if(!validate.validateNull(nome)) throw new NullTextInputException("nome");
                if(!validate.validateNull(cpf)) throw new NullTextInputException("cpf");
                if(!validate.validateNull(senha)) throw new NullTextInputException("senha");
                if(userRole == null) throw new RoleException();
                if(!validate.validateText(nome, 20)) throw new MaxLengthTextInputException("nome", 20);
                if(!validate.validateTextEqualsLength(cpf, 14)) throw new EqualsLengthTextInputException("cpf", 11);
                if(validate.validateText(senha, 2)) throw new MinLengthTextInputException("senha", 2);
                
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
            
        } catch (CPFCadastradoException | MaxLengthTextInputException | EqualsLengthTextInputException | MinLengthTextInputException | RoleException | NullTextInputException err) {
            request.getSession().setAttribute("error", err.getMessage());
            response.sendRedirect("home");
        }
    }
    
    // Controle de rota GET para suspender usuario.
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
    
    // Controle de rota GET para exibir usuario.
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

                    request.getRequestDispatcher(this.resource + "show.jsp").forward(request, response);
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

                    request.getRequestDispatcher(this.resource + "show.jsp").forward(request, response);
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
    
    // Controle de rota GET para pagina de edicao.
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

                    request.getRequestDispatcher(this.resource + "edit.jsp").forward(request, response);
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

                    request.getRequestDispatcher(this.resource + "edit.jsp").forward(request, response);
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
    
    // Controle de rota GET para atualizar no bd.
    protected void update(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            UsuarioDAO userDAO = new UsuarioDAO();
            AdministradorDAO adminDAO = new AdministradorDAO();
            User user;
            UserFormValidate validate = new UserFormValidate();
            
            int id = Integer.parseInt(request.getParameter("id"));
            String nome = request.getParameter("nome");
            String cpf = request.getParameter("cpf");

            
            if(request.getParameter("admin") == null && request.getParameter("admin") != "true") {
                user = userDAO.getByID(id);
            } else {
                user = adminDAO.getByID(id);
            }
            
            if(user == null) throw new UserNotFoundException();
            
            if(adminDAO.getByCPF(cpf) != null && id != adminDAO.getByCPF(cpf).getId() || userDAO.getByCPF(cpf) != null && id != userDAO.getByCPF(cpf).getId()) throw new CPFCadastradoException();
            
            // Validar campos do formulario
            if(!validate.validateNull(nome)) throw new NullTextInputException("nome");
            if(!validate.validateNull(cpf)) throw new NullTextInputException("cpf");
            if(!validate.validateText(nome, 20)) throw new MaxLengthTextInputException("nome", 20);
            if(!validate.validateTextEqualsLength(cpf, 14)) throw new EqualsLengthTextInputException("cpf", 11);
            
            user.setNome(nome);
            user.setCpf(cpf);
            if(user.isAdmin()) adminDAO.update((Administrador) user); 
            else userDAO.update((Usuario) user);

            request.getSession().setAttribute("success", "Usuario atualizado no sistema!");
            response.sendRedirect("home");
            
        } catch(NumberFormatException e) {
            request.getSession().setAttribute("error", "ID informado nao eh um inteiro.");
            response.sendRedirect("home");
        } catch(UserNotFoundException | CPFCadastradoException | NullTextInputException | MaxLengthTextInputException | EqualsLengthTextInputException err) {
            request.getSession().setAttribute("error", err.getMessage());
            response.sendRedirect("home");
        }
    }
    
    // Controle de rota POST para remover no bd.
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
                    throw new UserNotFoundException();
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
                        throw new UserNotFoundException();
                    } else {
                        request.getSession().setAttribute("error", "Voce nao pode se remover do sistema!");
                        response.sendRedirect("home");
                    }
                }
            }
            
            
        } catch(NumberFormatException e) {
            request.getSession().setAttribute("error", "ID informado nao eh um inteiro.");
            response.sendRedirect("home");
        } catch(UserNotFoundException err) {
            request.getSession().setAttribute("error", err.getMessage());
            response.sendRedirect("home");
        }
    }
}
