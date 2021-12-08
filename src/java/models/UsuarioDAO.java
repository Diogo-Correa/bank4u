/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import java.sql.*;

import app.Usuario;
import java.util.ArrayList;

/**
 *
 * @author Diogo
 */
public class UsuarioDAO {

    public boolean store(Usuario user) {
        Connect conn = new Connect();
        boolean stored = false;
        try {
            PreparedStatement stmt = conn.getConn().prepareStatement("INSERT INTO usuarios (nome, cpf, senha, suspenso) VALUES (?,?,?,?)");
            stmt.setString(1, user.getNome());
            stmt.setString(2, user.getCpf());
            stmt.setString(3, user.getSenha());
            stmt.setString(4, "N");
            stmt.execute();
            stored = true;
        } catch(SQLException e) {
            System.out.println("DAO userStore error.");
            System.out.println(e);
        } finally {
            conn.closeConn();
        }
        return stored;
    }
    
    public ArrayList<Usuario> getAll() {
        
        Connect conn = new Connect();    
        ArrayList<Usuario> res = new ArrayList<>();
        
        try {
            PreparedStatement stmt = conn.getConn().prepareStatement("SELECT * FROM usuarios");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                //Cria o objeto da classe Contato para armazenar os dados
                //que vieram do BD
                Usuario usuario = new Usuario();
                usuario.setId(rs.getInt("id"));
                usuario.setNome(rs.getString("nome"));
                res.add(usuario);
            }
        } catch (SQLException e) {
            System.out.println("Erro de SQL: " + e.getMessage());
        } finally {
            conn.closeConn();
        }
        
        
        return res;
    }
    
    public ArrayList<Usuario> getThreeUsers() {
        
        Connect conn = new Connect();    
        ArrayList<Usuario> res = new ArrayList<>();
        
        try {
            PreparedStatement stmt = conn.getConn().prepareStatement("SELECT * FROM usuarios ORDER BY id DESC limit 3");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Usuario usuario = new Usuario();
                usuario.setId(rs.getInt("id"));
                usuario.setNome(rs.getString("nome"));
                usuario.setCpf(rs.getString("cpf"));
                usuario.setSuspenso(rs.getString("suspenso"));
                res.add(usuario);
            }
        } catch (SQLException e) {
            System.out.println("Erro de SQL: " + e.getMessage());
        } finally {
            conn.closeConn();
        }
        
        
        return res;
    }
    
    
    public Usuario getUsuarioAuth(String login, String senha) {
        Connect conn = new Connect();
        Usuario user = new Usuario();
        try {
            PreparedStatement stmt = conn.getConn().prepareStatement("SELECT * FROM usuarios WHERE cpf = ? AND senha = ? limit 1");
            stmt.setString(1, login);
            stmt.setString(2, senha);
            ResultSet rs = stmt.executeQuery();
            if(rs.next()) {
                user.setId(rs.getInt("id")); 
                user.setNome(rs.getString("nome")); 
                user.setCpf(rs.getString("cpf")); 
                user.setSenha(rs.getString("senha"));
                user.setSuspenso(rs.getString("suspenso"));
            } else {
                user = null;
            }
        } catch(SQLException e) {
            System.out.println("DAO getUsuarioAuth error.");
            System.out.println(e);
        } finally {
            conn.closeConn();
        }
        return user;
    }
}
