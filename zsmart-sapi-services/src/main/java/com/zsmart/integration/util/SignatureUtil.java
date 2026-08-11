package com.zsmart.integration.util;

import java.security.KeyFactory;
import java.security.MessageDigest;
import java.security.PrivateKey;
import java.security.spec.PKCS8EncodedKeySpec;
import java.util.Base64;
import javax.crypto.Cipher;

public class SignatureUtil {

	private SignatureUtil() {
	}

	/**
	 * @param appCode
	 * @param appSecret
	 * @param responseType
	 * @param timestamp
	 * @param privateKeyBase64
	 * @return Firma Base64
	 */
	public static String generateSignature(String appCode, String appSecret, String responseType, String timestamp,
			String privateKeyBase64) throws Exception {

		String rawString = appCode + "&" + appSecret + "&" + responseType + "&" + timestamp;

		// 1. MD5 del string base
		MessageDigest md5Digest = MessageDigest.getInstance("MD5");
		byte[] md5Bytes = md5Digest.digest(rawString.getBytes("UTF-8"));
		String md5Hex = bytesToHex(md5Bytes);

		// 2. Cifrado RSA del hash con la clave privada
		byte[] keyBytes = Base64.getDecoder().decode(privateKeyBase64);
		PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(keyBytes);
		KeyFactory keyFactory = KeyFactory.getInstance("RSA");
		PrivateKey privateKey = keyFactory.generatePrivate(keySpec);

		Cipher cipher = Cipher.getInstance("RSA/ECB/PKCS1Padding");
		cipher.init(Cipher.ENCRYPT_MODE, privateKey);
		byte[] encrypted = cipher.doFinal(md5Hex.getBytes("UTF-8"));

		// 3. Resultado en Base64
		return Base64.getEncoder().encodeToString(encrypted);
	}

	private static String bytesToHex(byte[] bytes) {
		StringBuilder sb = new StringBuilder(bytes.length * 2);
		for (byte b : bytes) {
			sb.append(String.format("%02x", b));
		}
		return sb.toString();
	}
}
