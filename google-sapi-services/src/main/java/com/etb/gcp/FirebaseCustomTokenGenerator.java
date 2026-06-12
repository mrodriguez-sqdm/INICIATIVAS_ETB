package com.etb.gcp;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.auth.FirebaseAuth;

import java.io.InputStream;

public class FirebaseCustomTokenGenerator {

    private static boolean initialized = false;

    private static synchronized void initializeFirebase() throws Exception {

        if (!initialized) {

            InputStream serviceAccount =
                    FirebaseCustomTokenGenerator.class
                            .getClassLoader()
                            .getResourceAsStream("service-account.json");

            if (serviceAccount == null) {
                throw new RuntimeException("No se encontró el archivo service-account.json en resources");
            }

            FirebaseOptions options = FirebaseOptions.builder()
                    .setCredentials(GoogleCredentials.fromStream(serviceAccount))
                    .build();

            if (FirebaseApp.getApps().isEmpty()) {
                FirebaseApp.initializeApp(options);
            }

            initialized = true;
        }
    }

    public static String generateToken(String uid) throws Exception {

        initializeFirebase();

        return FirebaseAuth.getInstance().createCustomToken(uid);
    }
}