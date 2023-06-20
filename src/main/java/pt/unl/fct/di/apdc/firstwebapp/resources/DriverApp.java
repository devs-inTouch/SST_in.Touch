package pt.unl.fct.di.apdc.firstwebapp.resources;

import com.google.api.client.auth.oauth2.Credential;
import com.google.api.client.auth.oauth2.CredentialStore;
import com.google.api.client.extensions.appengine.auth.oauth2.AppEngineCredentialStore;
import com.google.api.client.extensions.appengine.datastore.AppEngineDataStoreFactory;
import com.google.api.client.extensions.java6.auth.oauth2.AuthorizationCodeInstalledApp;
import com.google.api.client.extensions.jetty.auth.oauth2.LocalServerReceiver;
import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeFlow;
import com.google.api.client.googleapis.auth.oauth2.GoogleClientSecrets;
import com.google.api.client.googleapis.auth.oauth2.GoogleCredential;
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
import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.cloud.datastore.Datastore;
import com.google.cloud.datastore.DatastoreOptions;
import com.google.cloud.datastore.Entity;
import com.google.cloud.datastore.Key;
import org.apache.commons.codec.binary.Base64;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.StringReader;
import java.nio.charset.StandardCharsets;
import java.nio.file.Paths;
import java.security.GeneralSecurityException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class DriverApp {

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

    private static final String GOOGLE_APPLICATION_CREDENTIALS = "{\n" +
            "  \"type\": \"service_account\",\n" +
            "  \"project_id\": \"steel-sequencer-385510\",\n" +
            "  \"private_key_id\": \"ef9041a2e4461fb653c7dcb09f6600d975c1f5b1\",\n" +
            "  \"private_key\": \"-----BEGIN PRIVATE KEY-----\\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCVM5JCuhMBa1Im\\nb2Ufn13eNd4jrS/zTOMP0jCf39y4ICa3rSU2mfFkcPOeggfj2abcEz6NIutrM9Gi\\n9D0jhADLKD/SWwrtyRBEWWXeFmdwh544ImDrabC5/dj+ZkZ46MXLSy/t+fdS3WeJ\\nH0tk/RbAnNp35fiyU94wxScFcuir8MD/G1zkq4CShz4Nen32YglHHthCbXuJAzy7\\n9k/g23nST+lWf9r682saaLNJVmELjmHzDzpeHGZRED5RAUSY4HHCL1jc+gYoa9p+\\nCd59defnJwb/WgHm+y+HGG5gVzqugAVnLOVsjxIxWIXDJM4tmRZb9daFNRzJhSoV\\naoWXNS+DAgMBAAECggEAQ+z9JwTIt0oxVc88JhfrZ8l1bx+fJ3C3JRJH0dlchrUY\\ne2HIAeI2/EfSGbVQO0LxTNs0DJQ7wowOYlY4aW1k4RjbaXzKbnQtxDhBAMmJYTlU\\n5nB8WGC/NQXlHvjYF569we5ijUDSgPbMdqh5LiptC9a9PX3E6gb1rpVrTPdCB1i7\\nxu8Ho4op3Zqdb1+g/VtdEVERDr4SlX5PxFEgleeIgaTnN+5Qb5xn9vNx+8yGjFdu\\nie+fxLX/D5HTfWv/SfA3ns5b5sabo8Tt+UxUpAhtIXkPLMqYqwS9sDc0bwq2q5jD\\n0Mg3LPDlfHoWOZHaVrdG0lTAjgCmTHqwI+At3KSnZQKBgQDFQ6ZZGNUl89xTLVVG\\n8ul4MDbqwbrqEXREz4y3E2fTFovcucAP+Df8cnI8v9EVLBzGdj12SUePac+wyKGq\\nEfh6SC/5sJL7cUB+q9nyPZ3t4jjliKH3QKoQzUA8l4gHpSvm/37MWMEjIesBk9jL\\nBEGqbC89O50AwAfavBseWeLLfwKBgQDBoFzg3tBbeKHbSAYm3seJ4XJQGSXFNofk\\nVYLPcdHSqXpmHwvV0n3vC6sjkeLeL5/72yXGtDnQ9yBVhz7Kob+3i8r3kVE0zDG9\\nfH7ED7ejCP3CEk/z2Nq6588aQo0TNdAJnFlFbkocINhCc4ij3J4G407qgAvGcxOF\\nSX6LaRNt/QKBgBEQQgJxAHcQ+h0Dzd2eQ43O9eEmsuluaxVMsspfVlrPF3gXZUK8\\nYPNoXvNcUFS5hR+xuK1Tt2nzaDDNmhZhCZJiTiwWFxDDAiYy7V5j8BZUvEE2qXP+\\n1vcvGgBjxzOKGRsZPLmmb8Z/N5niVR1yl8+LHib40iLveX51SQ8+DT03AoGAK/Wb\\ngJY1mb7OiHlWpDaJ+NzNVjAPajHSMl3ToANITtqZZlwAFOCAJOhyR1YUurr3SHfd\\noLpEMhQZLDHTaK/GVgaP4xsD48fENy/vm9WxrHsbGZeMvWDrb+m3FFAttUHPZI8x\\nmVjLzI0MbDHMwN8SpZ+vx/+gLMLtmKIx77bAaYUCgYAPa4HYrI1u/khX8UZx40i/\\nDbuShEHql7ZMHBMNSWAAqFSWH6ABmXr6RUG0RkiYyg+yICesh6iNojvTZb1wEzLP\\n035UDOympoXoZ8xTuoaRWKjBD9jZL+s7IooumQ37eSi7Z46pkA2nugjBzFUJEzQc\\n/pjlDAfWlCaaGM4+ZeNZiQ==\\n-----END PRIVATE KEY-----\\n\",\n" +
            "  \"client_email\": \"compute-gmail@steel-sequencer-385510.iam.gserviceaccount.com\",\n" +
            "  \"client_id\": \"110293685082235510914\",\n" +
            "  \"auth_uri\": \"https://accounts.google.com/o/oauth2/auth\",\n" +
            "  \"token_uri\": \"https://oauth2.googleapis.com/token\",\n" +
            "  \"auth_provider_x509_cert_url\": \"https://www.googleapis.com/oauth2/v1/certs\",\n" +
            "  \"client_x509_cert_url\": \"https://www.googleapis.com/robot/v1/metadata/x509/compute-gmail%40steel-sequencer-385510.iam.gserviceaccount.com\",\n" +
            "  \"universe_domain\": \"googleapis.com\"\n" +
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


    public DriverApp() throws IOException, GeneralSecurityException {
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
                .setDataStoreFactory(new FileDataStoreFactory(Paths.get(TOKENS_PATH).toFile()))
                .setAccessType("offline")
                .build();

        LocalServerReceiver receiver = new LocalServerReceiver.Builder().setPort(8888).build();
        Credential credential = new AuthorizationCodeInstalledApp(flow, receiver).authorize("user");


        // Return the authorized Credential object.
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
        DriverApp driverapp = new DriverApp();
        driverapp.listFiles();
        driverapp.createDirectory("test");

     /*   // Provide the file path to upload
        java.io.File fileToUpload = new java.io.File("logo.png");
        // Call the uploadFile method to upload the file
        driver.uploadFile(fileToUpload);*/


        driverapp.print();

    }
}
