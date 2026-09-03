package com.etb.security;

import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.security.KeyFactory;
import java.security.MessageDigest;
import java.security.PublicKey;
import java.security.Signature;
import java.security.spec.RSAPublicKeySpec;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

public class WbdSignatureValidator {

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

            String[] keyValue =
                    part.trim().split("=", 2);

            if (keyValue.length == 2) {

                String key =
                        keyValue[0].trim();

                String value =
                        keyValue[1].trim();

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

    public static String getKeyId(
            String signatureHeader) {

        Map<String, String> signatureValues =
                parseSignatureHeader(signatureHeader);

        return signatureValues.get("keyId");
    }

    public static PublicKey buildPublicKey(
            String modulus,
            String exponent) throws Exception {

        if (modulus == null ||
                modulus.trim().isEmpty()) {

            throw new IllegalArgumentException(
                    "JWKS modulus is empty"
            );
        }

        if (exponent == null ||
                exponent.trim().isEmpty()) {

            throw new IllegalArgumentException(
                    "JWKS exponent is empty"
            );
        }

        byte[] modulusBytes =
                Base64.getUrlDecoder()
                        .decode(modulus);

        byte[] exponentBytes =
                Base64.getUrlDecoder()
                        .decode(exponent);

        BigInteger modulusValue =
                new BigInteger(1, modulusBytes);

        BigInteger exponentValue =
                new BigInteger(1, exponentBytes);

        RSAPublicKeySpec keySpec =
                new RSAPublicKeySpec(
                        modulusValue,
                        exponentValue
                );

        KeyFactory keyFactory =
                KeyFactory.getInstance("RSA");

        return keyFactory.generatePublic(keySpec);
    }

    public static boolean validateRequest(
            String method,
            String host,
            String path,
            String date,
            String digest,
            String signatureHeader,
            String body,
            String modulus,
            String exponent) throws Exception {

        String calculatedDigest =
                generateDigest(body);

        if (digest == null ||
                !calculatedDigest.equals(digest)) {

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
                buildPublicKey(
                        modulus,
                        exponent
                );

        Signature verifier =
                Signature.getInstance(
                        "SHA512withRSA"
                );

        verifier.initVerify(rsaPublicKey);

        verifier.update(
                signingString.getBytes(
                        StandardCharsets.UTF_8
                )
        );

        byte[] signatureBytes =
                Base64.getDecoder()
                        .decode(signatureBase64);

        return verifier.verify(
                signatureBytes
        );
    }
}