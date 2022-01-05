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
public class Conta {
    private int id, id_usuario;
    private String nome_conta, banco, agencia, conta_corrente;
    private float total;
    
    public int getId() {
        return this.id;
    }
    
    public void setId(int value) {
        this.id = value;
    }
    
    public int getUserId() {
        return this.id_usuario;
    }
    
    public void setUserId(int value) {
        this.id_usuario = value;
    }
    
    public String getNome() {
        return this.nome_conta;
    }
    
    public void setNome(String value) {
        this.nome_conta = value;
    } 
    
    public String getBanco() {
        return this.banco;
    }
    
    public void setBanco(String value) {
        this.banco = value;
    }
    
    public String getAgencia() {
        return this.agencia;
    }
    
    public void setAgencia(String value) {
        this.agencia = value;
    }
    
    public String getConta() {
        return this.conta_corrente;
    }
    
    public void setConta(String value) {
        this.conta_corrente = value;
    }
    
    public float getTotal() {
        return this.total;
    }
    
    public void setTotal(float value) {
        this.total = value;
    }
}
