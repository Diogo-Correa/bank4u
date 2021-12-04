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
public class Administrador {
    private int id;
    private String nome, cpf, senha;

    public Administrador(int id, String nome, String cpf, String senha) {
        this.id = id;
        this.nome = nome;
        this.cpf = cpf;
        this.senha = senha;
    }

    public int getId() {
        return this.id;
    }

    public void setId(int id) {
        this.id = id;
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
}
