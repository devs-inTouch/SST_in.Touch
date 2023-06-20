package pt.unl.fct.di.apdc.firstwebapp.resources;

import com.google.api.client.auth.oauth2.Credential;
import com.google.api.client.extensions.java6.auth.oauth2.AuthorizationCodeInstalledApp;
import com.google.api.client.extensions.jetty.auth.oauth2.LocalServerReceiver;
import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeFlow;
import com.google.api.client.googleapis.auth.oauth2.GoogleClientSecrets;
import com.google.api.client.googleapis.util.Utils;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.JsonObjectParser;
import com.google.api.client.json.JsonParser;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.api.client.util.store.DataStore;
import com.google.api.client.util.store.DataStoreFactory;
import com.google.api.services.drive.DriveScopes;
import com.google.api.services.gmail.GmailScopes;
import com.google.auth.oauth2.GoogleCredentials;
import com.google.auth.oauth2.ServiceAccountCredentials;
import com.google.cloud.datastore.Datastore;
import com.google.cloud.datastore.DatastoreOptions;
import com.google.cloud.datastore.Entity;
import com.google.cloud.datastore.Key;
import com.google.cloud.datastore.KeyFactory;


import java.io.IOException;
import java.io.Serializable;
import java.io.StringReader;
import java.security.GeneralSecurityException;
import java.util.Arrays;
import java.util.List;

public class CredentialManager {
    private static final String CLIENT_SECRET_JSON = "{\n" +
            "  \"installed\": {\n" +
            "    \"client_id\": \"635132466395-8vhob2dd758n7j48hjm7cqb96n3n8ljq.apps.googleusercontent.com\",\n" +
            "    \"project_id\": \"steel-sequencer-385510\",\n" +
            "    \"auth_uri\": \"https://accounts.google.com/o/oauth2/auth\",\n" +
            "    \"token_uri\": \"https://oauth2.googleapis.com/token\",\n" +
            "    \"auth_provider_x509_cert_url\": \"https://www.googleapis.com/oauth2/v1/certs\",\n" +
            "    \"client_secret\": \"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\",\n" +
            "    \"redirect_uris\": [\n" +
            "      \"http://localhost\"\n" +
            "    ]\n" +
            "  }\n" +
            "}";

    /**
     * Application name.
     */
    private static final String APPLICATION_NAME = "SST in.Touch";

    /**
     * Global instance of the JSON factory.
     */
    private static final JsonFactory JSON_FACTORY = JacksonFactory.getDefaultInstance();

    private static final List<String> SCOPES = Arrays.asList(
            GmailScopes.GMAIL_MODIFY,
            DriveScopes.DRIVE,
            DriveScopes.DRIVE_APPDATA,
            DriveScopes.DRIVE_FILE
    );

    public CredentialManager() throws IOException, GeneralSecurityException {
    }

    public static Credential getCredentials(NetHttpTransport HTTP_TRANSPORT) throws IOException {
        GoogleClientSecrets clientSecrets = GoogleClientSecrets.load(JSON_FACTORY, new StringReader(CLIENT_SECRET_JSON));

        GoogleAuthorizationCodeFlow flow = new GoogleAuthorizationCodeFlow.Builder(
                HTTP_TRANSPORT, JSON_FACTORY, clientSecrets, SCOPES)
                .setDataStoreFactory(createDataStoreFactory())
                .setAccessType("offline")
                .build();
        LocalServerReceiver receiver = new LocalServerReceiver.Builder().setPort(8080).build();
        Credential credential = new AuthorizationCodeInstalledApp(flow, receiver).authorize("user");

       // saveCredentialToDatastore(credential);

        return credential;
    }

    private static GoogleAuthorizationCodeFlow.Builder createFlowBuilder(NetHttpTransport HTTP_TRANSPORT,
                                                                         GoogleClientSecrets clientSecrets) {
        return new GoogleAuthorizationCodeFlow.Builder(HTTP_TRANSPORT, JSON_FACTORY, clientSecrets, SCOPES);
    }

    private static Datastore createDatastore() throws IOException {
        GoogleCredentials credentials = ServiceAccountCredentials.getApplicationDefault();
        DatastoreOptions options = DatastoreOptions.newBuilder()
                .setProjectId(APPLICATION_NAME)
                .setCredentials(credentials)
                .build();

        return options.getService();
    }

    private static DataStoreFactory createDataStoreFactory() throws IOException {
        Datastore datastore = createDatastore();
        KeyFactory keyFactory = datastore.newKeyFactory().setKind("AcessToken");
        Key key = keyFactory.newKey("token");
        DataStoreFactory dtStoreFactory = new DataStoreFactory() {
            @Override
            public <V extends Serializable> DataStore<V> getDataStore(String s) throws IOException {
                return null;
            }
        };
        return dtStoreFactory;
    }










}
