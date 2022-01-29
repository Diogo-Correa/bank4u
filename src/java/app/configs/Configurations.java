/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package app.configs;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URISyntaxException;
import java.util.Properties;

/**
 *
 * @author Diogo
 */
public class Configurations {
    private static final String path = "/app/configs/";
    
    public static Properties getProps(String value) throws IOException {
        Properties props = new Properties();
        InputStream in = Configurations.class.getResourceAsStream("/app/configs/"+value);
        props.load(in);
        in.close();
        return props;
    }
    
    public static Properties setProps(String value, String property, String newValue) throws IOException, URISyntaxException {
        
        File file = new File(Configurations.class.getResource(path+value).toURI());
        Properties props = getProps(value);
        
        OutputStream out = new FileOutputStream(file);
        
        props.setProperty(property, newValue);
        props.store(out, null);
        out.close();
        
        return props;
    }
    
}
