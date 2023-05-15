package pt.unl.fct.di.apdc.firstwebapp.resources.authentication;

import com.google.cloud.datastore.*;
import com.google.gson.Gson;

public class AuthenticationResource implements AuthenticationInterface {

    private final Datastore datastore = DatastoreOptions.getDefaultInstance().getService();
    private final Gson g = new Gson();

    public AuthenticationResource() {
    }

    protected Datastore getDatastore() {
        return datastore;
    }

    public void activateUser(String usernameToActivate) {

        Transaction txn = getDatastore().newTransaction();
        try {
            Key userKeyToActive = getDatastore().newKeyFactory().setKind("User").newKey(usernameToActivate);
            Entity userToActive = txn.get(userKeyToActive);
            Entity newUser = Entity.newBuilder(userToActive)
                    .set("password", userToActive.getString("pwd"))
                    .set("name", userToActive.getString("name"))
                    .set("email", userToActive.getString("email"))
                    .set("state", "Active")
                    .set("department", userToActive.getString("department"))
                    .set("role", "Aluno")
                    .build();

            txn.put(newUser);
            txn.commit();
        } finally {
            if (txn.isActive())
                txn.rollback();
        }
    }

}
