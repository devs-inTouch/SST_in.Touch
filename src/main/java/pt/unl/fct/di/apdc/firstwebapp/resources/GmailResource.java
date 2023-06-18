package pt.unl.fct.di.apdc.firstwebapp.resources;

import com.google.api.client.auth.oauth2.Credential;
import com.google.api.client.auth.oauth2.StoredCredential;
import com.google.api.client.extensions.java6.auth.oauth2.AuthorizationCodeInstalledApp;
import com.google.api.client.extensions.jetty.auth.oauth2.LocalServerReceiver;
import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeFlow;
import com.google.api.client.googleapis.auth.oauth2.GoogleClientSecrets;
import com.google.api.client.googleapis.extensions.appengine.auth.oauth2.AppIdentityCredential;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.gson.GsonFactory;
import com.google.api.client.util.store.DataStore;
import com.google.api.client.util.store.FileDataStoreFactory;
import com.google.api.services.drive.DriveScopes;
import com.google.api.services.gmail.GmailScopes;
import com.google.api.services.gmail.model.Message;
import com.google.cloud.datastore.*;

import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;
import java.io.IOException;
import java.io.StringReader;
import java.nio.file.Paths;
import java.security.GeneralSecurityException;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.logging.Logger;


@Path("/gmailer")
@Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
public class GmailResource {
    private static final String CLIENT_SECRET_JSON = "{\n" +
            "  \"installed\": {\n" +
            "    \"client_id\": \"635132466395-ahq2fu08h9u7l3r21joiuoffm2eph0an.apps.googleusercontent.com\",\n" +
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

    private static final List<String> SCOPES = Arrays.asList(
            DriveScopes.DRIVE,
            GmailScopes.GMAIL_MODIFY
    );

    public static final String TOKENS_PATH = "tokens";

    private static final String GMAIL_INFO = "FCT";

    private static final Logger LOG = Logger.getLogger(GmailResource.class.getName());

    private final Datastore datastore = DatastoreOptions.getDefaultInstance().getService();

    public static String TOKENS_DIRECTORY_PATH = "/Tokens";

    public GmailResource() {
    }


