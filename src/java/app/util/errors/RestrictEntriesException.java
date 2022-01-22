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
public class RestrictEntriesException extends Exception {
    public RestrictEntriesException() {
        super("Essa conta possui lancamentos, remova-os para efetuar a exclusao da conta.");
    }
}
