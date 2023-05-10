package pt.unl.fct.di.apdc.firstwebapp.util.entities.old;

/**
 * @deprecated
 * @see UserData
 */
public class ActivateUserData {

    String username, usernameToActivate;

    public ActivateUserData() {}

    public ActivateUserData(String username, String usernameToActivate) {
        this.username = username;
        this.usernameToActivate = usernameToActivate;
    }
}
