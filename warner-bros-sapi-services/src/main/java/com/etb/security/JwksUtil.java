package com.etb.security;

import java.math.BigInteger;
import java.security.KeyFactory;
import java.security.PublicKey;
import java.security.interfaces.RSAPublicKey;
import java.security.spec.X509EncodedKeySpec;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

public class JwksUtil {

    public static String normalizePublicKey(String publicKey) {
        if (publicKey == null || publicKey.trim().isEmpty()) {
            throw new IllegalArgumentException("Public key is empty");
        }

        return publicKey.replace("\\n", "\n");
    }

    public static RSAPublicKey loadPublicKey(String publicKey) throws Exception {

        String normalizedKey = normalizePublicKey(publicKey);

        String cleanKey = normalizedKey
                .replace("-----BEGIN PUBLIC KEY-----", "")
                .replace("-----END PUBLIC KEY-----", "")
                .replaceAll("\\s", "");

        byte[] keyBytes = Base64.getDecoder().decode(cleanKey);

        X509EncodedKeySpec keySpec = new X509EncodedKeySpec(keyBytes);

        KeyFactory keyFactory = KeyFactory.getInstance("RSA");

        PublicKey key = keyFactory.generatePublic(keySpec);

        return (RSAPublicKey) key;
    }

    private static String base64UrlEncode(BigInteger value) {

        byte[] bytes = value.toByteArray();

        if (bytes.length > 1 && bytes[0] == 0) {
            byte[] unsignedBytes = new byte[bytes.length - 1];
            System.arraycopy(bytes, 1, unsignedBytes, 0, unsignedBytes.length);
            bytes = unsignedBytes;
        }

        return Base64.getUrlEncoder()
                .withoutPadding()
                .encodeToString(bytes);
    }

    public static Map<String, String> generateJwk(
            String publicKey,
            String keyId,
            String algorithm) throws Exception {

        RSAPublicKey rsaPublicKey = loadPublicKey(publicKey);

        Map<String, String> jwk = new HashMap<>();

        jwk.put("kty", "RSA");
        jwk.put("kid", keyId);
        jwk.put("use", "sig");
        jwk.put("n", base64UrlEncode(rsaPublicKey.getModulus()));
        jwk.put("e", base64UrlEncode(rsaPublicKey.getPublicExponent()));

        if (algorithm != null && !algorithm.trim().isEmpty()) {
            jwk.put("alg", algorithm);
        }

        return jwk;
    }
}