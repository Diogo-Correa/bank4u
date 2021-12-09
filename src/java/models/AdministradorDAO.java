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
import java.util.ArrayList;

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
    
    public ArrayList<Administrador> getAll() {
        
        Connect conn = new Connect();    
        ArrayList<Administrador> res = new ArrayList<>();
        
        try {
            PreparedStatement stmt = conn.getConn().prepareStatement("SELECT * FROM administradores");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Administrador admin = new Administrador();
                admin.setId(rs.getInt("id"));
                admin.setNome(rs.getString("nome"));
                admin.setCpf(rs.getString("cpf"));
                res.add(admin);
            }
        } catch (SQLException e) {
            System.out.println("Erro de SQL: " + e.getMessage());
        } finally {
            conn.closeConn();
        }
        
        
        return res;
    }
    
    public ArrayList<Administrador> getThreeAdmins() {
        
        Connect conn = new Connect();    
        ArrayList<Administrador> res = new ArrayList<>();
        
        try {
            PreparedStatement stmt = conn.getConn().prepareStatement("SELECT * FROM administradores ORDER BY id DESC limit 3");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Administrador admin = new Administrador();
                admin.setId(rs.getInt("id"));
                admin.setNome(rs.getString("nome"));
                admin.setCpf(rs.getString("cpf"));
                res.add(admin);
            }
        } catch (SQLException e) {
            System.out.println("Erro de SQL: " + e.getMessage());
        } finally {
            conn.closeConn();
        }
        
        
        return res;
    }
    
    public Administrador getByID(int id) {
        Connect conn = new Connect();
        Administrador admin = new Administrador();
        try {
            PreparedStatement stmt = conn.getConn().prepareStatement("SELECT * FROM administradores WHERE id = ? limit 1");
            stmt.setInt(1, id);
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
            System.out.println("DAO getUsuarioAuth error.");
            System.out.println(e);
        } finally {
            conn.closeConn();
        }
        return admin;
    }
    
    public void delete(int id) {
        Connect conn = new Connect();
        try {
            PreparedStatement stmt = conn.getConn().prepareStatement("DELETE FROM administradores WHERE id = ?");
            stmt.setInt(1, id);
            stmt.execute();
        } catch(SQLException e) {
            System.out.println("DAO deleteAdmin error");
        } finally {
            conn.closeConn();
        }
    }
    
}
