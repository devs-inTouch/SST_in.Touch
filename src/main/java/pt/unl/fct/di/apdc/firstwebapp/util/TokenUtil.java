package pt.unl.fct.di.apdc.firstwebapp.util;

import java.util.logging.Logger;

import org.apache.commons.codec.digest.DigestUtils;

import com.google.cloud.Timestamp;
import com.google.cloud.datastore.Datastore;
import com.google.cloud.datastore.DatastoreOptions;
import com.google.cloud.datastore.Entity;

import pt.unl.fct.di.apdc.firstwebapp.util.entities.TokenData;
import pt.unl.fct.di.apdc.firstwebapp.util.enums.TokenAttributes;

public class TokenUtil {

    Datastore datastore = DatastoreOptions.getDefaultInstance().getService();
    
    
    public static boolean isTokenValid(Logger LOG, TokenData givenToken, Entity datastoreToken) {
        
        boolean valid = false;
        if (!givenToken.getTokenID().equals(datastoreToken.getString(TokenAttributes.ID.value))) {
            LOG.severe("Token ID not valid.");

        } else if (!DigestUtils.sha512Hex(givenToken.getVerification()).equals(datastoreToken.getString(TokenAttributes.VERIFICATION.value))) {
            LOG.severe("Token compromised.");

        } else if (givenToken.getExpirationDate() < Timestamp.now().getSeconds()) {
            LOG.warning("Token is expired.");

        } else valid = true;

        LOG.info("Token valid!");
        return valid;
        
    }
    
}
