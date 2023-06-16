package pt.unl.fct.di.apdc.firstwebapp.util.entities;

public class PostInformationData {

    public String postIdentifier, username, description, mediaUrl;
    public int ups, downs;
    public long creationDate;

    public PostInformationData() {
    }

    public PostInformationData(String postIdentifier, String username, String description, String mediaUrl, int ups, int downs, long creationDate) {
        this.postIdentifier = postIdentifier;
        this.username = username;
        this.description = description;
        this.mediaUrl = mediaUrl;
        this.ups = ups;
        this.downs = downs;
        this.creationDate = creationDate;
    }
}
