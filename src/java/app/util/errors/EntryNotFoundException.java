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
public class EntryNotFoundException extends Exception {
    public EntryNotFoundException() {
        super("Lancamento nao encontrado no sistema!");
    }
}
