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
    private String title, start, end, color;
    private float valor;
    private boolean allDaySlot = true;
    
    public LancamentoEvent(String title, Date start, Date end, String color, float valor){
        this.title = title + " -> R$" + Float.toString(valor);
        this.start = start.toString();
        this.end = end.toString();
        this.color = color;
        this.valor = valor;
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
}
