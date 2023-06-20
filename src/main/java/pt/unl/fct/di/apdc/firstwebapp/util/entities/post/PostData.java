package pt.unl.fct.di.apdc.firstwebapp.util.entities.post;

public class PostData {

    private String description;
    private String mediaUrl;
    private int ups;
    private int downs;
    private long creationDate;

    public PostData() {
    }

    public PostData(String description, String mediaUrl, int ups, int downs) {
        this.description = description;
        this.mediaUrl = mediaUrl;
        this.ups = ups;
        this.downs = downs;
    }

    public PostData(String description, String mediaUrl, int ups, int downs, long creationDate) {
        this.description = description;
        this.mediaUrl = mediaUrl;
        this.ups = ups;
        this.downs = downs;
        this.creationDate = creationDate;
    }

    public String getDescription() {
        return description;
    }

    public String getMediaUrl() {
        return mediaUrl;
    }

    public int getUps() {
        return ups;
    }

    public int getDowns() {
        return downs;
    }

    public long getCreationDate() {
        return creationDate;
    }

}
