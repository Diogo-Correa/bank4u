/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import app.Conta;
import app.Lancamento;
import app.User;
import app.util.errors.*;
import app.util.validate.ContaFormValidate;
import com.google.gson.Gson;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
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
@WebServlet(name = "ContasController", urlPatterns = {"/wallet"})
public class ContaController extends HttpServlet {

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
                        case "total":
                            getTotal(request,response);
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
    
    protected void store(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            ContaDAO accDAO = new ContaDAO();
            
            User usuario = (User) request.getSession().getAttribute("authUser");
            int id_usuario = usuario.getId();
            String nome_conta = request.getParameter("nome_conta");
            String banco = request.getParameter("banco");
            String agencia = request.getParameter("agencia");
            String conta_corrente = request.getParameter("conta_corrente")+ "-" + request.getParameter("digito");
            
            Conta acc = accDAO.getByAgenciaConta(agencia, conta_corrente);
            
            if(acc != null) throw new ContaCadastradaException();
            
            ContaFormValidate validate = new ContaFormValidate();

            if(!validate.validateNull(nome_conta)) throw new NullTextInputException("nome");
            if(!validate.validateText(nome_conta, 20)) throw new MaxLengthTextInputException("nome", 20);
            
            if(!validate.validateNull(banco)) throw new NullTextInputException("banco");
            if(!validate.validateText(banco, 3)) throw new MaxLengthTextInputException("banco", 3);
            
            if(!validate.validateNull(agencia)) throw new NullTextInputException("agencia");
            if(!validate.validateText(agencia, 6)) throw new MaxLengthTextInputException("agencia", 6);
            
            if(!validate.validateNull(request.getParameter("conta_corrente"))) throw new NullTextInputException("conta");
            if(!validate.validateText(request.getParameter("conta_corrente"), 4)) throw new MaxLengthTextInputException("conta", 4);
            
            if(!validate.validateNull(request.getParameter("digito"))) throw new NullTextInputException("digito");
            if(!validate.validateText(request.getParameter("digito"), 1)) throw new MaxLengthTextInputException("digito", 1);
            
            acc = new Conta();
            
            acc.setUserId(id_usuario);
            acc.setNome(nome_conta);
            acc.setBanco(banco);
            acc.setAgencia(agencia);
            acc.setConta(conta_corrente);
            accDAO.store(acc);

            request.getSession().setAttribute("success", "Conta adicionada ao sistema!");
            response.sendRedirect("home");
            
        } catch(NullTextInputException | MaxLengthTextInputException | ContaCadastradaException err) {
            request.getSession().setAttribute("error", err.getMessage());
            response.sendRedirect("home");
        }
        
    }
    
    protected void update(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            
            ContaDAO accDAO = new ContaDAO();
            Conta conta = accDAO.getByID(id);
            
            if(conta == null) throw new ContaNotFoundException();
            
            String nome_conta = request.getParameter("nome_conta");
            String banco = request.getParameter("banco");
            String agencia = request.getParameter("agencia");
            String conta_corrente = request.getParameter("conta_corrente")+ "-" + request.getParameter("digito");
            
            Conta acc = accDAO.getByAgenciaConta(agencia, conta_corrente);
            
            if(acc != null && acc.getId() != id) throw new ContaCadastradaException();
            
            ContaFormValidate validate = new ContaFormValidate();

            if(!validate.validateNull(nome_conta)) throw new NullTextInputException("nome");
            if(!validate.validateText(nome_conta, 20)) throw new MaxLengthTextInputException("nome", 20);
            
            if(!validate.validateNull(banco)) throw new NullTextInputException("banco");
            if(!validate.validateText(banco, 3)) throw new MaxLengthTextInputException("banco", 3);
            
            if(!validate.validateNull(agencia)) throw new NullTextInputException("agencia");
            if(!validate.validateText(agencia, 6)) throw new MaxLengthTextInputException("agencia", 6);
            
            if(!validate.validateNull(request.getParameter("conta_corrente"))) throw new NullTextInputException("conta");
            if(!validate.validateText(request.getParameter("conta_corrente"), 4)) throw new MaxLengthTextInputException("conta", 4);
            
            if(!validate.validateNull(request.getParameter("digito"))) throw new NullTextInputException("digito");
            if(!validate.validateText(request.getParameter("digito"), 1)) throw new MaxLengthTextInputException("digito", 1);
            
            conta.setNome(nome_conta);
            conta.setBanco(banco);
            conta.setAgencia(agencia);
            conta.setConta(conta_corrente);
            accDAO.update(conta);

            request.getSession().setAttribute("success", "Conta atualizada no sistema!");
            response.sendRedirect("profile");
            
        } catch(NumberFormatException e) {
            request.getSession().setAttribute("error", "ID informado nao eh um inteiro.");
            response.sendRedirect("profile");
        } catch(NullTextInputException | MaxLengthTextInputException | ContaNotFoundException | ContaCadastradaException err) {
            request.getSession().setAttribute("error", err.getMessage());
            response.sendRedirect("profile");
        }
        
    }
    
    protected void getTotal(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            float total = 0, totalDebitos = 0, totalCreditos = 0;
            List<String> totais = new ArrayList<>();

            LancamentoDAO lancDAO = new LancamentoDAO();
            ContaDAO accDAO = new ContaDAO();
            Conta conta = accDAO.getByID(Integer.parseInt(request.getParameter("conta")));
            User user = (User) request.getSession().getAttribute("authUser");

            if(conta == null) throw new ContaNotFoundException();
            if(conta.getUserId() != user.getId()) throw new AuthException();
            
            for(Lancamento lanc : lancDAO.getByContaID(Integer.parseInt(request.getParameter("conta")))) {
                if(lanc.isCredit()) {
                    total += lanc.getValor();
                    totalCreditos += lanc.getValor();
                } else {
                    total += -lanc.getValor();
                    totalDebitos += -lanc.getValor();
                }
            }

            totais.add(Float.toString(total));
            totais.add(Float.toString(totalDebitos));
            totais.add(Float.toString(totalCreditos));
            totais.add(conta.getBanco());

            String json = new Gson().toJson(totais);

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(json);
        } catch(Exception err) {
            //
        }
    }

        
    protected void delete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            User authUser = (User) request.getSession().getAttribute("authUser");
            
            int id = Integer.parseInt(request.getParameter("id"));
            
            ContaDAO contaDAO = new ContaDAO();
            Conta acc = contaDAO.getByID(id);
            
            if(acc == null) throw new ContaNotFoundException();
            
            if(authUser.isAdmin() && request.getSession().getAttribute("allowAdminDeleteBankAcc") != null && !(boolean) request.getSession().getAttribute("allowAdminDeleteBankAcc")) throw new AdminDeleteAccException();
            
            LancamentoDAO lancDAO = new LancamentoDAO();
            ArrayList<Lancamento> lancs = lancDAO.getByContaID(id);
            
            if(!lancs.isEmpty()) throw new RestrictEntriesException();
            
            else {
                contaDAO.delete(id);

                request.getSession().setAttribute("success", "Conta removida do sistema!");
                if(authUser.isAdmin()) response.sendRedirect("user");
                else response.sendRedirect("profile");
            }
        } catch(NumberFormatException e) {
            User authUser = (User) request.getSession().getAttribute("authUser");
            
            request.getSession().setAttribute("error", "ID informado nao eh um inteiro.");
            if(authUser.isAdmin()) response.sendRedirect("user");
            else response.sendRedirect("profile");
        } catch(ContaNotFoundException | RestrictEntriesException | AdminDeleteAccException err) {
            User authUser = (User) request.getSession().getAttribute("authUser");
            
            request.getSession().setAttribute("error", err.getMessage());
            
            if(authUser.isAdmin() && request.getSession().getAttribute("allowAdminDeleteBankAcc") != null && !(boolean) request.getSession().getAttribute("allowAdminDeleteBankAcc")) response.sendRedirect("settings");
            else if(authUser.isAdmin()) response.sendRedirect("user");
            else response.sendRedirect("profile");
        }
    }
    
}
