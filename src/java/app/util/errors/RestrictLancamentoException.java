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
public class RestrictLancamentoException extends Exception {
    public RestrictLancamentoException() {
        super("Essa categoria possui lancamentos, remova-os para efetuar a exclusao da categoria.");
    }
}
