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
public class UserFormValidate implements FormValidate {

    @Override
    public boolean validateText(String value, int maxLength) {
        if(value.length() <= maxLength) return true;
        return false;
    }
    
    @Override
    public boolean validateTextEqualsLength(String value, int maxLength) {
        if(value.length() == maxLength) return true;
        return false;
    }

    @Override
    public boolean validateNumber() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
}
