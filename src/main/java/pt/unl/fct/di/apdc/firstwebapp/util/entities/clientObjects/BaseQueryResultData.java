package pt.unl.fct.di.apdc.firstwebapp.util.entities.clientObjects;

public class BaseQueryResultData {

    private String username;

    public BaseQueryResultData() {
        
    }
    
    public BaseQueryResultData(String username) {
        this.username = username;
    }

    /**
     * @return the username
     */
    public String getUsername() {
        return username;
    }
    
}
