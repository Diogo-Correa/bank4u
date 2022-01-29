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
public class AdminDeleteEntriesException extends Exception {
    public AdminDeleteEntriesException() {
        super("O administrador nao pode remover lancamentos bancarios de uma conta. Para autorizar habilite a opcao 'AllowAdminDeleteEntries' na pagina settings.");
    }
}
