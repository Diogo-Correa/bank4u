/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import app.Administrador;
import configs.Connect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Diogo
 */
public class AdministradorDAO {
    private Connection conexao;
    
    public AdministradorDAO() {
        try {
            conexao = Connect.openConnection();
        } catch(SQLException e) {
            System.out.println("DAO connection error.");
            System.out.println(e);
        }
    }

    public Administrador getAdministradorAuth(String login, String senha) {
        Administrador administrador = null;
        try {
            PreparedStatement stmt = conexao.prepareStatement("SELECT * FROM administradores WHERE cpf = ? AND senha = ? limit 1");
            stmt.setString(1, login);
            stmt.setString(2, senha);
            ResultSet rs = stmt.executeQuery();
            if(rs.next()) {
                administrador = new Administrador(rs.getInt("id"), rs.getString("nome"), rs.getString("cpf"), rs.getString("senha"));
            }
        } catch(SQLException e) {
            System.out.println("DAO getAdministradorAuth error.");
            System.out.println(e);
        }
        return administrador;
    }
    
}
