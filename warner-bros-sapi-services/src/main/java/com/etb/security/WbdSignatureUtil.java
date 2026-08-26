package com.etb.security;

import java.nio.charset.StandardCharsets;
import java.security.KeyFactory;
import java.security.MessageDigest;
import java.security.PrivateKey;
import java.security.Signature;
import java.security.spec.PKCS8EncodedKeySpec;
import java.time.ZonedDateTime;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;
import java.util.Base64;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

public class WbdSignatureUtil {

    /**
     * Convierte los caracteres literales \n almacenados en propiedades
     * en saltos de línea reales.
     */
    public static String normalizePrivateKey(String privateKey) {

        if (privateKey == null || privateKey.trim().isEmpty()) {
            throw new IllegalArgumentException("Private key is empty");
        }

        return privateKey.replace("\\n", "\n");
    }


    /**
     * Convierte una llave privada PEM PKCS8 en un objeto PrivateKey RSA.
     */
    public static PrivateKey loadPrivateKey(String privateKey) throws Exception {

        String normalizedKey = normalizePrivateKey(privateKey);

        String cleanKey = normalizedKey
                .replace("-----BEGIN PRIVATE KEY-----", "")
                .replace("-----END PRIVATE KEY-----", "")
                .replaceAll("\\s", "");

        byte[] keyBytes =
                Base64.getDecoder().decode(cleanKey);

        PKCS8EncodedKeySpec keySpec =
                new PKCS8EncodedKeySpec(keyBytes);

        KeyFactory keyFactory =
                KeyFactory.getInstance("RSA");

        return keyFactory.generatePrivate(keySpec);
    }


    /**
     * Método simple para validar que Mule puede leer y cargar
     * correctamente la private key.
     */
    public static boolean validatePrivateKey(String privateKey) {

        try {

            loadPrivateKey(privateKey);

            return true;

        } catch (Exception e) {

            return false;
        }
    }


    /**
     * Genera los headers requeridos por WBD para un request firmado.
     *
     * Para POST:
     * host
     * date
     * (request-target)
     * digest
     *
     * Para GET:
     * host
     * date
     * (request-target)
     */
    public static Map<String, String> generateHeaders(
            String method,
            String host,
            String path,
            String keyId,
            String privateKey,
            String body) throws Exception {

        Map<String, String> result =
                new HashMap<>();


        // ======================================================
        // DATE
        // ======================================================

        ZonedDateTime now =
                ZonedDateTime.now(ZoneOffset.UTC);

        DateTimeFormatter formatter =
                DateTimeFormatter.ofPattern(
                        "EEE, dd MMM yyyy HH:mm:ss 'UTC'",
                        Locale.ENGLISH
                );

        String date =
                now.format(formatter);

        long created =
                now.toEpochSecond();


        // ======================================================
        // REQUEST TARGET
        // ======================================================

        String requestMethod =
                method.toUpperCase(Locale.ENGLISH);

        String requestTarget =
                requestMethod + " " + path;


        // ======================================================
        // SIGNING STRING
        // ======================================================

        String signingString;

        String headers;

        String digest = null;


        if ("GET".equals(requestMethod)) {

            headers =
                    "host date (request-target)";

            signingString =
                    "host: " + host + "\n"
                            + "date: " + date + "\n"
                            + "(request-target): " + requestTarget;

        } else {

            // ==================================================
            // DIGEST SHA-512
            // ==================================================

            String requestBody =
                    body == null ? "" : body;

            MessageDigest messageDigest =
                    MessageDigest.getInstance("SHA-512");

            byte[] digestBytes =
                    messageDigest.digest(
                            requestBody.getBytes(
                                    StandardCharsets.UTF_8
                            )
                    );

            String digestBase64 =
                    Base64.getEncoder()
                            .encodeToString(digestBytes);

            digest =
                    "SHA-512=" + digestBase64;


            headers =
                    "host date (request-target) digest";

            signingString =
                    "host: " + host + "\n"
                            + "date: " + date + "\n"
                            + "(request-target): " + requestTarget + "\n"
                            + "digest: " + digest;
        }


        // ======================================================
        // PRIVATE KEY
        // ======================================================

        PrivateKey rsaPrivateKey =
                loadPrivateKey(privateKey);


        // ======================================================
        // RSA SHA-512
        // ======================================================

        Signature signer =
                Signature.getInstance("SHA512withRSA");

        signer.initSign(rsaPrivateKey);

        signer.update(
                signingString.getBytes(
                        StandardCharsets.UTF_8
                )
        );

        byte[] signatureBytes =
                signer.sign();

        String signatureBase64 =
                Base64.getEncoder()
                        .encodeToString(signatureBytes);


        // ======================================================
        // SIGNATURE HEADER
        // ======================================================

        String signature =
                "keyId=\"" + keyId + "\","
                        + "algorithm=\"hs2019\","
                        + "created=" + created + ","
                        + "headers=\"" + headers + "\","
                        + "signature=\"" + signatureBase64 + "\"";


        // ======================================================
        // RESULTADO
        // ======================================================

        result.put("date", date);
        result.put("signature", signature);
        result.put("created", String.valueOf(created));
        result.put("signingString", signingString);

        if (digest != null) {
            result.put("digest", digest);
        }

        return result;
    }
}