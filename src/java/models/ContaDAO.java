/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import app.Conta;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author Diogo
 */
public class ContaDAO {
    
    public boolean store(Conta acc) {
        Connect conn = new Connect();
        boolean stored = false;
        try {
            PreparedStatement stmt = conn.getConn().prepareStatement("INSERT INTO contas (id_usuario, nome_conta, banco, agencia, conta_corrente) VALUES (?,?,?,?,?)");
            stmt.setInt(1, acc.getUserId());
            stmt.setString(2, acc.getNome());
            stmt.setString(3, acc.getBanco());
            stmt.setString(4, acc.getAgencia());
            stmt.setString(5, acc.getConta());
            stmt.execute();
            stored = true;
        } catch(SQLException e) {
            System.out.println("DAO contasStore error.");
            System.out.println(e);
        } finally {
            conn.closeConn();
        }
        return stored;
    }
    
    public ArrayList<Conta> getAll() {
        
        Connect conn = new Connect();    
        ArrayList<Conta> res = new ArrayList<>();
        
        try {
            PreparedStatement stmt = conn.getConn().prepareStatement("SELECT * FROM contas");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Conta acc = new Conta();
                acc.setId(rs.getInt("id"));
                acc.setUserId(rs.getInt("id_usuario"));
                acc.setNome(rs.getString("nome_conta"));
                acc.setBanco(rs.getString("banco"));
                acc.setAgencia(rs.getString("agencia"));
                acc.setConta(rs.getString("conta_corrente"));
                res.add(acc);
            }
        } catch (SQLException e) {
            System.out.println("Erro de SQL: " + e.getMessage());
        } finally {
            conn.closeConn();
        }
        
        return res;
    }
    
    public Conta getByID(int id) {
        Connect conn = new Connect();
        Conta acc = new Conta();
        try {
            PreparedStatement stmt = conn.getConn().prepareStatement("SELECT * FROM contas WHERE id = ? limit 1");
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if(rs.next()) {
                acc.setId(rs.getInt("id"));
                acc.setUserId(rs.getInt("id_usuario"));
                acc.setNome(rs.getString("nome_conta"));
                acc.setBanco(rs.getString("banco"));
                acc.setAgencia(rs.getString("agencia"));
                acc.setConta(rs.getString("conta_corrente"));
            } else {
                acc = null;
            }
        } catch(SQLException e) {
            System.out.println("DAO getContasByID error.");
            System.out.println(e);
        } finally {
            conn.closeConn();
        }
        return acc;
    }
    
    public ArrayList<Conta> getByUserID(int id) {
        
        Connect conn = new Connect();    
        ArrayList<Conta> res = new ArrayList<>();
        
        try {
            PreparedStatement stmt = conn.getConn().prepareStatement("SELECT * FROM contas WHERE id_usuario = ?");
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Conta acc = new Conta();
                acc.setId(rs.getInt("id"));
                acc.setUserId(rs.getInt("id_usuario"));
                acc.setNome(rs.getString("nome_conta"));
                acc.setBanco(rs.getString("banco"));
                acc.setAgencia(rs.getString("agencia"));
                acc.setConta(rs.getString("conta_corrente"));
                res.add(acc);
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
            PreparedStatement stmt = conn.getConn().prepareStatement("DELETE FROM contas WHERE id = ?");
            stmt.setInt(1, id);
            stmt.execute();
        } catch(SQLException e) {
            System.out.println("DAO deleteContas error");
        } finally {
            conn.closeConn();
        }
    }
    
}
