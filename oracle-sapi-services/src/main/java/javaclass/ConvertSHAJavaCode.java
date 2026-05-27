package javaclass;
import java.io.*;
import java.security.NoSuchAlgorithmException;

public class ConvertSHAJavaCode {
	public static String shaToJava(String text) throws NoSuchAlgorithmException, UnsupportedEncodingException {
    	
		byte[] textBytes = text.getBytes("UTF-8");
		java.security.MessageDigest md = java.security.MessageDigest.getInstance("SHA-256");
		byte[] textSHABytes = md.digest(textBytes);
		StringBuffer sbSHA = new StringBuffer();
		for (int idx = 0; idx < textSHABytes.length; ++idx)  {
		    sbSHA.append(Integer.toHexString((textSHABytes[idx] & 0xFF) | 0x100).substring(1,3));
		}
		return sbSHA.toString();
    }
}
