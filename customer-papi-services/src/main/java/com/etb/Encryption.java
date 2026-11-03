package com.etb;

import java.nio.charset.StandardCharsets;
import java.security.SecureRandom;
import java.util.Base64;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

public class Encryption {

    public static String[] AESEncrypter(String text, String secret) throws Exception {
        if (text == null || text.isEmpty()) return new String[] {"", ""};

        try {
            SecretKeySpec keySpec = getKey(secret);
            byte[] iv = getIV();
            Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
            cipher.init(Cipher.ENCRYPT_MODE, keySpec, new IvParameterSpec(iv));

            byte[] encrypted = cipher.doFinal(text.getBytes(StandardCharsets.UTF_8));
            String cipherBase64 = Base64.getEncoder().encodeToString(encrypted);
            String ivBase64 = getIvBase64(iv);

            return new String[] {cipherBase64, ivBase64};
        } catch (Exception e) {
            return new String[] {"", ""};
        }
    }

    public static String AESDecrypter(String text, String ivBase64, String secret) throws Exception {
        if (text == null || text.isEmpty() || ivBase64 == null || ivBase64.isEmpty()) {
            return "";
        }

        try {
            SecretKeySpec keySpec = getKey(secret);

            String ivHex = new String(Base64.getDecoder().decode(ivBase64), StandardCharsets.UTF_8);
            byte[] ivBytes = parseHex(ivHex);

            Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
            cipher.init(Cipher.DECRYPT_MODE, keySpec, new IvParameterSpec(ivBytes));

            byte[] decodedCipher = Base64.getDecoder().decode(text);
            byte[] original = cipher.doFinal(decodedCipher);

            return new String(original, StandardCharsets.UTF_8);

        } catch (Exception e) {
            return "";
        }
    }

    public static byte[] getIV() {
        byte[] iv = new byte[16];
        new SecureRandom().nextBytes(iv);
        return iv;
    }

    public static String getIvBase64(byte[] iv) {
        StringBuilder hexString = new StringBuilder();
        for (byte b : iv) {
            String hex = Integer.toHexString(0xFF & b);
            if (hex.length() == 1) {
                hexString.append('0');
            }
            hexString.append(hex);
        }
        String ivHex = hexString.toString();
        return Base64.getEncoder().encodeToString(ivHex.getBytes(StandardCharsets.UTF_8));
    }

    public static SecretKeySpec getKey(String secret) {
        byte[] keyBytes = secret.getBytes(StandardCharsets.UTF_8);
        return new SecretKeySpec(keyBytes, "AES");
    }

    private static byte[] parseHex(String hex) {
        int len = hex.length();
        byte[] data = new byte[len / 2];
        for (int i = 0; i < len; i += 2) {
            data[i / 2] = (byte) ((Character.digit(hex.charAt(i), 16) << 4)
                                 + Character.digit(hex.charAt(i+1), 16));
        }
        return data;
    }

    public static void main(String[] args) {
        String text = "{\r\n" + 
                        "\"Audit\": {\r\n" + 
                        "\"Canal\": \"TIENDA\"\r\n" + 
                        "},\r\n" + 
                        "\"Document_Number\": \"977468912\",\r\n" + 
                        "\"Document_Type\": \"CC\",\r\n" + 
                        "\"Num_Order\": \"\"\r\n" + 
                        "}";
        String secret = "59024f3b17705f9b9e0fea169f850d2a";

        try {
            String[] result = Encryption.AESEncrypter(text, secret);

            System.out.println("Encrypted Text: " + result[0]);
            System.out.println("IV: " + result[1]);

            String decryptedText = Encryption.AESDecrypter(result[0], result[1], secret);
            System.out.println("Decrypted Text: " + decryptedText);
        } catch (Exception e) {
            System.err.println("Encryption.encrypt threw an exception: " + e.getMessage());
        }
    }
}