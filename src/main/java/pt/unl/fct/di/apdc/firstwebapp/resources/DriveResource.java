package pt.unl.fct.di.apdc.firstwebapp.resources;

import com.google.api.client.auth.oauth2.Credential;
import com.google.api.client.auth.oauth2.TokenResponse;
import com.google.api.client.extensions.java6.auth.oauth2.AuthorizationCodeInstalledApp;
import com.google.api.client.extensions.jetty.auth.oauth2.LocalServerReceiver;
import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeFlow;
import com.google.api.client.googleapis.auth.oauth2.GoogleClientSecrets;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.gson.GsonFactory;
import com.google.api.services.drive.DriveScopes;
import com.google.api.services.gmail.GmailScopes;
import com.google.cloud.datastore.*;
import com.google.cloud.datastore.StructuredQuery.CompositeFilter;
import com.google.cloud.datastore.StructuredQuery.PropertyFilter;

import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.io.IOException;
import java.io.StringReader;
import java.security.GeneralSecurityException;
import java.util.Arrays;
import java.util.List;
import java.util.logging.Logger;

@Path("/driver")
@Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
public class DriveResource {

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
     * Global instance of the JSON factory.
     */
    private static final GsonFactory JSON_FACTORY = GsonFactory.getDefaultInstance();

    /**
     * Global instance of the scopes required by this request.
     * If modifying these scopes, delete your previously saved tokens/ folder.
     */
    private static final List<String> SCOPES = Arrays.asList(
            GmailScopes.GMAIL_MODIFY,
            DriveScopes.DRIVE,
            DriveScopes.DRIVE_APPDATA,
            DriveScopes.DRIVE_FILE
    );

    private static final Logger LOG = Logger.getLogger(GmailResource.class.getName());

    private final Datastore datastore = DatastoreOptions.getDefaultInstance().getService();

    public static String TOKENS_DIRECTORY_PATH = "/tokens";

    public DriveResource() {
    }

    @POST
    @Path("/")
    public Response sendFile() {
        try {
            final NetHttpTransport HTTP_TRANSPORT = GoogleNetHttpTransport.newTrustedTransport();

            // Load client secrets.
            GoogleClientSecrets clientSecrets = GoogleClientSecrets.load(JSON_FACTORY, new StringReader(CLIENT_SECRET_JSON));

            // Build flow and trigger user authorization request.
            GoogleAuthorizationCodeFlow flow = new GoogleAuthorizationCodeFlow.Builder(
                    HTTP_TRANSPORT, JSON_FACTORY, clientSecrets, SCOPES)
                    .setAccessType("offline")
                    .build();
            LocalServerReceiver receiver = new LocalServerReceiver.Builder().setPort(8000).build();
            Credential credential = new AuthorizationCodeInstalledApp(flow, receiver).authorize("user");


            return Response.status(Response.Status.OK).entity("Ficheiro enviado").build();
        }catch (GeneralSecurityException e){
            LOG.severe("Genera Error while sending FCT mail: " + e.getMessage());
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR).entity("General Error sending FCT mail.").build();
        }catch (IOException e){
            LOG.severe("IO Error while sending FCT mail: " + e.getMessage());
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                    .entity("IO Error sending FCT mail.\n" + e.getMessage() + "\n" + e.getStackTrace().toString())
                    .build();
        }
    }


}
