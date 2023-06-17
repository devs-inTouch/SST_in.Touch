package pt.unl.fct.di.apdc.firstwebapp.resources;

import com.google.api.client.auth.oauth2.Credential;
import com.google.api.client.extensions.appengine.datastore.AppEngineDataStoreFactory;
import com.google.api.client.extensions.java6.auth.oauth2.AuthorizationCodeInstalledApp;
import com.google.api.client.extensions.jetty.auth.oauth2.LocalServerReceiver;
import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeFlow;
import com.google.api.client.googleapis.auth.oauth2.GoogleClientSecrets;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.http.FileContent;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.gson.GsonFactory;
import com.google.api.client.util.store.FileDataStoreFactory;
import com.google.api.services.drive.Drive;
import com.google.api.services.drive.DriveScopes;
import com.google.api.services.drive.model.File;
import com.google.api.services.drive.model.FileList;
import com.google.api.services.gmail.Gmail;
import com.google.api.services.gmail.GmailScopes;
import com.google.api.services.gmail.model.ListMessagesResponse;
import com.google.api.services.gmail.model.Message;
import com.google.api.services.gmail.model.MessagePart;
import com.google.api.services.gmail.model.MessagePartBody;
import org.apache.commons.codec.binary.Base64;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.security.GeneralSecurityException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Driver {
    private static final String CLIENT_SECRET_JSON = "{\n" +
            "  \"installed\": {\n" +
            "    \"client_id\": \"635132466395-ne89k6bsob8nclc53gk7334gomeqbvo1.apps.googleusercontent.com\",\n" +
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
    private static final GsonFactory JSON_FACTORY = GsonFactory.getDefaultInstance();

    public static final String TOKENS_PATH = "tokensDrive";

    /**
     * Global instance of the scopes required by this quickstart.
     * If modifying these scopes, delete your previously saved tokens/ folder.
     */
    private static final List<String> SCOPES = Arrays.asList(
            GmailScopes.GMAIL_MODIFY,
            DriveScopes.DRIVE,
            DriveScopes.DRIVE_APPDATA,
            DriveScopes.DRIVE_FILE
    );

    private final Drive serviceDrive;
    private final Gmail serviceGmail;


    public Driver() throws IOException, GeneralSecurityException {
        // Build a new authorized API client service.
        final NetHttpTransport HTTP_TRANSPORT = GoogleNetHttpTransport.newTrustedTransport();
        serviceDrive = new Drive.Builder(HTTP_TRANSPORT, JSON_FACTORY, getCredentials(HTTP_TRANSPORT))
                .setApplicationName(APPLICATION_NAME)
                .build();
        serviceGmail = new Gmail.Builder(HTTP_TRANSPORT, JSON_FACTORY, getCredentials(HTTP_TRANSPORT))
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
                .setDataStoreFactory(AppEngineDataStoreFactory.getDefaultInstance())
                .setAccessType("offline")
                .build();
        LocalServerReceiver receiver = new LocalServerReceiver.Builder().setPort(8080).build();
        Credential credential = new AuthorizationCodeInstalledApp(flow, receiver).authorize("user");
        //returns an authorized Credential object.
        return credential;
    }

    private void listFiles() throws IOException {
// Print the names and IDs for up to 10 files.
        FileList result = serviceDrive.files().list()
                .setPageSize(10)
                .setFields("nextPageToken, files(id, name)")
                .execute();
        List<File> files = result.getFiles();
        if (files == null || files.isEmpty()) {
            System.out.println("No files found.");
        } else {
            System.out.println("Files:");
            for (File file : files) {
                System.out.printf("%s (%s)\n", file.getName(), file.getId());
            }
        }
    }

    private void uploadFile(java.io.File file) throws IOException {
        File driveFile = new File();
        driveFile.setName(file.getName());

        FileContent mediaContent = new FileContent(null, file);

        File uploadedFile = serviceDrive.files().create(driveFile, mediaContent)
                .setFields("id")
                .execute();

        System.out.println("File uploaded. File ID: " + uploadedFile.getId());
    }

    private void createDirectory(String directoryName) throws IOException {
        File driveDirectory = new File();
        driveDirectory.setName(directoryName);
        driveDirectory.setMimeType("application/vnd.google-apps.folder");

        File createdDirectory = serviceDrive.files().create(driveDirectory)
                .setFields("id")
                .execute();

        System.out.println("Directory created. Directory ID: " + createdDirectory.getId());
    }


    private List<Message> listSocialEmails(){
        try{
            //List all emails from social media
            String query = "category:social";
            ListMessagesResponse response = serviceGmail.users().messages().list("me").setQ(query).execute();
            List<Message> messages = new ArrayList<>();
            while (response.getMessages() != null) {
                messages.addAll(response.getMessages());
                if (response.getNextPageToken() != null) {
                    String pageToken = response.getNextPageToken();
                    response = serviceGmail.users().messages().list("me").setQ(query)
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

    private void getMessageContent(Message message) {
        try {
            Message fullMessage = serviceGmail.users().messages().get("me", message.getId()).setFormat("full").execute();
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

    public void print(){
        List<Message> messages =  listSocialEmails();
        System.out.println("Total messages: " + messages.size());
        for(Message message : messages){
            getMessageContent(message);
        }

    }




    public static void main(String[] args) throws IOException, GeneralSecurityException {
        Driver driver = new Driver();
        driver.listFiles();
        driver.createDirectory("test");

     /*   // Provide the file path to upload
        java.io.File fileToUpload = new java.io.File("logo.png");
        // Call the uploadFile method to upload the file
        driver.uploadFile(fileToUpload);*/


        driver.print();

    }
}
