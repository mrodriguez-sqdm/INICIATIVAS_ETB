package com.etb;

import java.security.MessageDigest;
import java.util.Arrays;
import java.util.Base64;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;

public class EncryptionUtils {


    public static String encrypt(String message, String inputKey) throws Exception {
        //Generate keys
        final SecretKey key = generateKeys(inputKey);
        
        //Initialization of 3DES algorithm using 8byte padding, cipher block chaining
        final Cipher cipher = Cipher.getInstance("DESede/ECB/PKCS5Padding");
        cipher.init(Cipher.ENCRYPT_MODE, key);

        final byte[] plainTextBytes = message.getBytes("utf-8");
        final byte[] cipherText = cipher.doFinal(plainTextBytes);

        byte[] encoded = Base64.getEncoder().encode(cipherText);
        return new String(encoded);
    }

    public static String decrypt(String message, String inputKey) throws Exception {
       //Generate keys
        final SecretKey key = generateKeys(inputKey);

        //Initialization of 3DES algorithm using 8byte padding, cipher block chaining
        final Cipher decipher = Cipher.getInstance("DESede/ECB/PKCS5Padding");
        decipher.init(Cipher.DECRYPT_MODE, key);

        byte[] decoded = Base64.getDecoder().decode(message);
        final byte[] plainText = decipher.doFinal(decoded);

        return new String(plainText, "UTF-8");
    }

    private static SecretKey generateKeys(String key) throws Exception {

        final MessageDigest md = MessageDigest.getInstance("md5");
        final byte[] digestOfPassword = md.digest(key
                .getBytes("utf-8"));
        //3-8byte array (3 8byte keys)
        final byte[] keyBytes = Arrays.copyOf(digestOfPassword, 24);
        //k1 = k3
        for (int j = 0, k = 16; j < 8;) {
            keyBytes[k++] = keyBytes[j++];
        }

        //Generation of keys for the 3DES algorithm
        return new SecretKeySpec(keyBytes, "DESede");
    }
}