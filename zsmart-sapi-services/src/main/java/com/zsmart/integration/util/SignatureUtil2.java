package com.zsmart.integration.util;

import java.nio.charset.StandardCharsets;
import java.security.KeyFactory;
import java.security.PrivateKey;
import java.security.Signature;
import java.security.spec.PKCS8EncodedKeySpec;
import java.util.Base64;

public class SignatureUtil2 {

	private SignatureUtil2() {
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

		// 1. Construir la cadena de texto base
		String rawString = appCode + "&" + appSecret + "&" + responseType + "&" + timestamp;

		// 2. Reconstruir la clave privada RSA (PKCS#8) desde Base64
		byte[] keyBytes = Base64.getDecoder().decode(privateKeyBase64);
		PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(keyBytes);
		KeyFactory keyFactory = KeyFactory.getInstance("RSA");
		PrivateKey privateKey = keyFactory.generatePrivate(keySpec);

		// 3. Inicializar la clase nativa Signature con el algoritmo MD5withRSA
		Signature signatureEngine = Signature.getInstance("MD5withRSA");
		signatureEngine.initSign(privateKey);
		
		// Pasar el string original directamente (Signature se encarga del Hash internamente)
		signatureEngine.update(rawString.getBytes(StandardCharsets.UTF_8));
		byte[] signatureBytes = signatureEngine.sign();

		// 4. Retornar el resultado codificado en Base64
		return Base64.getEncoder().encodeToString(signatureBytes);
	}
}

