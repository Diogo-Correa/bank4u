/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import app.Lancamento;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author Diogo
 */
public class LancamentoDAO {
    
    public boolean store(Lancamento lanc) {
        Connect conn = new Connect();
        boolean stored = false;
        try {
            PreparedStatement stmt = conn.getConn().prepareStatement("INSERT INTO lancamentos (id_conta, id_categoria, valor, operacao, data, descricao) VALUES (?,?,?,?,?,?)");
            stmt.setInt(1, lanc.getContaId());
            stmt.setInt(2, lanc.getCategoriaId());
            stmt.setFloat(3, lanc.getValor());
            stmt.setString(4, lanc.getOperacao());
            stmt.setDate(5, lanc.getData());
            stmt.setString(6, lanc.getDescricao());
            stmt.execute();
            stored = true;
        } catch(SQLException e) {
            System.out.println("DAO lancamentoStore error.");
            System.out.println(e);
        } finally {
            conn.closeConn();
        }
        return stored;
    }
    
    public ArrayList<Lancamento> getAll() {
        
        Connect conn = new Connect();    
        ArrayList<Lancamento> res = new ArrayList<>();
        
        try {
            PreparedStatement stmt = conn.getConn().prepareStatement("SELECT * FROM lancamentos");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Lancamento lanc = new Lancamento();
                lanc.setId(rs.getInt("id"));
                lanc.setContaId(rs.getInt("id_conta"));
                lanc.setCategoriaId(rs.getInt("id_categoria"));
                lanc.setValor(rs.getFloat("valor"));
                lanc.setOperacao(rs.getString("operacao"));
                lanc.setData(rs.getDate("data"));
                lanc.setDescricao(rs.getString("descricao"));
                res.add(lanc);
            }
        } catch (SQLException e) {
            System.out.println("Erro de SQL: " + e.getMessage());
        } finally {
            conn.closeConn();
        }
        
        return res;
    }
    
    public Lancamento getByID(int id) {
        Connect conn = new Connect();
        Lancamento lanc = new Lancamento();
        try {
            PreparedStatement stmt = conn.getConn().prepareStatement("SELECT * FROM lancamentos WHERE id = ? limit 1");
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if(rs.next()) {
                lanc.setId(rs.getInt("id"));
                lanc.setContaId(rs.getInt("id_conta"));
                lanc.setCategoriaId(rs.getInt("id_categoria"));
                lanc.setValor(rs.getFloat("valor"));
                lanc.setOperacao(rs.getString("operacao"));
                lanc.setData(rs.getDate("data"));
                lanc.setDescricao(rs.getString("descricao"));
            } else {
                lanc = null;
            }
        } catch(SQLException e) {
            System.out.println("DAO getContasByID error.");
            System.out.println(e);
        } finally {
            conn.closeConn();
        }
        return lanc;
    }
    
    public ArrayList<Lancamento> getByContaID(int id) {
        
        Connect conn = new Connect();    
        ArrayList<Lancamento> res = new ArrayList<>();
        
        try {
            PreparedStatement stmt = conn.getConn().prepareStatement("SELECT * FROM lancamentos WHERE id_conta = ?");
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Lancamento lanc = new Lancamento();
                lanc.setId(rs.getInt("id"));
                lanc.setContaId(rs.getInt("id_conta"));
                lanc.setCategoriaId(rs.getInt("id_categoria"));
                lanc.setValor(rs.getFloat("valor"));
                lanc.setOperacao(rs.getString("operacao"));
                lanc.setData(rs.getDate("data"));
                lanc.setDescricao(rs.getString("descricao"));
                res.add(lanc);
            }
        } catch (SQLException e) {
            System.out.println("Erro de SQL: " + e.getMessage());
        } finally {
            conn.closeConn();
        }
        
        return res;
    }
    
    public Lancamento update(Lancamento lanc) {
        Connect conn = new Connect();
        try {
            PreparedStatement stmt = conn.getConn().prepareStatement("UPDATE lancamentos SET id_categoria = ?, valor = ?, operacao = ?, data = ?, descricao = ? WHERE id = ?");
            stmt.setInt(1, lanc.getCategoriaId());
            stmt.setFloat(2, lanc.getValor());
            stmt.setString(3, lanc.getOperacao());
            stmt.setDate(4, lanc.getData());
            stmt.setString(5, lanc.getDescricao());
            stmt.setInt(6, lanc.getId());
            stmt.execute();
        } catch(SQLException e) {
            System.out.println("DAO updateLancamento error.");
            System.out.println(e);
        } finally {
            conn.closeConn();
        }
        return lanc;
    }
    
    public void delete(int id) {
        Connect conn = new Connect();
        try {
            PreparedStatement stmt = conn.getConn().prepareStatement("DELETE FROM lancamentos WHERE id = ?");
            stmt.setInt(1, id);
            stmt.execute();
        } catch(SQLException e) {
            System.out.println("DAO deleteLancamentos error");
        } finally {
            conn.closeConn();
        }
    }
    
}
