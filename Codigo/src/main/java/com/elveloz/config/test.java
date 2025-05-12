
package com.elveloz.config;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;


public class test {
    public static void main(String[] args) {
        String input = "123";
        System.out.println("Contraseña encriptada: " + md5encryp(input));
    
    
    }
    
    public static String md5encryp(String input) {
        String output = "";
        
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] digest = md.digest(input.getBytes());
            StringBuilder sb = new StringBuilder();
            
            for(byte b : digest) {
                sb.append(String.format("%02x",b));
            }
            
            output = sb.toString();
            
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
        
        return output;
    }
    
   
    
}
