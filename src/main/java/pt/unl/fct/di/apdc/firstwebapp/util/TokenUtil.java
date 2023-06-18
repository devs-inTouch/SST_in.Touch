package pt.unl.fct.di.apdc.firstwebapp.util;

import java.util.Base64;
import java.util.logging.Logger;

import com.fasterxml.jackson.databind.ObjectMapper;

import pt.unl.fct.di.apdc.firstwebapp.resources.authentication.SecretManager;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.TokenData;


public class TokenUtil {

    public static TokenData validateToken(Logger LOG, String givenToken) {

        try {

            // token = header.payload.signature
            String[] parts = givenToken.split("\\.");

            if (parts.length != 3) {
                LOG.severe("Token is disfigured!");
                return null;
            }

            Base64.Decoder decoder = Base64.getUrlDecoder();

            // String header = new String(decoder.decode(parts[0]));
            String payload = new String(decoder.decode(parts[1]));
            // String signature = new String(decoder.decode(parts[2]));

            SecretManager sm = SecretManager.getInstance();

            if (!sm.isSignatureValid(parts)) {
                LOG.severe("Invalid signature!");
                return null;
            }

            // Deserialize the payload JSON into a Java object
            ObjectMapper objectMapper = new ObjectMapper();
            TokenData token = objectMapper.readValue(payload, TokenData.class);

            if (token.isExpired())
                return null;
            
            return token;

        } catch (Exception e) {
            LOG.severe(e.getMessage());
            return null;
        }
    }
    
}
