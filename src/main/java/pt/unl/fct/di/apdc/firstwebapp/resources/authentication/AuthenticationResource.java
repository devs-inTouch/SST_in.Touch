package pt.unl.fct.di.apdc.firstwebapp.resources.authentication;

import com.google.cloud.datastore.Datastore;
import com.google.cloud.datastore.DatastoreOptions;
import com.google.gson.Gson;

public abstract class AuthenticationResource implements AuthenticationInterface {

    private final Datastore datastore = DatastoreOptions.getDefaultInstance().getService();
    private final Gson g = new Gson();

    public AuthenticationResource() {
    }

    protected Datastore getDatastore() {
        return datastore;
    }


}
