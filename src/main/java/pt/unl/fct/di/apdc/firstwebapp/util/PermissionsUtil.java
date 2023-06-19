package pt.unl.fct.di.apdc.firstwebapp.util;

import java.util.logging.Logger;

import com.google.cloud.datastore.Datastore;
import com.google.cloud.datastore.DatastoreOptions;
import com.google.cloud.datastore.Entity;
import com.google.cloud.datastore.Key;
import com.google.cloud.datastore.PathElement;

import pt.unl.fct.di.apdc.firstwebapp.util.enums.DatastoreEntities;

public class PermissionsUtil {
    
    private static final Datastore datastore = DatastoreOptions.getDefaultInstance().getService();

    public static boolean hasPermission(Logger LOG, String opID, String managerRole) {

        Key opPermissionsKey = datastore.newKeyFactory().setKind(DatastoreEntities.OPERATION.value).newKey(opID);
        Entity opPermissions = datastore.get(opPermissionsKey);

        return opPermissions.getBoolean(managerRole);
    }

    public static boolean hasPermission(Logger LOG, String opID, String managerRole, String targetRole) {

        boolean managerHasPermission;

        if (managerHasPermission = hasPermission(LOG, opID, managerRole)) {
            Key managerTargetsKey = datastore.newKeyFactory()
                                    .addAncestor(PathElement.of(DatastoreEntities.OPERATION.value, opID))
                                    .newKey(managerRole);

            Entity managerTargets = datastore.get(managerTargetsKey);

            managerHasPermission = managerTargets.getBoolean(targetRole);

        }

        return managerHasPermission;
        
    }

}
