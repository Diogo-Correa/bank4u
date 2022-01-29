/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import app.Lancamento;
import app.Conta;
import app.LancamentoEvent;
import app.User;
import app.util.errors.*;
import app.util.validate.LancamentoFormValidate;
import com.google.gson.Gson;
import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.ContaDAO;
import models.LancamentoDAO;

/**
 *
 * @author Diogo
 */
@WebServlet(name = "LancamentoController", urlPatterns = {"/entries"})
public class LancamentoController extends HttpServlet {

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
        
        if(request.getSession().getAttribute("authUser") == null || !(boolean) request.getSession().getAttribute("isLoggedIn") || request.getSession().getAttribute("isLoggedIn") == null) {
            request.getSession().invalidate();
            request.getSession().setAttribute("error", "Voce nao tem permissao para acessar essa area!");
            response.sendRedirect("home");
        } else {
            String action = request.getParameter("action");

            switch(action) {
                        case "lancamentos":
                            getLancamentos(request,response);
                            break;
                        case "deleteAll":
                            deleteAll(request,response);
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
        
        if(request.getSession().getAttribute("authUser") == null || !(boolean) request.getSession().getAttribute("isLoggedIn") || request.getSession().getAttribute("isLoggedIn") == null) {
            request.getSession().invalidate();
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
    
    protected void getLancamentos(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            
            ContaDAO contaDAO = new ContaDAO();
            int id = Integer.parseInt(request.getParameter("conta"));
            Conta conta = contaDAO.getByID(id);
            
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            LancamentoDAO lancDAO = new LancamentoDAO();
            ArrayList<LancamentoEvent> lancamentos = new ArrayList<>();

            lancDAO.getByContaID(id).stream().map((lanc) -> new LancamentoEvent(lanc.getId(), lanc.getCategoriaId(), lanc.getCategoria().getDescricao(), lanc.getData(), lanc.getData() , (lanc.isCredit()) ? "#4ff04f" : "#f04f62", (lanc.isCredit()) ? lanc.getValor() : -lanc.getValor(), lanc.getOperacao(), lanc.getDescricao())).forEachOrdered((event) -> {
                lancamentos.add(event);
            });

            String json = new Gson().toJson(lancamentos);

            response.getWriter().write(json);
    }
    
    protected void store(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id_conta = Integer.parseInt(request.getParameter("id_conta")); // tratar NumberFormatException e ContaNotFoundException
            int id_categoria = Integer.parseInt(request.getParameter("id_categoria")); // tratar NumberFormatException e CategoryNotFoundException
            float valor = Float.parseFloat(request.getParameter("valor")); // tratar NumberFormatException
            String operacao = request.getParameter("operacao");
            Date data = Date.valueOf(request.getParameter("data"));
            String descricao = request.getParameter("descricao");
            
            LancamentoDAO lancDAO = new LancamentoDAO();
            
            LancamentoFormValidate validate = new LancamentoFormValidate();

            if(!validate.validateNull(request.getParameter("id_conta"))) throw new NullTextInputException("conta");
            if(!validate.validateNull(request.getParameter("id_categoria"))) throw new NullTextInputException("categoria");
            
            if(!validate.validateNull(request.getParameter("valor"))) throw new NullTextInputException("valor");
            if(!validate.validateNull(request.getParameter("data"))) throw new NullTextInputException("data");
            
            
            if(!validate.validateOperation(operacao)) throw new OperacaoNotFoundException();
            if(!validate.validateNull(operacao)) throw new NullTextInputException("operacao");
            
            
            if(!validate.validateText(descricao, 100)) throw new MaxLengthTextInputException("descricao", 100);
            
            
            Lancamento lanc = new Lancamento();
            
            lanc.setContaId(id_conta);
            lanc.setCategoriaId(id_categoria);
            lanc.setValor(valor);
            lanc.setData(data);
            lanc.setOperacao(operacao);
            lanc.setDescricao(descricao);
            lancDAO.store(lanc);

            request.getSession().setAttribute("success", "Lancamento adicionado na conta!");
            response.sendRedirect("home");
            
        } catch(NumberFormatException err) {
            request.getSession().setAttribute("error", "ID informado nao eh um inteiro.");
            response.sendRedirect("home");
        } catch (MaxLengthTextInputException | NullTextInputException | OperacaoNotFoundException err) {
            request.getSession().setAttribute("error", err.getMessage());
            response.sendRedirect("home");
        }
    }
    
    protected void update(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            int id_categoria = Integer.parseInt(request.getParameter("id_categoria")); // tratar NumberFormatException e CategoryNotFoundException
            float valor = Float.parseFloat(request.getParameter("valor")); // tratar NumberFormatException
            String operacao = request.getParameter("operacao");
            Date data = Date.valueOf(request.getParameter("data"));
            String descricao = request.getParameter("descricao");
            
            LancamentoDAO lancDAO = new LancamentoDAO();
            Lancamento lanc = lancDAO.getByID(id);
            
            LancamentoFormValidate validate = new LancamentoFormValidate();

            if(!validate.validateNull(request.getParameter("id_categoria"))) throw new NullTextInputException("categoria");
            
            if(!validate.validateNull(request.getParameter("valor"))) throw new NullTextInputException("valor");
            if(!validate.validateNull(request.getParameter("data"))) throw new NullTextInputException("data");
            
            
            if(!validate.validateOperation(operacao)) throw new OperacaoNotFoundException();
            if(!validate.validateNull(operacao)) throw new NullTextInputException("operacao");
            
            
            if(!validate.validateText(descricao, 100)) throw new MaxLengthTextInputException("descricao", 100);

            if(lanc != null) {
                lanc.setCategoriaId(id_categoria);
                lanc.setValor(valor);
                lanc.setData(data);
                lanc.setOperacao(operacao);
                lanc.setDescricao(descricao);
                lancDAO.update(lanc);

                request.getSession().setAttribute("success", "Lancamento atualizado no sistema!");
                response.sendRedirect("home");
            } else {
                throw new EntryNotFoundException();
            }
            
        } catch(NumberFormatException err) {
            request.getSession().setAttribute("error", "ID informado nao eh um inteiro.");
            response.sendRedirect("home");
        } catch (MaxLengthTextInputException | NullTextInputException | EntryNotFoundException | OperacaoNotFoundException err) {
            request.getSession().setAttribute("error", err.getMessage());
            response.sendRedirect("home");
        }
    }
    
    
    protected void deleteAll(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            User authUser = (User) request.getSession().getAttribute("authUser");
            int id = Integer.parseInt(request.getParameter("id"));
            
            LancamentoDAO lancDAO = new LancamentoDAO();
            ArrayList<Lancamento> lancs = lancDAO.getByContaID(id);
            
            if(authUser.isAdmin() && request.getSession().getAttribute("allowAdminDeleteEntries") != null && !(boolean) request.getSession().getAttribute("allowAdminDeleteEntries")) throw new AdminDeleteEntriesException();
            
            if(lancs.isEmpty()) throw new EntryNotFoundException();
            else {
                
                lancs.forEach((lanc) -> {
                    lancDAO.delete(lanc.getId());
                });

                request.getSession().setAttribute("success", "Lancamentos removidos da conta!");
                if(authUser.isAdmin()) response.sendRedirect("user");
                else response.sendRedirect("home");
            }
        } catch(NumberFormatException e) {
            User authUser = (User) request.getSession().getAttribute("authUser");
            
            request.getSession().setAttribute("error", "ID informado nao eh um inteiro.");
            if(authUser.isAdmin()) response.sendRedirect("user");
            else response.sendRedirect("profile");
        } catch(EntryNotFoundException | AdminDeleteEntriesException err) {
            User authUser = (User) request.getSession().getAttribute("authUser");
            
            request.getSession().setAttribute("error", err.getMessage());
            
            if(authUser.isAdmin() &&  request.getSession().getAttribute("allowAdminDeleteEntries") != null && !(boolean) request.getSession().getAttribute("allowAdminDeleteEntries")) response.sendRedirect("settings");
            else if(authUser.isAdmin()) response.sendRedirect("user");
            else response.sendRedirect("profile");
        }
    }
    
