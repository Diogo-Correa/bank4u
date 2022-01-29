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
public class AdminDeleteAccException extends Exception {
    public AdminDeleteAccException() {
        super("O administrador nao pode remover contas bancarias de um usuario. Para autorizar habilite a opcao 'AllowAdminDeleteBankAcc' na pagina settings.");
    }
}
