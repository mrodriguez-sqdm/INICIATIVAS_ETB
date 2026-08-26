package com.etb.security;

import java.nio.charset.StandardCharsets;
import java.security.KeyFactory;
import java.security.MessageDigest;
import java.security.PublicKey;
import java.security.Signature;
import java.security.spec.X509EncodedKeySpec;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

public class WbdSignatureValidator {

    public static String normalizePublicKey(String publicKey) {
        if (publicKey == null || publicKey.trim().isEmpty()) {
            throw new IllegalArgumentException("Public key is empty");
        }

        return publicKey.replace("\\n", "\n");
    }

    public static PublicKey loadPublicKey(String publicKey) throws Exception {

        String normalizedKey = normalizePublicKey(publicKey);

        String cleanKey = normalizedKey
                .replace("-----BEGIN PUBLIC KEY-----", "")
                .replace("-----END PUBLIC KEY-----", "")
                .replaceAll("\\s", "");

        byte[] keyBytes = Base64.getDecoder().decode(cleanKey);

        X509EncodedKeySpec keySpec =
                new X509EncodedKeySpec(keyBytes);

        KeyFactory keyFactory =
                KeyFactory.getInstance("RSA");

        return keyFactory.generatePublic(keySpec);
    }

    public static String generateDigest(String body) throws Exception {

        String requestBody = body == null ? "" : body;

        MessageDigest messageDigest =
                MessageDigest.getInstance("SHA-512");

        byte[] digestBytes =
                messageDigest.digest(
                        requestBody.getBytes(StandardCharsets.UTF_8)
                );

        String digestBase64 =
                Base64.getEncoder().encodeToString(digestBytes);

        return "SHA-512=" + digestBase64;
    }

    public static Map<String, String> parseSignatureHeader(
            String signatureHeader) {

        if (signatureHeader == null ||
                signatureHeader.trim().isEmpty()) {

            throw new IllegalArgumentException(
                    "Signature header is empty"
            );
        }

        Map<String, String> values = new HashMap<>();

        String[] parts = signatureHeader.split(",");

        for (String part : parts) {

            String[] keyValue = part.trim().split("=", 2);

            if (keyValue.length == 2) {

                String key = keyValue[0].trim();

                String value = keyValue[1].trim();

                if (value.startsWith("\"") &&
                        value.endsWith("\"")) {

                    value = value.substring(
                            1,
                            value.length() - 1
                    );
                }

                values.put(key, value);
            }
        }

        return values;
    }

    public static boolean validateRequest(
            String method,
            String host,
            String path,
            String date,
            String digest,
            String signatureHeader,
            String body,
            String publicKey,
            String expectedKeyId) throws Exception {

        String calculatedDigest =
                generateDigest(body);

        if (!calculatedDigest.equals(digest)) {
            return false;
        }

        Map<String, String> signatureValues =
                parseSignatureHeader(signatureHeader);

        String keyId =
                signatureValues.get("keyId");

        String algorithm =
                signatureValues.get("algorithm");

        String headers =
                signatureValues.get("headers");

        String signatureBase64 =
                signatureValues.get("signature");

        if (keyId == null ||
                signatureBase64 == null ||
                headers == null) {

            return false;
        }

        if (expectedKeyId != null &&
                !expectedKeyId.trim().isEmpty() &&
                !expectedKeyId.equals(keyId)) {

            return false;
        }

        if (algorithm != null &&
                !"hs2019".equalsIgnoreCase(algorithm)) {

            return false;
        }

        String requestMethod =
                method.toUpperCase();

        String requestTarget =
                requestMethod + " " + path;

        String signingString =
                "host: " + host + "\n"
                + "date: " + date + "\n"
                + "(request-target): "
                + requestTarget + "\n"
                + "digest: " + digest;

        PublicKey rsaPublicKey =
                loadPublicKey(publicKey);

        Signature verifier =
                Signature.getInstance("SHA512withRSA");

        verifier.initVerify(rsaPublicKey);

        verifier.update(
                signingString.getBytes(
                        StandardCharsets.UTF_8
                )
        );

        byte[] signatureBytes =
                Base64.getDecoder()
                        .decode(signatureBase64);

        return verifier.verify(signatureBytes);
    }
}