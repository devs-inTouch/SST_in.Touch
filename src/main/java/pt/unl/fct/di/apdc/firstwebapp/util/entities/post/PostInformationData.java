package pt.unl.fct.di.apdc.firstwebapp.util.entities.post;

import com.google.cloud.datastore.Value;

import java.util.List;

public class PostInformationData {

    public String postIdentifier, username, description, mediaUrl;
    public List<Value<String>>  ups, downs;
    public long creationDate;

    public PostInformationData() {
    }

    public PostInformationData(String postIdentifier, String username, String description, String mediaUrl, List<Value<String>>  ups, List<Value<String>>  downs, long creationDate) {
        this.postIdentifier = postIdentifier;
        this.username = username;
        this.description = description;
        this.mediaUrl = mediaUrl;
        this.ups = ups;
        this.downs = downs;
        this.creationDate = creationDate;
    }
}
