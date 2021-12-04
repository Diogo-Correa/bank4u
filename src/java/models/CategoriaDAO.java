/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import app.Categoria;
import configs.Connect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 *
 * @author Diogo
 */
public class CategoriaDAO {
    private Connection conexao;
    
    public CategoriaDAO() {
        try {
            conexao = Connect.openConnection();
        } catch(SQLException e) {
            System.out.println("DAO connection error.");
            System.out.println(e);
        }
    }

    public boolean store(Categoria tag) {
        try {
            PreparedStatement stmt = conexao.prepareStatement("INSERT INTO categorias (descricao) VALUES (?)");
            stmt.setString(1, tag.getDescricao());
            stmt.execute();
        } catch(SQLException e) {
            System.out.println("DAO categoriaStore error.");
            System.out.println(e);
        }
        return false;
    }
    
}
