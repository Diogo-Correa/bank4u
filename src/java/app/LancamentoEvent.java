/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package app;

import java.sql.Date;

/**
 *
 * @author Diogo
 */
public class LancamentoEvent {
    private int id, categoria;
    private String title, start, end, color, operacao, descricao;
    private float valor;
    
    public LancamentoEvent(int id, int categoria_id, String title, Date start, Date end, String color, float valor, String operacao, String descricao){
        this.id = id;
        this.categoria = categoria_id;
        this.title = title + " -> R$" + Float.toString(valor);
        this.start = start.toString();
        this.end = end.toString();
        this.color = color;
        this.valor = valor;
        this.operacao = operacao;
        this.descricao = descricao;
    }
    
    public int getId() {
        return this.id;
    }
    
    public int getCategoria() {
        return this.categoria;
    }
    
    public String getTitle() {
        return this.title;
    }
    
    public String getStart() {
        return this.start;
    }
    
    public String getEnd() {
        return this.end;
    }
    
    public String getColor() {
        return this.color;
    }
    
    public float getValor() {
        return this.valor;
    }
    
    public String getOperacao() {
        return this.operacao;
    }
    
    public String getDescricao() {
        return this.descricao;
    }
}
