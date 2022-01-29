/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import app.configs.Configurations;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Diogo
 */
@WebServlet(name = "SettingsController", urlPatterns = {"/settings"})
public class SettingsController extends HttpServlet {
    private final String resource = "resources/settings/";
    private static final String adminConfig = "admin.properties";
    private static final String appConfig = "app.properties";


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
        if(request.getSession().getAttribute("authUser") == null || (request.getSession().getAttribute("isAdmin") == null || !(boolean) request.getSession().getAttribute("isAdmin")) || (!(boolean) request.getSession().getAttribute("isLoggedIn") || request.getSession().getAttribute("isLoggedIn") == null)) {
            request.getSession().setAttribute("error", "Voce nao tem permissao para acessar essa area!");
            response.sendRedirect("home");
        } else {
            String action = request.getParameter("action");
            if(action == null) request.getRequestDispatcher(this.resource + "index.jsp").forward(request, response);
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
        
        if(request.getSession().getAttribute("authUser") == null || (request.getSession().getAttribute("isAdmin") == null || !(boolean) request.getSession().getAttribute("isAdmin")) || (!(boolean) request.getSession().getAttribute("isLoggedIn") || request.getSession().getAttribute("isLoggedIn") == null)) {
            request.getSession().setAttribute("error", "Voce nao tem permissao para acessar essa area!");
            response.sendRedirect("home");
        } else {
            String action = request.getParameter("action");
            if(action == null) request.getRequestDispatcher(this.resource + "index.jsp").forward(request, response);

            switch(action) {
                case "update":
                    update(request, response);
            }
        }
        
    }
    
    protected void update(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            
            Properties appProps = Configurations.getProps(appConfig);
            Properties adminProps = Configurations.getProps(adminConfig);
            
            if(request.getParameter("AllowModalInfoOnLogin") != null) {
                Configurations.setProps(appConfig, "AllowModalInfoOnLogin", request.getParameter("AllowModalInfoOnLogin"));
                
                boolean allowModalInfoOnLogin = Boolean.parseBoolean(appProps.getProperty("AllowModalInfoOnLogin"));
                request.getSession().setAttribute("allowModalInfoOnLogin", allowModalInfoOnLogin);
            }
            
            if(request.getParameter("ShowAlertNegativeAccounts") != null) {
                Configurations.setProps(appConfig, "ShowAlertNegativeAccounts", request.getParameter("ShowAlertNegativeAccounts"));
                
                boolean showAlertNegativeAccounts = Boolean.parseBoolean(appProps.getProperty("ShowAlertNegativeAccounts"));
                request.getSession().setAttribute("showAlertNegativeAccounts", showAlertNegativeAccounts);
            }

            if(request.getParameter("AllowAdminDeleteBankAcc") != null) {
                Configurations.setProps(adminConfig, "AllowAdminDeleteBankAcc", request.getParameter("AllowAdminDeleteBankAcc"));
                
                boolean allowAdminDeleteBankAcc = Boolean.parseBoolean(adminProps.getProperty("AllowAdminDeleteBankAcc"));
                request.getSession().setAttribute("allowAdminDeleteBankAcc", allowAdminDeleteBankAcc);
            }

            if(request.getParameter("AllowAdminDeleteEntries") != null) {
                Configurations.setProps(adminConfig, "AllowAdminDeleteEntries", request.getParameter("AllowAdminDeleteEntries"));
                
                boolean allowAdminDeleteEntries = Boolean.parseBoolean(adminProps.getProperty("AllowAdminDeleteEntries"));
                request.getSession().setAttribute("allowAdminDeleteEntries", allowAdminDeleteEntries);
            }
        } catch(Exception err) {
            
        }
        
    }
    

}
