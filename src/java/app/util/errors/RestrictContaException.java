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
public class RestrictContaException extends Exception {
    public RestrictContaException() {
        super("Esse usuario possui conta(s), remova-a(s) para efetuar a exclusao do usuario.");
    }
}
