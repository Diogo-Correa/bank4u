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
public class NullTextInputException extends Exception {
    public NullTextInputException(String value) {
        super("O campo " + value + " nao pode ser nulo!");
    }
}
