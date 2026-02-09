package com.globant.cipher;

import java.nio.charset.StandardCharsets;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.text.ParseException;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

import javax.crypto.*;
import javax.crypto.spec.GCMParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import com.nimbusds.jose.EncryptionMethod;
import com.nimbusds.jose.JOSEException;
import com.nimbusds.jose.JWEAlgorithm;
import com.nimbusds.jose.JWEHeader;
import com.nimbusds.jose.JWEObject;
import com.nimbusds.jose.KeyLengthException;
import com.nimbusds.jose.Payload;
import com.nimbusds.jose.crypto.DirectDecrypter;
import com.nimbusds.jose.crypto.DirectEncrypter;

public class Encryption {
	
	public final static int GCM_TAG_LENGTH = 16;
	
	public Encryption() {
		
	}
	
	public static String processEncrypt(String message, String key, String customerIV) throws InvalidKeyException, NoSuchAlgorithmException, NoSuchPaddingException, InvalidAlgorithmParameterException, IllegalBlockSizeException, BadPaddingException, KeyLengthException, JOSEException  {
		byte[] keyByteArray = key.getBytes(StandardCharsets.UTF_8);
		byte[] iv = customerIV.getBytes(StandardCharsets.UTF_8);
		
		String encString = encryptString(message, keyByteArray, iv);
		String jwe = generateTokenJWE(encString, keyByteArray);
		
		return jwe;
	}
	
	public static String processDecrypt(String message, String key, String customerIV) throws ParseException, JOSEException, InvalidKeyException, InvalidAlgorithmParameterException, NoSuchAlgorithmException, NoSuchPaddingException, IllegalBlockSizeException, BadPaddingException {
		byte[] keyByteArray = key.getBytes(StandardCharsets.UTF_8);
		byte[] iv = customerIV.getBytes(StandardCharsets.UTF_8);
		
		String base64 = stringifyTokenJWE(message, keyByteArray);
		String stringFinal = decryptString(base64, keyByteArray, iv);
		
		return stringFinal;
	}
	
	public static String encryptString(String message, byte[] key, byte[] iv) throws NoSuchAlgorithmException, NoSuchPaddingException, InvalidKeyException, InvalidAlgorithmParameterException, IllegalBlockSizeException, BadPaddingException {
		
		Cipher cipher = Cipher.getInstance("AES/GCM/NoPadding");
		SecretKeySpec keySpec = new SecretKeySpec(key, "AES");
		//IvParameterSpec ivSpec = new IvParameterSpec(iv);
		GCMParameterSpec gcmParamseterSpec = new GCMParameterSpec(GCM_TAG_LENGTH * 8, iv);
		
		cipher.init(Cipher.ENCRYPT_MODE, keySpec, gcmParamseterSpec);
		byte[] plainBytes = message.getBytes(StandardCharsets.UTF_8);
		byte[] cipherBytes = cipher.doFinal(plainBytes);
		
		byte[] encrypted = new byte[iv.length + cipherBytes.length];
        System.arraycopy(iv, 0, encrypted, 0, iv.length);
        System.arraycopy(cipherBytes, 0, encrypted, iv.length, cipherBytes.length);
        
        // Return the Base64 encoded string
        return Base64.getEncoder().encodeToString(encrypted);
	}
	
	public static String decryptString(String cypher, byte[] key, byte[] iv) throws InvalidKeyException, InvalidAlgorithmParameterException, NoSuchAlgorithmException, NoSuchPaddingException, IllegalBlockSizeException, BadPaddingException {
		
		
		Cipher cipher = Cipher.getInstance("AES/GCM/NoPadding");
		SecretKeySpec keySpec = new SecretKeySpec(key, "AES");
		//IvParameterSpec ivSpec = new IvParameterSpec(iv);
		GCMParameterSpec gcmParamseterSpec = new GCMParameterSpec(GCM_TAG_LENGTH * 8, iv);
		
		cipher.init(Cipher.DECRYPT_MODE, keySpec, gcmParamseterSpec);
		byte[] encrypted = Base64.getDecoder().decode(cypher);
		byte[] message = new byte[encrypted.length - iv.length];
		System.arraycopy(encrypted, iv.length, message, 0, message.length);
		
		byte[] plainBytes = cipher.doFinal(message);
        
        return new String(plainBytes, StandardCharsets.UTF_8);
	}
	
	public static String generateTokenJWE(String payload, byte[] key) throws KeyLengthException, JOSEException {
		// Create a JWE header with the specified algorithm and encryption method
        JWEHeader header = new JWEHeader(JWEAlgorithm.DIR, EncryptionMethod.A256GCM);

        // Create the payload as a JSON object
        //Map<String, Object> jsonPayload = new HashMap<String, Object>();
        //jsonPayload.put("payload", payload);

        // Create a JWE object with the header and payload
        JWEObject jweObject = new JWEObject(header, new Payload(payload));

        // Encrypt the JWE object using the provided key
        jweObject.encrypt(new DirectEncrypter(key));

        // Serialize to compact form
        return jweObject.serialize();
	}
	
	public static String stringifyTokenJWE(String jweToken, byte[] key) throws JOSEException, ParseException {
        // Parse the JWE token
        JWEObject jweObject = JWEObject.parse(jweToken);

        // Decrypt the JWE object
        jweObject.decrypt(new DirectDecrypter(key));

        // Retrieve the payload
        Payload payload = jweObject.getPayload();

        // Return the payload as a string
        return payload.toString();
    }
}
