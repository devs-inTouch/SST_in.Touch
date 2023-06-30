package pt.unl.fct.di.apdc.firstwebapp.util.entities.news;

public class NewsData {

    private String title, description, mediaUrl;

    public NewsData() {
    }

    public NewsData(String title, String description, String mediaUrl) {
        this.title = title;
        this.description = description;
        this.mediaUrl = mediaUrl;
    }

    public String getTitle() {
        return title;
    }

    public String getDescription() {
        return description;
    }

    public String getUrl() {
        return mediaUrl;
    }
}
