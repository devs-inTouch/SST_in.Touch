package pt.unl.fct.di.apdc.firstwebapp.util.entities.clientObjects;

public class CompleteQueryResultData {

    private String username;
    private String name;
    private String email;
    private long creationTime;
    private String role;
    private boolean state;

    public CompleteQueryResultData() {

    }

    public CompleteQueryResultData(String username, String name, String email, long creationTime, String role, boolean state) {
        this.username = username;
        this.name = name;
        this.email = email;
        this.creationTime = creationTime;
        this.role = role;
        this.state = state;
    }

    /**
     * @return the username
     */
    public String getUsername() {
        return username;
    }

    /**
     * @return the name
     */
    public String getName() {
        return name;
    }

    /**
     * @return the email
     */
    public String getEmail() {
        return email;
    }

    /**
     * @return the creationTime
     */
    public long getCreationTime() {
        return creationTime;
    }

    /**
     * @return the role
     */
    public String getRole() {
        return role;
    }

    /**
     * @return the state
     */
    public boolean isState() {
        return state;
    }
    
}
