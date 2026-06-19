package com.etb.gcp;

import java.nio.charset.StandardCharsets;
import java.security.KeyFactory;
import java.security.PrivateKey;
import java.security.Signature;
import java.security.spec.PKCS8EncodedKeySpec;
import java.time.Instant;
import java.util.Base64;

public class GoogleJwtHelper {

    public static String generateJwt(String clientEmail, String privateKeyPem) throws Exception {

        long now = Instant.now().getEpochSecond();

        String header = "{\"alg\":\"RS256\",\"typ\":\"JWT\"}";

        String payload = "{"
                + "\"iss\":\"" + clientEmail + "\","
                + "\"scope\":\"https://www.googleapis.com/auth/cloud-platform\","
                + "\"aud\":\"https://oauth2.googleapis.com/token\","
                + "\"iat\":" + (now - 60) + ","
                + "\"exp\":" + (now + 3300)
                + "}";

        String encodedHeader = base64Url(header.getBytes(StandardCharsets.UTF_8));
        String encodedPayload = base64Url(payload.getBytes(StandardCharsets.UTF_8));

        String unsignedToken = encodedHeader + "." + encodedPayload;

        PrivateKey privateKey = getPrivateKey(privateKeyPem);

        Signature signature = Signature.getInstance("SHA256withRSA");
        signature.initSign(privateKey);
        signature.update(unsignedToken.getBytes(StandardCharsets.UTF_8));

        String encodedSignature = base64Url(signature.sign());

        return unsignedToken + "." + encodedSignature;
    }

    private static PrivateKey getPrivateKey(String privateKeyPem) throws Exception {

        String key = privateKeyPem
                .replace("-----BEGIN PRIVATE KEY-----", "")
                .replace("-----END PRIVATE KEY-----", "")
                .replace("\\n", "")
                .replace("\n", "")
                .replace("\r", "")
                .trim();

        byte[] decoded = Base64.getDecoder().decode(key);

        PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(decoded);

        KeyFactory keyFactory = KeyFactory.getInstance("RSA");

        return keyFactory.generatePrivate(keySpec);
    }

    private static String base64Url(byte[] input) {
        return Base64.getUrlEncoder()
                .withoutPadding()
                .encodeToString(input);
    }
}