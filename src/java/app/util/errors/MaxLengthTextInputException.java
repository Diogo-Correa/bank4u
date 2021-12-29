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
public class MaxLengthTextInputException extends Exception {
    public MaxLengthTextInputException(String inputName, int maxLength) {
        super("O campo " + inputName + " nao pode ultrapassar " + maxLength + " caracteres!");
    }
}
