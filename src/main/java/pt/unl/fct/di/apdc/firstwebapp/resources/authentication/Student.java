package pt.unl.fct.di.apdc.firstwebapp.resources.authentication;

import com.google.cloud.datastore.Entity;
import com.google.cloud.datastore.Key;
import com.google.cloud.datastore.Transaction;

public class Student extends AuthenticationResource {

    public Student() {
        super();
    }


    @Override
    public void activateUser(String usernameToActivate) {

        Transaction txn = getDatastore().newTransaction();
        try {
            Key userKeyToActive = super.getDatastore().newKeyFactory().setKind("User").newKey(usernameToActivate);
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
