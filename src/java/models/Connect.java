/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import app.configs.Configurations;
import java.io.IOException;
import java.util.Properties;
import java.sql.*;

/**
 *
 * @author Diogo
 */
public final class Connect {
    private static final String fileConfig = "database.properties";
    private static String driver = "";
    private static String url = "";
    private static String user = "";
    private static String pass = "";
    private Connection conn;
    
    public Connect() {
        try {
            Properties props = Configurations.getProps(fileConfig);
            driver = props.getProperty("DriverClassName");
            url = props.getProperty("DatabaseHost");
            user = props.getProperty("DatabaseUser");
            pass = props.getProperty("DatabasePassword");
            
            Class.forName(driver);
            conn = (Connection) DriverManager.getConnection(url, user, pass);
        } catch (IOException | ClassNotFoundException | SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    public Connection getConn() {
        return conn;
    }
    
    public void closeConn() {
        try {
            conn.close();
        } catch(SQLException e) {
            e.printStackTrace();
        }
    }
}
