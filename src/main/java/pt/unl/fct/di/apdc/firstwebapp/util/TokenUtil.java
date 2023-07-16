package pt.unl.fct.di.apdc.firstwebapp.util;

import static pt.unl.fct.di.apdc.firstwebapp.util.enums.DatastoreEntities.TOKEN;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.TokenAttributes.ID;

import java.util.Base64;
import java.util.logging.Logger;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.cloud.datastore.Datastore;
import com.google.cloud.datastore.Entity;
import com.google.cloud.datastore.Key;
import com.google.cloud.datastore.KeyFactory;
import com.google.cloud.datastore.Transaction;

import pt.unl.fct.di.apdc.firstwebapp.resources.authentication.SecretManager;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.clientObjects.TokenData;


public class TokenUtil {

    private static final Datastore datastore = DatastoreUtil.getService();

    private static final KeyFactory kf = datastore.newKeyFactory().setKind(TOKEN.value);

    public static TokenData validateToken(Logger LOG, String givenToken) {

        // Transaction txn = datastore.newTransaction();

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

            Key tokenKey = kf.newKey(token.getUsername());
            Entity storedToken = datastore.get(tokenKey);

            String message;

            if (storedToken == null) {
                message = "Token should not exist!";
                LOG.severe(message);
                // return new TokenData(message, "", 0L, 0L);
                return null;
            }

            if (!token.getId().equals(storedToken.getString(ID.value))) {
                message = "Token" + token.getId() + "not up to date.";
                LOG.severe(message);
                // return new TokenData(message, "", 0L, 0L);
                return null;
            }

            if (token.isExpired()) {
                message = "Token" + token.getId() + "expired.";
                LOG.warning(message);
                deleteIdentifiedToken(tokenKey);
                // return new TokenData(message, "", 0L, 0L);
                return null;
            }
            
            return token;

        } catch (Exception e) {
			LOG.severe(e.getMessage());
			return null;
        }
    }

    public static void deleteToken(String userID) {
        Key key = kf.newKey(userID);
        deleteIdentifiedToken(key);
    }

    private static void deleteIdentifiedToken(Key tokenKey) {
        Transaction txn = datastore.newTransaction();

        try {
            txn.delete(tokenKey);
            txn.commit();
        } catch (Exception e) {
			txn.rollback();
			
		} finally {
			if (txn.isActive()) {
				txn.rollback();

			}
        }
    }
    
}
