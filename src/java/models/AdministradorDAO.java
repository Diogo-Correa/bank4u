/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import app.Administrador;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Diogo
 */
public class AdministradorDAO {
    
    public boolean store(Administrador user) {
        Connect conn = new Connect();
        boolean stored = false;
        try {
            PreparedStatement stmt = conn.getConn().prepareStatement("INSERT INTO administradores (nome, cpf, senha) VALUES (?,?,?)");
            stmt.setString(1, user.getNome());
            stmt.setString(2, user.getCpf());
            stmt.setString(3, user.getSenha());
            stmt.execute();
            stored = true;
        } catch(SQLException e) {
            System.out.println("DAO adminStore error.");
            System.out.println(e);
        } finally {
            conn.closeConn();
        }
        return false;
    }
    
    public Administrador getAdministradorAuth(String login, String senha) {
        Connect conn = new Connect();
        Administrador admin = new Administrador();
        try {
            PreparedStatement stmt = conn.getConn().prepareStatement("SELECT * FROM administradores WHERE cpf = ? AND senha = ? limit 1");
            stmt.setString(1, login);
            stmt.setString(2, senha);
            ResultSet rs = stmt.executeQuery();
            if(rs.next()) {
                admin.setId(rs.getInt("id")); 
                admin.setNome(rs.getString("nome")); 
                admin.setCpf(rs.getString("cpf")); 
                admin.setSenha(rs.getString("senha"));
            } else {
                admin = null;
            }
        } catch(SQLException e) {
            System.out.println("DAO getAdministradorAuth error.");
            System.out.println(e);
        } finally {
            conn.closeConn();
        }
        return admin;
    }
    
}
