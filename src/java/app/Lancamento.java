/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package app;

import java.sql.Date;
import models.ContaDAO;
import models.CategoriaDAO;

/**
 *
 * @author Diogo
 */
public class Lancamento {
    private int id, id_conta, id_categoria;
    private Conta conta;
    private Categoria categoria;
    private float valor;
    private String operacao, descricao;
    private Date data;
    
    public int getId() {
        return this.id;
    }
    
    public void setId(int value) {
        this.id = value;
    }
    
    public int getContaId() {
        return this.id_conta;
    }
    
    public void setContaId(int value) {
        ContaDAO contaDAO = new ContaDAO();
        this.id_conta = value;
        this.conta = contaDAO.getByID(this.id_conta);
    }
    
    public Conta getConta() {
        return this.conta;
    }
    
    public int getCategoriaId() {
        return this.id_categoria;
    }
    
    public void setCategoriaId(int value) {
        CategoriaDAO categoriaDAO = new CategoriaDAO();
        this.id_categoria = value;
        this.categoria = categoriaDAO.getByID(this.id_categoria);
    }
    
    public Categoria getCategoria() {
        return this.categoria;
    }
    
    public float getValor() {
        return this.valor;
    }
    
    public void setValor(float value) {
        this.valor = value;
    }
    
    public String getOperacao() {
        return this.operacao;
    }
    
    public void setOperacao(String value) {
        this.operacao = value;
    }
    
    public boolean isCredit() {
        if(this.operacao.equals("C")) return true;
        return false;
    }
    
    public String getDescricao() {
        return this.descricao;
    }
    
    public void setDescricao(String value) {
        this.descricao = value;
    }
    
    public Date getData() {
        return this.data;
    }
    
    public void setData(Date value) {
        this.data = value;
    }
    
}
