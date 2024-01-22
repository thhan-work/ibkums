package com.ibk.msg.utils;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class SHA256 {

	
	public static void main(String[] args) {
		String str = "1q!01000000000";
		String enc_str = "";
		String enc_str2 = "";
		 
		enc_str = SHA256.encrypt(str);
		enc_str2 = SHA256.encrypt(str);
		System.out.println("enc_str : " + enc_str);
		System.out.println("enc_str2 : " + enc_str2); 

	}

	
	public static String encrypt(String planText) {
        try{
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            md.update(planText.getBytes());
            byte byteData[] = md.digest();

            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < byteData.length; i++) {
                sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
            }
            StringBuffer hexString = new StringBuffer();
            for (int i=0;i<byteData.length;i++) {
                String hex=Integer.toHexString(0xff & byteData[i]);
                if(hex.length()==1){
                    hexString.append('0');
                }
                hexString.append(hex);
            }
            return hexString.toString();
        }catch(Exception e){
            e.printStackTrace();
            throw new RuntimeException();
        }
    }	
}
