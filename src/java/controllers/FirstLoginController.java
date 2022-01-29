/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import app.configs.ScriptRunner;
import app.configs.Configurations;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.net.URISyntaxException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.Connect;


/**
 *
 * @author Diogo
 */
@WebServlet(name = "FirstLoginController", urlPatterns = {"/setup"})
public class FirstLoginController extends HttpServlet {
    private final String appConfig = "app.properties";
    private final String dbConfig = "database.properties";
    private final String adminConfig = "admin.properties";

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
        Properties appProps = Configurations.getProps(appConfig);
        Properties adminProps = Configurations.getProps(adminConfig);
        
        
        boolean firstAccess = Boolean.parseBoolean(appProps.getProperty("FirstLogin"));
        
        if(!firstAccess) response.sendRedirect("home");
        else {
            String action = request.getParameter("action");        

            if(action != null && action.equals("finalize")) {
                try {
                    Configurations.setProps(appConfig, "FirstLogin", "false");
                    response.sendRedirect("home");
                } catch(IOException | URISyntaxException err){

                }
            }   else {
                boolean allowAdminDeleteBankAcc = Boolean.parseBoolean(adminProps.getProperty("AllowAdminDeleteBankAcc"));
                boolean allowAdminDeleteEntries = Boolean.parseBoolean(adminProps.getProperty("AllowAdminDeleteEntries"));

                boolean allowModalInfoOnLogin = Boolean.parseBoolean(appProps.getProperty("AllowModalInfoOnLogin"));
                boolean showAlertNegativeAccounts = Boolean.parseBoolean(appProps.getProperty("ShowAlertNegativeAccounts"));
                boolean applicationDarkTheme = Boolean.parseBoolean(appProps.getProperty("ApplicationDarkTheme"));

                request.getSession().setAttribute("allowAdminDeleteBankAcc", allowAdminDeleteBankAcc);
                request.getSession().setAttribute("allowAdminDeleteEntries", allowAdminDeleteEntries);
                request.getSession().setAttribute("allowModalInfoOnLogin", allowModalInfoOnLogin);
                request.getSession().setAttribute("showAlertNegativeAccounts", showAlertNegativeAccounts);
                request.getSession().setAttribute("applicationDarkTheme", applicationDarkTheme);

                request.getRequestDispatcher("firstAccess.jsp").forward(request, response);
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
        String action = request.getParameter("action");
        
        switch(action) {
            case "dbTest":
                dbTest(request, response);
                break;
            case "dbSave":
                dbSave(request, response);
                break;
            case "dbInstall":
                dbInstall(request, response);
                break;
            case "update":
                update(request, response);
                break;
        }
    }
    
    protected void dbTest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        
        try {
            
            Connection conn;
            String driver = request.getParameter("driver");
            String url = request.getParameter("host");
            String user = request.getParameter("username");
            String pass = request.getParameter("password");
            
            Class.forName(driver);
            conn = (Connection) DriverManager.getConnection(url, user, pass);
            
            response.getWriter().write("ok!"); 
            
        } catch (ClassNotFoundException | SQLException err) {
            response.getWriter().write(err.getMessage());
        }
        
    }
    
    protected void dbSave(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        
        try {
            
            String driver = request.getParameter("driver");
            String url = request.getParameter("host");
            String user = request.getParameter("username");
            String pass = request.getParameter("password");
            
            
            Configurations.setProps(dbConfig, "DriverClassName", driver);
            Configurations.setProps(dbConfig, "DatabaseHost", url);
            Configurations.setProps(dbConfig, "DatabaseUser", user);
            Configurations.setProps(dbConfig, "DatabasePassword", pass);

            response.getWriter().write("ok!"); 
            
        } catch (URISyntaxException err) {
            response.getWriter().write(err.getMessage());
        }
        
    }
    
    protected void dbInstall(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        
        try {
            
            Connect conn = new Connect();
            
            ScriptRunner sr = new ScriptRunner(conn.getConn(), false, false);
            
            File admins = new File(Configurations.class.getResource("/app/configs/database/financeiro_administradores.sql").toURI());
            sr.runScript(new BufferedReader(new FileReader(admins)));
            
            File categorias = new File(Configurations.class.getResource("/app/configs/database/financeiro_categorias.sql").toURI());
            sr.runScript(new BufferedReader(new FileReader(categorias))); 
            
            File contas = new File(Configurations.class.getResource("/app/configs/database/financeiro_contas.sql").toURI());
            sr.runScript(new BufferedReader(new FileReader(contas)));
            
            File lancamentos = new File(Configurations.class.getResource("/app/configs/database/financeiro_lancamentos.sql").toURI());
            sr.runScript(new BufferedReader(new FileReader(lancamentos)));
            
            File usuarios = new File(Configurations.class.getResource("/app/configs/database/financeiro_usuarios.sql").toURI());
            sr.runScript(new BufferedReader(new FileReader(usuarios)));
            
            response.getWriter().write("ok!"); 
            
        } catch (URISyntaxException | SQLException err) {
            response.getWriter().write(err.getMessage());
        }
        
    }
    
    protected void update(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        
        try {
            if(request.getParameter("showModalInfoOnLogin") != null) {
                Configurations.setProps(appConfig, "AllowModalInfoOnLogin", request.getParameter("allowModalInfoOnLogin"));
                
                boolean allowModalInfoOnLogin = Boolean.parseBoolean(request.getParameter("allowModalInfoOnLogin"));
                request.getSession().setAttribute("allowModalInfoOnLogin", allowModalInfoOnLogin);
            }
            
            if(request.getParameter("showAlertNegativeAccounts") != null) {
                Configurations.setProps(appConfig, "ShowAlertNegativeAccounts", request.getParameter("showAlertNegativeAccounts"));
                
                boolean showAlertNegativeAccounts = Boolean.parseBoolean(request.getParameter("showAlertNegativeAccounts"));
                request.getSession().setAttribute("showAlertNegativeAccounts", showAlertNegativeAccounts);
            }
            
            if(request.getParameter("applicationDarkTheme") != null) {
                Configurations.setProps(appConfig, "ApplicationDarkTheme", request.getParameter("applicationDarkTheme"));
                
                boolean applicationDarkTheme = Boolean.parseBoolean(request.getParameter("applicationDarkTheme"));
                request.getSession().setAttribute("applicationDarkTheme", applicationDarkTheme);
            }

            if(request.getParameter("allowAdminDeleteBankAcc") != null) {
                Configurations.setProps(adminConfig, "AllowAdminDeleteBankAcc", request.getParameter("allowAdminDeleteBankAcc"));
                
                boolean allowAdminDeleteBankAcc = Boolean.parseBoolean(request.getParameter("allowAdminDeleteBankAcc"));
                request.getSession().setAttribute("allowAdminDeleteBankAcc", allowAdminDeleteBankAcc);
            }

            if(request.getParameter("allowAdminDeleteEntries") != null) {
                Configurations.setProps(adminConfig, "AllowAdminDeleteEntries", request.getParameter("allowAdminDeleteEntries"));
                
                boolean allowAdminDeleteEntries = Boolean.parseBoolean(request.getParameter("allowAdminDeleteEntries"));
                request.getSession().setAttribute("allowAdminDeleteEntries", allowAdminDeleteEntries);
            }
            response.getWriter().write("ok!"); 
        } catch(Exception err) {
            response.getWriter().write(err.getMessage()); 
            
        }
        
    }

}
