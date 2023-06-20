package pt.unl.fct.di.apdc.firstwebapp.util.entities.post;

public class PostDeleteData {

    public String username, userCreator, postIdentifier;

    public PostDeleteData() {
    }

    public PostDeleteData(String username, String userCreator, String postIdentifier) {
        this.username = username;
        this.userCreator = userCreator;
        this.postIdentifier = postIdentifier;
    }
}
