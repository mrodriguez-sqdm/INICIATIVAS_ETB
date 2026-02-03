package com.etb.utils;

import java.security.*;

public class ConvertSHAJavaCode {

	public static String encryptInput(String input) throws Exception {

		byte[] textBytes = input.getBytes("UTF-8");
		MessageDigest md = MessageDigest.getInstance("SHA-256");
		byte[] textSHABytes = md.digest(textBytes);

		StringBuffer sbSHA = new StringBuffer();
		for (int idx = 0; idx < textSHABytes.length; ++idx) {
			sbSHA.append(Integer.toHexString((textSHABytes[idx] & 0xFF) | 0x100).substring(1, 3));
		}
		return sbSHA.toString();
	}
}
