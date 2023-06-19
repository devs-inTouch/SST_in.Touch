package pt.unl.fct.di.apdc.firstwebapp.resources.authentication;

import static pt.unl.fct.di.apdc.firstwebapp.util.enums.DatastoreEntities.SECRET;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.util.Base64;
import java.util.UUID;
import java.util.logging.Logger;

import javax.crypto.Mac;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;

import com.google.cloud.datastore.Datastore;
import com.google.cloud.datastore.Entity;
import com.google.cloud.datastore.Key;
import com.google.cloud.datastore.Transaction;

import io.jsonwebtoken.SignatureAlgorithm;
import pt.unl.fct.di.apdc.firstwebapp.util.DatastoreUtil;


public class SecretManager {
	
	private static final String ALGORYTHM = SignatureAlgorithm.HS256.getJcaName();

	private static final Logger LOG = Logger.getLogger(SecretManager.class.getName());

    // private static final long TTL = 7*24*60*60; //1 week

    private static final String ID = "current";
    private static final String VALUE = "value";
    // private static final String EXPIRATION_TIME = "expiration_time";
    
    private static final Datastore datastore = DatastoreUtil.getService();

    private static SecretManager instance = null;

    private static final Key key = datastore.newKeyFactory().setKind(SECRET.value).newKey(ID);

    private String secretStr;

    private SecretKey signKeySpec;


    public static SecretManager getInstance() {

        if (instance == null)
            instance = new SecretManager();

        return instance;
    }


    private SecretManager() {
        Entity secret = datastore.get(key);
        if (secret == null) {
            secret = init();
            signKeySpec = new SecretKeySpec(this.getSecret().getBytes(StandardCharsets.UTF_8), ALGORYTHM);
        }
        this.secretStr = secret.getString(VALUE);
    }


    private static Entity init() {

        Transaction txn = datastore.newTransaction();
        try {

            // Date now = new Date();

            Entity res = Entity.newBuilder(key)
                        .set(VALUE, UUID.randomUUID().toString())
                        // .set(EXPIRATION_TIME, new Date(now.getTime() + TTL).getTime())
                        .build();

            txn.put(res);
            txn.commit();
            return res;

        } catch (Exception e) {
			txn.rollback();
			LOG.severe(e.getMessage());
			return null;
			
		} finally {
			if (txn.isActive()) {
				txn.rollback();
				return null;

			}

		}
    }

    private String getSecret() {
        return secretStr;
    }

    public SecretKey getSignature() {
        return signKeySpec;
    }

    public boolean isSignatureValid(String[] parts) {

        Mac mac;

        try {
            mac = Mac.getInstance(ALGORYTHM);
            mac.init(this.getSignature());

            byte[] data = (parts[0] + "." + parts[1]).getBytes(StandardCharsets.UTF_8);
            byte[] signatureBytes = Base64.getUrlDecoder().decode(parts[2]);
            byte[] computedSignature = mac.doFinal(data);

            return MessageDigest.isEqual(signatureBytes, computedSignature);

        } catch (Exception e) {
            LOG.severe(e.getMessage());
            return false;
        }

    }

}
