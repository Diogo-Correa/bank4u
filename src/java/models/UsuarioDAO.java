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
    
    public ArrayList<Usuario> getSuspendUsers() {
        
        Connect conn = new Connect();    
        ArrayList<Usuario> res = new ArrayList<>();
        
        try {
            PreparedStatement stmt = conn.getConn().prepareStatement("SELECT * FROM usuarios WHERE suspenso = 'S'");
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
    
    public Usuario getByID(int id) {
        Connect conn = new Connect();
        Usuario user = new Usuario();
        try {
            PreparedStatement stmt = conn.getConn().prepareStatement("SELECT * FROM usuarios WHERE id = ? limit 1");
            stmt.setInt(1, id);
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
            System.out.println("DAO getUsuarioGetID error.");
            System.out.println(e);
        } finally {
            conn.closeConn();
        }
        return user;
    }
    
    public Usuario getByCPF(String cpf) {
        Connect conn = new Connect();
        Usuario user = new Usuario();
        try {
            PreparedStatement stmt = conn.getConn().prepareStatement("SELECT * FROM usuarios WHERE cpf = ? limit 1");
            stmt.setString(1, cpf);
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
            System.out.println("DAO getUsuarioGetCPF error.");
            System.out.println(e);
        } finally {
            conn.closeConn();
        }
        return user;
    }
    
    public Usuario update(Usuario user) {
        Connect conn = new Connect();
        try {
            PreparedStatement stmt = conn.getConn().prepareStatement("UPDATE usuarios SET nome = ?, cpf = ? WHERE id = ?");
            stmt.setString(1, user.getNome());
            stmt.setString(2, user.getCpf());
            stmt.setInt(3, user.getId());
            stmt.execute();
        } catch(SQLException e) {
            System.out.println("DAO updateUser error.");
            System.out.println(e);
        } finally {
            conn.closeConn();
        }
        return user;
    }
    
    public Usuario suspendUser(Usuario user) {
        Connect conn = new Connect();
        try {
            PreparedStatement stmt = conn.getConn().prepareStatement("UPDATE usuarios SET suspenso = ? WHERE id = ?");
            stmt.setString(1, (user.isSuspenso()) ? "N" : "S");
            stmt.setInt(2, user.getId());
            stmt.execute();
        } catch(SQLException e) {
            System.out.println("DAO suspendUser error.");
            System.out.println(e);
        } finally {
            conn.closeConn();
        }
        return user;
    }
    
    public void delete(int id) {
        Connect conn = new Connect();
        try {
            PreparedStatement stmt = conn.getConn().prepareStatement("DELETE FROM usuarios WHERE id = ?");
            stmt.setInt(1, id);
            stmt.execute();
        } catch(SQLException e) {
            System.out.println("DAO deleteUser error");
        } finally {
            conn.closeConn();
        }
    }
}
