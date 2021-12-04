/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import configs.Connect;
import java.sql.*;

import app.Usuario;

/**
 *
 * @author Diogo
 */
public class UsuarioDAO {
    private Connection conexao;
    
    public UsuarioDAO() {
        try {
            conexao = Connect.openConnection();
        } catch(SQLException e) {
            System.out.println("DAO connection error.");
            System.out.println(e);
        }
    }

    public boolean store(Usuario user) {
        try {
            PreparedStatement stmt = conexao.prepareStatement("INSERT INTO usuarios (nome, cpf, senha, suspenso) VALUES (?,?,?,?)");
            stmt.setString(1, user.getNome());
            stmt.setString(2, user.getCpf());
            stmt.setString(3, user.getSenha());
            stmt.setString(4, "N");
            stmt.execute();
        } catch(SQLException e) {
            System.out.println("DAO userStore error.");
            System.out.println(e);
        }
        return false;
    }
    
    public Usuario getUsuarioAuth(String login, String senha) {
        Usuario user = new Usuario();
        try {
            PreparedStatement stmt = conexao.prepareStatement("SELECT * FROM usuarios WHERE cpf = ? AND senha = ? limit 1");
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
                return null;
            }
        } catch(SQLException e) {
            System.out.println("DAO getUsuarioAuth error.");
            System.out.println(e);
        }
        return user;
    }
}
