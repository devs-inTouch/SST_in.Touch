package pt.unl.fct.di.apdc.firstwebapp.util.entities.post;

public class PostDeleteData {

    private String userCreator, postIdentifier;

    public PostDeleteData() {
    }

    public PostDeleteData(String userCreator, String postIdentifier) {
        this.userCreator = userCreator;
        this.postIdentifier = postIdentifier;
    }

    public String getUserCreator() {
        return userCreator;
    }

    public String getPostIdentifier() {
        return postIdentifier;
    }
}
