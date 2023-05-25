package pt.unl.fct.di.apdc.firstwebapp.resources.authentication;

import com.google.cloud.datastore.Datastore;

public interface AuthenticationInterface {

    void activateUser(String usernameToActivate);

}
