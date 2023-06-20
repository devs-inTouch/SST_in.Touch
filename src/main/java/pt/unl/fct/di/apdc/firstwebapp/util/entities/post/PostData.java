package pt.unl.fct.di.apdc.firstwebapp.util.entities.post;

public class PostData {

    public String username;
    public String description;
    public String mediaUrl;
    public int ups;
    public int downs;
    public long creationDate;

    public PostData() {
    }

    public PostData(String username, String description, String mediaUrl, int ups, int downs) {
        this.username = username;
        this.description = description;
        this.mediaUrl = mediaUrl;
        this.ups = ups;
        this.downs = downs;
    }

    public PostData(String username, String description, String mediaUrl, int ups, int downs, long creationDate) {
        this.username = username;
        this.description = description;
        this.mediaUrl = mediaUrl;
        this.ups = ups;
        this.downs = downs;
        this.creationDate = creationDate;
    }

}
