/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package app;

/**
 *
 * @author Diogo
 */
public abstract class User {
    
    private int id;
    private String nome, cpf, senha;
    private boolean admin;

    public int getId() {
        return this.id;
    }

    public void setId(int value) {
        this.id = value;
    }

    public String getNome() {
        return this.nome;
    }

    public void setNome(String value) {
        this.nome = value;
    }

    public String getCpf() {
        return this.cpf;
    }
    
    public void setCpf(String value) {
        this.cpf = value;
    }

    public String getSenha() {
        return this.senha;
    }
    
    public void setSenha(String value) {
        this.senha = value;
    }
    
    public boolean isAdmin() {
        return this.admin;
    }
    
    public void setAdmin(boolean value) {
        this.admin = value;
    }
    
}
