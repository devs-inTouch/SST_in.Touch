package pt.unl.fct.di.apdc.firstwebapp.util.entities.old;

/**
 * @deprecated
 * @see UserData
 */
public class RemoveData {
    public String username, password, userRem;

    public RemoveData(){}

    public RemoveData(String username, String password, String userRem) {
        this.username = username;
        this.password = password;
        this.userRem = userRem;
    }
}
