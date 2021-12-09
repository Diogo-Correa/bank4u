/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import app.Categoria;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

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
    
    public ArrayList<Categoria> getAll() {
        
        Connect conn = new Connect();    
        ArrayList<Categoria> res = new ArrayList<>();
        
        try {
            PreparedStatement stmt = conn.getConn().prepareStatement("SELECT * FROM categorias");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Categoria tag = new Categoria();
                tag.setId(rs.getInt("id"));
                tag.setDescricao(rs.getString("descricao"));
                res.add(tag);
            }
        } catch (SQLException e) {
            System.out.println("Erro de SQL: " + e.getMessage());
        } finally {
            conn.closeConn();
        }
        
        return res;
    }
    
    public ArrayList<Categoria> getThreeTags() {
        
        Connect conn = new Connect();    
        ArrayList<Categoria> res = new ArrayList<>();
        
        try {
            PreparedStatement stmt = conn.getConn().prepareStatement("SELECT * FROM categorias ORDER BY id DESC limit 3");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Categoria tag = new Categoria();
                tag.setId(rs.getInt("id"));
                tag.setDescricao(rs.getString("descricao"));
                res.add(tag);
            }
        } catch (SQLException e) {
            System.out.println("Erro de SQL: " + e.getMessage());
        } finally {
            conn.closeConn();
        }
        
        return res;
    }
    
    public void delete(int id) {
        Connect conn = new Connect();
        try {
            PreparedStatement stmt = conn.getConn().prepareStatement("DELETE FROM categorias WHERE id = ?");
            stmt.setInt(1, id);
            stmt.execute();
        } catch(SQLException e) {
            System.out.println("DAO deleteCategories error");
        } finally {
            conn.closeConn();
        }
    }
    
}
