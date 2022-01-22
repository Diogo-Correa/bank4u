/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package app.util.errors;

/**
 *
 * @author Diogo
 */
public class ContaNotFoundException extends Exception {
    public ContaNotFoundException() {
        super("Conta nao cadastrada no sistema!");
    }
}