    protected void delete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            User authUser = (User) request.getSession().getAttribute("authUser");
            int id = Integer.parseInt(request.getParameter("id"));
            
            LancamentoDAO lancDAO = new LancamentoDAO();
            Lancamento lanc = lancDAO.getByID(id);
            
            if(authUser.isAdmin() && request.getSession().getAttribute("allowAdminDeleteEntries") != null && !(boolean) request.getSession().getAttribute("allowAdminDeleteEntries")) throw new AdminDeleteEntriesException();
            
            if(lanc == null) throw new EntryNotFoundException();
            else {
                lancDAO.delete(id);

                request.getSession().setAttribute("success", "Lancamento removido do sistema!");
                if(authUser.isAdmin()) response.sendRedirect("user");
                else response.sendRedirect("home");
            }
        } catch(NumberFormatException e) {
            User authUser = (User) request.getSession().getAttribute("authUser");
            
            request.getSession().setAttribute("error", "ID informado nao eh um inteiro.");
            if(authUser.isAdmin()) response.sendRedirect("user");
            else response.sendRedirect("home");
        } catch(EntryNotFoundException | AdminDeleteEntriesException err) {
            User authUser = (User) request.getSession().getAttribute("authUser");
            
            request.getSession().setAttribute("error", err.getMessage());
            
            if(authUser.isAdmin() && request.getSession().getAttribute("allowAdminDeleteEntries") != null && !(boolean) request.getSession().getAttribute("allowAdminDeleteEntries")) response.sendRedirect("settings");
            if(authUser.isAdmin()) response.sendRedirect("user");
            else response.sendRedirect("home");
        }
    }

}
