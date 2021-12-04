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

    public Usuario getUsuarioAuth(String login, String senha) {
        Usuario usuario = null;
        try {
            PreparedStatement stmt = conexao.prepareStatement("SELECT * FROM usuarios WHERE cpf = ? AND senha = ? limit 1");
            stmt.setString(1, login);
            stmt.setString(2, senha);
            ResultSet rs = stmt.executeQuery();
            if(rs.next()) {
                usuario = new Usuario(rs.getInt("id"), rs.getString("nome"), rs.getString("cpf"), rs.getString("senha"), rs.getString("suspenso"));
            }
        } catch(SQLException e) {
            System.out.println("DAO getUsuarioAuth error.");
            System.out.println(e);
        }
        return usuario;
    }
}