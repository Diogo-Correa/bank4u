/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import app.Lancamento;
import app.LancamentoEvent;
import app.util.errors.*;
import app.util.validate.LancamentoFormValidate;
import com.google.gson.Gson;
import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
        
        String action = request.getParameter("action");
        
        switch(action) {
                    case "lancamentos":
                        getLancamentos(request,response);
                        break;
                    case "delete":
                        delete(request,response);
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
        
        String action = request.getParameter("action");
        
        switch(action) {
                    case "update":
                        update(request,response);
                        break;
        }
}
    
    protected void getLancamentos(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        float total = 0, totalDebitos = 0, totalCreditos = 0;
        
        LancamentoDAO lancDAO = new LancamentoDAO();
        ArrayList<LancamentoEvent> lancamentos = new ArrayList<>();
        
        for(Lancamento lanc : lancDAO.getByContaID(Integer.parseInt(request.getParameter("conta")))) {
            LancamentoEvent event = new LancamentoEvent(lanc.getId(), lanc.getCategoriaId(), lanc.getCategoria().getDescricao(), lanc.getData(), lanc.getData() , (lanc.isCredit()) ? "#4ff04f" : "#f04f62", (lanc.isCredit()) ? lanc.getValor() : -lanc.getValor(), lanc.getOperacao(), lanc.getDescricao());
            total += event.getValor();
            if(lanc.isCredit()) totalCreditos += event.getValor();
            else totalDebitos += event.getValor();
            lancamentos.add(event);
        }
        
        String json = new Gson().toJson(lancamentos);
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
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
    
    protected void delete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            
            LancamentoDAO lancDAO = new LancamentoDAO();
            Lancamento lanc = lancDAO.getByID(id);
            
            if(lanc == null) throw new EntryNotFoundException();
            else {
                lancDAO.delete(id);

                request.getSession().setAttribute("success", "Lancamento removido do sistema!");
                response.sendRedirect("home");
            }
        } catch(NumberFormatException e) {
            request.getSession().setAttribute("error", "ID informado nao eh um inteiro.");
            response.sendRedirect("home");
        } catch(EntryNotFoundException err) {
            request.getSession().setAttribute("error", err.getMessage());
            response.sendRedirect("home");
        }
    }

}
