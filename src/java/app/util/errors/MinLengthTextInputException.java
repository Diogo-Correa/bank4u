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
public class MinLengthTextInputException extends Exception {
    public MinLengthTextInputException(String inputName, int maxLength) {
        super("O campo " + inputName + " deve ser maior que " + maxLength + " caracteres!");
    }
}
