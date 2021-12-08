/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import app.Categoria;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 *
 * @author Diogo
 */
public class CategoriaDAO {
    
    public boolean store(Categoria tag) {
        Connect conn = new Connect();
        boolean stored = false;
        try {
            PreparedStatement stmt = conn.getConn().prepareStatement("INSERT INTO categorias (descricao) VALUES (?)");
            stmt.setString(1, tag.getDescricao());
            stmt.execute();
            stored = true;
        } catch(SQLException e) {
            System.out.println("DAO categoriaStore error.");
            System.out.println(e);
        } finally {
            conn.closeConn();
        }
        return false;
    }
    
}
