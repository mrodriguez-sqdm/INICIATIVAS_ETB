package com.etb.gcp;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.auth.FirebaseAuth;

import java.io.ByteArrayInputStream;
import java.nio.charset.StandardCharsets;
import java.util.Map;

public class FirebaseCustomTokenGenerator {

    private static boolean initialized = false;

    private static synchronized void initializeFirebase(Map<String, Object> args) throws Exception {

        if (!initialized) {

            String projectId = (String) args.get("projectId");
            String privateKeyId = (String) args.get("privateKeyId");
            String privateKey = ((String) args.get("privateKey")).replace("\\n", "\n");
            String clientEmail = (String) args.get("clientEmail");
            String clientId = (String) args.get("clientId");

            String serviceAccountJson =
                    "{"
                            + "\"type\":\"service_account\","
                            + "\"project_id\":\"" + projectId + "\","
                            + "\"private_key_id\":\"" + privateKeyId + "\","
                            + "\"private_key\":\"" + privateKey.replace("\n", "\\n") + "\","
                            + "\"client_email\":\"" + clientEmail + "\","
                            + "\"client_id\":\"" + clientId + "\","
                            + "\"auth_uri\":\"https://accounts.google.com/o/oauth2/auth\","
                            + "\"token_uri\":\"https://oauth2.googleapis.com/token\","
                            + "\"auth_provider_x509_cert_url\":\"https://www.googleapis.com/oauth2/v1/certs\","
                            + "\"client_x509_cert_url\":\"https://www.googleapis.com/robot/v1/metadata/x509/" + clientEmail + "\""
                            + "}";

            ByteArrayInputStream credentialsStream =
                    new ByteArrayInputStream(serviceAccountJson.getBytes(StandardCharsets.UTF_8));

            FirebaseOptions options = FirebaseOptions.builder()
                    .setCredentials(GoogleCredentials.fromStream(credentialsStream))
                    .build();

            if (FirebaseApp.getApps().isEmpty()) {
                FirebaseApp.initializeApp(options);
            }

            initialized = true;
        }
    }

    public static String generateToken(Map<String, Object> args) throws Exception {

        String uid = (String) args.get("uid");

        if (uid == null || uid.trim().isEmpty()) {
            throw new RuntimeException("El uid/localId es obligatorio");
        }

        initializeFirebase(args);

        return FirebaseAuth.getInstance().createCustomToken(uid);
    }
}