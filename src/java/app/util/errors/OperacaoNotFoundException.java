package app.util.errors;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Diogo
 */
public class OperacaoNotFoundException extends Exception {
    public OperacaoNotFoundException() {
        super("Operacao invalida!");
    }
}
