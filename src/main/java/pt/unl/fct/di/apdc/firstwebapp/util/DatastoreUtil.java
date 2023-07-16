package pt.unl.fct.di.apdc.firstwebapp.util;

import java.io.IOException;
import java.util.Queue;
import java.util.logging.Logger;

import javax.ws.rs.core.Response.Status;

import com.google.auth.Credentials;
import com.google.auth.oauth2.GoogleCredentials;
import com.google.cloud.datastore.Datastore;
import com.google.cloud.datastore.DatastoreOptions;
import com.google.cloud.datastore.Entity;
import com.google.cloud.datastore.Transaction;

public class DatastoreUtil {

    private static final int TRANSACTION_LIMIT = 30;

    private static Datastore datastoreInstance;


    public static Datastore getService() {

        if (datastoreInstance == null)
            datastoreInstance = getDefault();

        return datastoreInstance;

    }


    private static Datastore IdPlatformInit() {

        try {

            Credentials credentials = GoogleCredentials.getApplicationDefault();
        
            DatastoreOptions options = DatastoreOptions.newBuilder()
                .setCredentials(credentials)
                .build();

            return options.getService();

        } catch (IOException e) {
            System.err.println(e.getMessage());
            return null;
        }
        
    }

    private static Datastore getDefault() {
        return DatastoreOptions.getDefaultInstance().getService();
    }

    public static Status loadToDatastore(Datastore datastore, Queue<Entity> toFlush, Logger LOG) {
        while (!toFlush.isEmpty()) {
            Status res = loadChunk(datastore, toFlush, LOG);

            if (!res.equals(Status.OK))
                return res;
        }

        return Status.OK;
        
    }

    private static Status loadChunk(Datastore datastore, Queue<Entity> toFlush, Logger LOG) {

        Transaction txn = datastore.newTransaction();

        try {

            for (int i = 0; i < TRANSACTION_LIMIT && !toFlush.isEmpty(); i++) {
                txn.put(toFlush.remove());
            }

            txn.commit();

            return Status.OK;

        } catch (Exception e) {
			txn.rollback();
			LOG.severe(e.getMessage());
			return Status.INTERNAL_SERVER_ERROR;
			
		} finally {
			if (txn.isActive()) {
				txn.rollback();
				return Status.INTERNAL_SERVER_ERROR;
			}
		}
    }
    
}
