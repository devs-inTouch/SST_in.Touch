package pt.unl.fct.di.apdc.firstwebapp.resources;


import com.google.api.client.auth.oauth2.Credential;
import com.google.api.client.extensions.java6.auth.oauth2.AuthorizationCodeInstalledApp;
import com.google.api.client.extensions.jetty.auth.oauth2.LocalServerReceiver;
import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeFlow;
import com.google.api.client.googleapis.auth.oauth2.GoogleClientSecrets;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.gson.GsonFactory;
import com.google.api.client.util.store.FileDataStoreFactory;
import com.google.api.services.drive.DriveScopes;
import com.google.api.services.gmail.Gmail;
import com.google.api.services.gmail.GmailScopes;
import com.google.api.services.gmail.model.*;
import org.apache.commons.codec.binary.Base64;

import javax.mail.MessagingException;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.nio.file.Paths;
import java.security.GeneralSecurityException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

public class Gmailer {

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
     * Email of the Service Account. Can use "me" instead.
     */
    private static final String EMAIL = "devs.in.touch@gmail.com";

    /**
     * Application name.
     */
    private static final String APPLICATION_NAME = "SST in.Touch";

    /**
     * Global instance of the JSON factory.
     */
    private static final GsonFactory JSON_FACTORY = GsonFactory.getDefaultInstance();

    private static final List<String> SCOPES = Arrays.asList(
            DriveScopes.DRIVE,
            GmailScopes.GMAIL_MODIFY
    );
    public static final String TOKENS_PATH = "tokens";

    private final Gmail service;

    public Gmailer() throws IOException, GeneralSecurityException {
        // Build a new authorized API client service.
        final NetHttpTransport HTTP_TRANSPORT = GoogleNetHttpTransport.newTrustedTransport();
        service = new Gmail.Builder(HTTP_TRANSPORT, JSON_FACTORY, getCredentials(HTTP_TRANSPORT))
                .setApplicationName(APPLICATION_NAME)
                .build();
    }

    /**
     * Creates an authorized Credential object.
     *
     * @param HTTP_TRANSPORT The network HTTP Transport.
     * @return An authorized Credential object.
     * @throws IOException If the credentials.json file cannot be found.
     */
    private static Credential getCredentials(final NetHttpTransport HTTP_TRANSPORT)
            throws IOException {
        // Load client secrets.
        GoogleClientSecrets clientSecrets = GoogleClientSecrets.load(JSON_FACTORY, new StringReader(CLIENT_SECRET_JSON));

        // Build flow and trigger user authorization request.
        GoogleAuthorizationCodeFlow flow = new GoogleAuthorizationCodeFlow.Builder(
                HTTP_TRANSPORT, JSON_FACTORY, clientSecrets, SCOPES)
                .setDataStoreFactory(new FileDataStoreFactory(Paths.get(TOKENS_PATH).toFile()))
                .setAccessType("offline")
                .build();
        LocalServerReceiver receiver = new LocalServerReceiver.Builder().setPort(8888).build();
        Credential credential = new AuthorizationCodeInstalledApp(flow, receiver).authorize("user");
        //returns an authorized Credential object.
        return credential;
    }


    /**
     * List all Messages of the user's mailbox in the social label.
     * This label was the FCT diary email with the info required.
     * @return the list of messages if successful.
     */
    private List<Message> listSocialEmails(){
        try{
            //List all emails from social media
            String query = "category:social";
            ListMessagesResponse response = service.users().messages().list("me").setQ(query).execute();
            List<Message> messages = new ArrayList<>();
            while (response.getMessages() != null) {
                messages.addAll(response.getMessages());
                if (response.getNextPageToken() != null) {
                    String pageToken = response.getNextPageToken();
                    response = service.users().messages().list("me").setQ(query)
                            .setPageToken(pageToken).execute();
                } else {
                    break;
                }
            }
            /*for (Message message : messages) {
                service.users().messages().trash("me", message.getId()).execute();
            }*/
            return messages;
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    public void print(){
        List<Message> messages =  listSocialEmails();
        System.out.println("Total messages: " + messages.size());
        for(Message message : messages){
            getMessageContent(message);
        }

    }

    private void getMessageContent(Message message) {
        try {
            Message fullMessage = service.users().messages().get("me", message.getId()).setFormat("full").execute();
            List<MessagePart> parts = fullMessage.getPayload().getParts();
            List<MessagePart> insideParts = parts.get(0).getParts();

            if (insideParts != null && !insideParts.isEmpty()) {
                for (MessagePart part : insideParts) {
                    String mimeType = part.getMimeType();
                    if(mimeType.startsWith("text/plain")){
                        MessagePartBody bodyParts = part.getBody();
                        String data = bodyParts.getData();
                        byte[] decodedBytes = Base64.decodeBase64(data);
                        String decodedData = new String(decodedBytes, StandardCharsets.UTF_8);
                        System.out.println(decodedData);
                    }
                }
            }
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
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

    public static void main(String[] args) throws GeneralSecurityException, IOException, MessagingException {
        //new Gmailer().sendMail("A new message", "Esta a funcionar Chavalo");
        new Gmailer().print();


    }



}
