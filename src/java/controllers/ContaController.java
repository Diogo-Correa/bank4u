/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import app.Conta;
import app.Lancamento;
import app.LancamentoEvent;
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
        
        String action = request.getParameter("action");
        
        switch(action) {
                    case "lancamentos":
                        getLancamentos(request,response);
                        break;
                    case "total":
                        getTotal(request,response);
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
        
    }
    
    protected void getTotal(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        float total = 0, totalDebitos = 0, totalCreditos = 0;
        List<String> totais = new ArrayList<>();
        
        LancamentoDAO lancDAO = new LancamentoDAO();
        
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
        
        String json = new Gson().toJson(totais);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
    }
    
    protected void getLancamentos(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        float total = 0, totalDebitos = 0, totalCreditos = 0;
        
        LancamentoDAO lancDAO = new LancamentoDAO();
        ArrayList<LancamentoEvent> lancamentos = new ArrayList<>();
        
        for(Lancamento lanc : lancDAO.getByContaID(Integer.parseInt(request.getParameter("conta")))) {
            LancamentoEvent event = new LancamentoEvent(lanc.getCategoria().getDescricao(), lanc.getData(), lanc.getData() , (lanc.isCredit()) ? "#4ff04f" : "#f04f62", (lanc.isCredit()) ? lanc.getValor() : -lanc.getValor());
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

}
