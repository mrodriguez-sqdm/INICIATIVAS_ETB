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

    /*
     * ============================================================
     * GENERAR DIGEST SHA-512
     * ============================================================
     */
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

    /*
     * ============================================================
     * PARSEAR SIGNATURE HEADER
     * ============================================================
     */
    public static Map<String, String> parseSignatureHeader(
            String signatureHeader) {

        if (signatureHeader == null ||
                signatureHeader.trim().isEmpty()) {

            throw new IllegalArgumentException(
                    "Signature header is empty"
            );
        }

        Map<String, String> values =
                new HashMap<>();

        String[] parts =
                signatureHeader.split(",");

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

                    value =
                            value.substring(
                                    1,
                                    value.length() - 1
                            );
                }

                values.put(
                        key,
                        value
                );
            }
        }

        return values;
    }

    /*
     * ============================================================
     * OBTENER KEY ID
     * ============================================================
     */
    public static String getKeyId(
            String signatureHeader) {

        Map<String, String> signatureValues =
                parseSignatureHeader(
                        signatureHeader
                );

        return signatureValues.get(
                "keyId"
        );
    }

    /*
     * ============================================================
     * CONSTRUIR PUBLIC KEY DESDE JWKS
     * ============================================================
     */
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
                new BigInteger(
                        1,
                        modulusBytes
                );

        BigInteger exponentValue =
                new BigInteger(
                        1,
                        exponentBytes
                );

        RSAPublicKeySpec keySpec =
                new RSAPublicKeySpec(
                        modulusValue,
                        exponentValue
                );

        KeyFactory keyFactory =
                KeyFactory.getInstance(
                        "RSA"
                );

        return keyFactory.generatePublic(
                keySpec
        );
    }

    /*
     * ============================================================
     * VALIDAR REQUEST WBD
     * ============================================================
     */
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

        /*
         * ========================================================
         * 1. VALIDAR PARAMETROS REQUERIDOS
         * ========================================================
         */
        if (method == null ||
                host == null ||
                path == null ||
                date == null ||
                digest == null ||
                signatureHeader == null) {

            return false;
        }

        /*
         * ========================================================
         * 2. VALIDAR DIGEST DEL BODY
         * ========================================================
         */
        String calculatedDigest =
                generateDigest(body);

        if (!calculatedDigest.equals(digest)) {
            return false;
        }

        /*
         * ========================================================
         * 3. PARSEAR SIGNATURE HEADER
         * ========================================================
         */
        Map<String, String> signatureValues =
                parseSignatureHeader(
                        signatureHeader
                );

        String keyId =
                signatureValues.get(
                        "keyId"
                );

        String algorithm =
                signatureValues.get(
                        "algorithm"
                );

        String headers =
                signatureValues.get(
                        "headers"
                );

        String signatureBase64 =
                signatureValues.get(
                        "signature"
                );

        /*
         * ========================================================
         * 4. VALIDAR SIGNATURE HEADER
         * ========================================================
         */
        if (keyId == null ||
                signatureBase64 == null ||
                headers == null) {

            return false;
        }

        if (algorithm != null &&
                !"hs2019".equalsIgnoreCase(
                        algorithm
                )) {

            return false;
        }

        /*
         * ========================================================
         * 5. CONSTRUIR PUBLIC KEY DESDE JWKS
         * ========================================================
         */
        PublicKey rsaPublicKey =
                buildPublicKey(
                        modulus,
                        exponent
                );

        /*
         * ========================================================
         * 6. CONSTRUIR REQUEST TARGET
         * ========================================================
         *
         * Ejemplo:
         *
         * POST /v2/customer-products/event-listener
         */
        String requestTarget =
                method.toUpperCase() +
                        " " +
                        path;

        /*
         * ========================================================
         * 7. CONSTRUIR SIGNING STRING
         * ========================================================
         *
         * IMPORTANTE:
         * - Los nombres de los campos van en minuscula.
         * - Se utiliza \n entre cada campo.
         * - NO existe salto de linea despues del digest.
         */
        String signingString =
                "host: " + host + "\n"
                        + "date: " + date + "\n"
                        + "(request-target): "
                        + requestTarget + "\n"
                        + "digest: " + digest;

        /*
         * ========================================================
         * 8. DECODIFICAR SIGNATURE
         * ========================================================
         */
        byte[] signatureBytes =
                Base64.getDecoder()
                        .decode(
                                signatureBase64
                        );

        /*
         * ========================================================
         * 9. VALIDAR FIRMA RSA + SHA-512
         * ========================================================
         */
        Signature verifier =
                Signature.getInstance(
                        "SHA512withRSA"
                );

        verifier.initVerify(
                rsaPublicKey
        );

        verifier.update(
                signingString.getBytes(
                        StandardCharsets.UTF_8
                )
        );

        return verifier.verify(
                signatureBytes
        );
    }
}