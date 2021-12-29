/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package app.util.validate;

/**
 *
 * @author Diogo
 */
public interface FormValidate {
    public boolean validateText(String value, int maxLength);
    public boolean validateTextEqualsLength(String value, int maxLength);
    public boolean validateNumber();
}
