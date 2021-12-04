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
public class Categoria {
    private int id;
    private String descricao;
    
    public int getId() {
        return this.id;
    }
    
    public void setId(int value) {
        this.id = value;
    }
    
    public String getDescricao() {
        return this.descricao;
    }
    
    public void setDescricao(String value) {
        this.descricao = value;
    }
}
