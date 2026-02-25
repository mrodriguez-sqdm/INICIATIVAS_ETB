package com.globant.jwt;

import com.auth0.jwt.interfaces.Claim;
import com.auth0.jwt.interfaces.DecodedJWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.exceptions.JWTVerificationException;
import java.io.UnsupportedEncodingException;
import com.auth0.jwt.exceptions.JWTCreationException;
import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.time.ZoneId;

public class JWTGeneration
{
    public String generateJWT(final String secret, final String issuer, final String audience, final Integer expiration, final String subject, final String environment) {
        try {
            final long nowMillis = System.currentTimeMillis();
            final Date expirationDate = new Date(nowMillis + expiration);
            final Algorithm algorithm = Algorithm.HMAC256(secret);
            final String token = JWT.create().withIssuer(issuer).withAudience(new String[] { audience }).withExpiresAt(expirationDate).withSubject(subject).sign(algorithm);
            System.out.println(token);
            return token;
        }
        catch (JWTCreationException exception) {
            exception.printStackTrace();
        }
        catch (IllegalArgumentException e) {
            e.printStackTrace();
        }
        catch (UnsupportedEncodingException e2) {
            e2.printStackTrace();
        }
        return null;
    }
    
    public Map<String, String> decodeJWT(final String token, final String secret) {
        try {
            DecodedJWT jwt = JWT.decode(token);
            Map<String,String> map = new HashMap<String, String>();
            map.put("issuer", jwt.getIssuer());
            map.put("audience", jwt.getAudience().get(0));
            map.put("expirationDate", jwt.getExpiresAt().toInstant().atZone(ZoneId.of("UTC")).toString());
            map.put("subject", jwt.getSubject());
            return map;
        }
        catch (Error er) {
            return null;
        }
    }
    
    
    public static Map<String, Object> decodeJWT_v2(final String token, final String secret) {
        try {
            final Algorithm algorithm = Algorithm.HMAC256(secret);
            final JWTVerifier verifier = JWT.require(algorithm).build();
            final DecodedJWT jwt = verifier.verify(token);
            Map<String, Object> claimsMap = new HashMap<String, Object>();
            Map<String, Claim> claims = jwt.getClaims();
            for (Map.Entry<String, Claim> entry : claims.entrySet()) {
                claimsMap.put(entry.getKey(), entry.getValue().asString());
            }
            return claimsMap;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}