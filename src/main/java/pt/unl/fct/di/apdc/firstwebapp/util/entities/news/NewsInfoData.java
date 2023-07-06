package pt.unl.fct.di.apdc.firstwebapp.util.entities.news;

public class NewsInfoData {

    private String id, title, description, mediaUrl;
    private long creationDate;

    public NewsInfoData() {
    }

    public NewsInfoData(String id, String title, String description, String mediaUrl, long creationDate) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.mediaUrl = mediaUrl;
        this.creationDate = creationDate;
    }

    public String getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public String getDescription() {
        return description;
    }

    public String getMediaUrl() {
        return mediaUrl;
    }

    public long getCreationDate() {
        return creationDate;
    }
}
