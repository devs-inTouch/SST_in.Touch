package pt.unl.fct.di.apdc.firstwebapp.util.entities.nucleos;

public class NucleoInfoData {

    private String id, title, description, faceUrl, instaUrl, twitterUrl;

    public NucleoInfoData() {
    }

    public NucleoInfoData(String id, String title, String description, String faceUrl, String instaUrl, String twitterUrl) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.faceUrl = faceUrl;
        this.instaUrl = instaUrl;
        this.twitterUrl = twitterUrl;
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

    public String getFaceUrl() {
        return faceUrl;
    }

    public String getInstaUrl() {
        return instaUrl;
    }

    public String getTwitterUrl() {
        return twitterUrl;
    }
}
