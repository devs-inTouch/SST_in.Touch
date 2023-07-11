package pt.unl.fct.di.apdc.firstwebapp.util.entities.clientObjects;

/**
 * This class used for operations that only require the target's username
 * 
 * @see pt.unl.fct.di.apdc.firstwebapp.resources.RemoveResource.remove
 * 
 * @author fjaleao
 */
public class UserData {

    private String targetUsername;

    public UserData() {}
    
    public UserData(String targetUsername) {
        this.targetUsername = targetUsername;
    }


    /**
     * @return the targetUsername
     */
    public String getTargetUsername() {
        return targetUsername;
    }
    
}
