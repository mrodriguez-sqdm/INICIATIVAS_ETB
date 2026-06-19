package com.etb.gcp;

import javax.crypto.Cipher;
import javax.crypto.spec.GCMParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import java.util.Base64;

public class AesDecryptHelper {

    public static String decrypt(String encryptedPassword, String iv, String secretKey) throws Exception {

        byte[] encryptedBytes = Base64.getDecoder().decode(encryptedPassword);
        byte[] ivBytes = Base64.getDecoder().decode(iv);
        byte[] keyBytes = Base64.getDecoder().decode(secretKey);

        SecretKeySpec keySpec = new SecretKeySpec(keyBytes, "AES");
        GCMParameterSpec gcmSpec = new GCMParameterSpec(128, ivBytes);

        Cipher cipher = Cipher.getInstance("AES/GCM/NoPadding");
        cipher.init(Cipher.DECRYPT_MODE, keySpec, gcmSpec);

        byte[] decryptedBytes = cipher.doFinal(encryptedBytes);

        return new String(decryptedBytes, "UTF-8");
    }
}