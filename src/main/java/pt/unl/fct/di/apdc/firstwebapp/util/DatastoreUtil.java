package pt.unl.fct.di.apdc.firstwebapp.util;

import java.io.IOException;

import com.google.auth.Credentials;
import com.google.auth.oauth2.GoogleCredentials;
import com.google.cloud.datastore.Datastore;
import com.google.cloud.datastore.DatastoreOptions;

public class DatastoreUtil {

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
    
}
