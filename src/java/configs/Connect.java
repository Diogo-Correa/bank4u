/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package configs;

import java.sql.*;

/**
 *
 * @author Diogo
 */
public final class Connect {
    private static Connection conexao = null;
    private static final String user = "root";
    private static final String pass = "root";
    private static final String url = "jdbc:mysql://localhost:3306/financeiro";
    
    public static Connection openConnection() throws SQLException {
        if(conexao == null) {
            try {
                Class.forName("com.mysql.jdbc.Driver");
                System.out.println("MySQL driver has been loaded.");
                conexao = DriverManager.getConnection(url, user, pass);
                System.out.println("Connection successfully!");
            } catch(ClassNotFoundException e) {
                System.out.println("Driver not found!");
            }
        }
        return conexao;
    }
    
}
