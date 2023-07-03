package pt.unl.fct.di.apdc.firstwebapp.util.entities.news;

public class NewsInfoData {

    private String title, description, mediaUrl;
    private long creationDate;

    public NewsInfoData() {
    }

    public NewsInfoData(String title, String description, String mediaUrl, long creationDate) {
        this.title = title;
        this.description = description;
        this.mediaUrl = mediaUrl;
        this.creationDate = creationDate;
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
