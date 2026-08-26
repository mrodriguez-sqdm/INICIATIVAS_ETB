package com.etb.security;

import java.nio.charset.StandardCharsets;
import java.security.KeyFactory;
import java.security.PrivateKey;
import java.security.Signature;
import java.security.spec.PKCS8EncodedKeySpec;
import java.util.Base64;

public class WbdJwtUtil {

    public static String generateJwt(
            String claimsJson,
            String privateKeyPem,
            String keyId) throws Exception {

        if (claimsJson == null || claimsJson.trim().isEmpty()) {
            throw new IllegalArgumentException("Claims JSON cannot be null or empty");
        }

        if (privateKeyPem == null || privateKeyPem.trim().isEmpty()) {
            throw new IllegalArgumentException("Private key cannot be null or empty");
        }

        if (keyId == null || keyId.trim().isEmpty()) {
            throw new IllegalArgumentException("Key ID cannot be null or empty");
        }

        String headerJson =
                "{\"alg\":\"RS256\",\"typ\":\"JWT\",\"kid\":\""
                + escapeJson(keyId)
                + "\"}";

        String encodedHeader = base64UrlEncode(
                headerJson.getBytes(StandardCharsets.UTF_8));

        String encodedPayload = base64UrlEncode(
                claimsJson.getBytes(StandardCharsets.UTF_8));

        String signingInput = encodedHeader + "." + encodedPayload;

        PrivateKey privateKey = loadPrivateKey(privateKeyPem);

        Signature signature = Signature.getInstance("SHA256withRSA");
        signature.initSign(privateKey);
        signature.update(signingInput.getBytes(StandardCharsets.UTF_8));

        String encodedSignature = base64UrlEncode(signature.sign());

        return signingInput + "." + encodedSignature;
    }

    private static PrivateKey loadPrivateKey(String privateKeyPem) throws Exception {

        String normalizedKey = privateKeyPem
                .replace("-----BEGIN PRIVATE KEY-----", "")
                .replace("-----END PRIVATE KEY-----", "")
                .replace("\\n", "")
                .replace("\\r", "")
                .replaceAll("\\s", "");

        byte[] keyBytes = Base64.getDecoder().decode(normalizedKey);

        PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(keyBytes);

        KeyFactory keyFactory = KeyFactory.getInstance("RSA");

        return keyFactory.generatePrivate(keySpec);
    }

    private static String base64UrlEncode(byte[] data) {
        return Base64.getUrlEncoder()
                .withoutPadding()
                .encodeToString(data);
    }

    private static String escapeJson(String value) {
        return value
                .replace("\\", "\\\\")
                .replace("\"", "\\\"");
    }
}