    @POST
    @Path("/")
    public Response sendFCTMail() {
        LOG.info("Update Hoje na FCT mail ");
        Transaction txn = datastore.newTransaction();

        try{
            final NetHttpTransport HTTP_TRANSPORT = GoogleNetHttpTransport.newTrustedTransport();

            // Load client secrets.
            GoogleClientSecrets clientSecrets = GoogleClientSecrets.load(JSON_FACTORY, new StringReader(CLIENT_SECRET_JSON));

            // Build flow and trigger user authorization request.
            GoogleAuthorizationCodeFlow flow = new GoogleAuthorizationCodeFlow.Builder(
                    HTTP_TRANSPORT, JSON_FACTORY, clientSecrets, SCOPES)
                    .setDataStoreFactory(new FileDataStoreFactory(new java.io.File(TOKENS_DIRECTORY_PATH)))
                    .setAccessType("offline")
                    .build();

            /*// Build the AppIdentityCredential for authorization
            AppIdentityCredential credential = new AppIdentityCredential.Builder(SCOPES)
                    .build();
            // Build the file data store
            FileDataStoreFactory dataStoreFactory = new FileDataStoreFactory(Paths.get(TOKENS_PATH).toFile());
            DataStore<StoredCredential> credentialDataStore = dataStoreFactory.getDataStore("gmail_credentials");
            // Create a Cloud Datastore entity key for storing the tokens
            Key tokenKey = datastore.newKeyFactory().setKind("Token").newKey("defaultToken");
            final NetHttpTransport HTTP_TRANSPORT = GoogleNetHttpTransport.newTrustedTransport();
            // Load client secrets.
            GoogleClientSecrets clientSecrets = GoogleClientSecrets.load(JSON_FACTORY, new StringReader(CLIENT_SECRET_JSON));
            // Build flow and trigger user authorization request.
            GoogleAuthorizationCodeFlow flow = new GoogleAuthorizationCodeFlow.Builder(
                    HTTP_TRANSPORT, JSON_FACTORY, clientSecrets, SCOPES)
                    .setCredentialDataStore(credentialDataStore)
                    .setAccessType("offline")
                    .build();
            LocalServerReceiver receiver = new LocalServerReceiver.Builder().setPort(8888).build();*/

            return Response.status(Status.OK).entity("Hoje na FCT atualizado.").build();
        }catch (GeneralSecurityException e){
            LOG.severe("Genera Error while sending FCT mail: " + e.getMessage());
            return Response.status(Status.INTERNAL_SERVER_ERROR).entity("General Error sending FCT mail.").build();
        }catch (IOException e){
            LOG.severe("IO Error while sending FCT mail: " + e.getMessage());
            return Response.status(Status.INTERNAL_SERVER_ERROR).entity("IO Error sending FCT mail.").build();
        }
    /*   try {
            // Create an instance of Gmailer and handle potential exceptions
            Gmailer gm = new Gmailer();
            Message message = gm.getNewTodayFCTEmail();
            String content = gm.getMessageContent(message);
            String[] lines = content.split("\n");

            // Update datastore
            Key FCTKey = datastore.newKeyFactory().setKind(GMAIL_INFO).newKey("today");
            Transaction txn = datastore.newTransaction();

            try {
                Entity fct = txn.get(FCTKey);
                fct = Entity.newBuilder(FCTKey).set("today", lines[0]).build();
                txn.put(fct);
                txn.commit();
                LOG.fine("Updated FCT info");
                return Response.status(Status.OK).entity("Hoje na FCT atualizado." + lines[0]).build();
            } finally {
                if (txn.isActive())
                    txn.rollback();
            }
        } catch (GeneralSecurityException | IOException e) {
            // Handle the exceptions and return an error response
            LOG.severe("Error while sending FCT mail: " + e.getMessage());
            return Response.status(Status.INTERNAL_SERVER_ERROR).entity("Error sending FCT mail.").build();
        }*/
    }

    /* private void sendMail(String subject, String body) throws GeneralSecurityException, IOException, MessagingException {
        //send email to yourself


      *//*  // Create the email content
        String messageSubject = "Test message";
        String bodyText = "lorem ipsum.";*//*

        // Encode as MIME message
        Properties props = new Properties();
        Session session = Session.getDefaultInstance(props, null);
        MimeMessage email = new MimeMessage(session);
        email.setFrom(new InternetAddress(EMAIL));
        email.addRecipient(javax.mail.Message.RecipientType.TO,
                new InternetAddress(EMAIL));
        email.setSubject(subject);
        email.setText(body);

       *//* MimeBodyPart mimeBodyPart = new MimeBodyPart();
        mimeBodyPart.setContent(body, "text/plain");
        Multipart multipart = new MimeMultipart();
        multipart.addBodyPart(mimeBodyPart);
        mimeBodyPart = new MimeBodyPart();
        DataSource source = new FileDataSource(file);
        mimeBodyPart.setDataHandler(new DataHandler(source));
        mimeBodyPart.setFileName(file.getName());
        multipart.addBodyPart(mimeBodyPart);
        email.setContent(multipart);*//*

        // Encode and wrap the MIME message into a gmail message
        ByteArrayOutputStream buffer = new ByteArrayOutputStream();
        email.writeTo(buffer);
        byte[] rawMessageBytes = buffer.toByteArray();
        String encodedEmail = encodeBase64URLSafeString(rawMessageBytes);
        Message message = new Message();
        message.setRaw(encodedEmail);

        try {
            message = service.users().messages().send("me", message).execute();
            System.out.println("Draft id: " + message.getId());
            System.out.println(message.toPrettyString());
        } catch (GoogleJsonResponseException e) {
            // TODO(developer) - handle error appropriately
            GoogleJsonError error = e.getDetails();
            if (error.getCode() == 403) {
                System.err.println("Unable to create draft: " + e.getDetails());
            } else {
                throw e;
            }
        }
    }*/



}

