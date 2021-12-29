/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package app;

public class Usuario extends User {
    
    public Usuario() {
        setAdmin(false);
    }
    
    private String suspenso;
   
    public String getSuspenso() {
        return this.suspenso;
    }

    public void setSuspenso(String value) {
        this.suspenso = value;
    }
    
    public boolean isSuspenso() {
        if(this.suspenso.equals("S")) return true;
        return false;
    }
}
