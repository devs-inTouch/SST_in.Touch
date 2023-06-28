package pt.unl.fct.di.apdc.firstwebapp.resources.permissions;

import static pt.unl.fct.di.apdc.firstwebapp.util.enums.DatastoreEntities.OPERATION;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.DatastoreEntities.ROLE;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.Globals.N_ENDPOINTS;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.Globals.N_ROLES;

import java.util.HashMap;
import java.util.Map;

import com.google.cloud.datastore.Datastore;
import com.google.cloud.datastore.Entity;
import com.google.cloud.datastore.Key;
import com.google.cloud.datastore.PathElement;

import pt.unl.fct.di.apdc.firstwebapp.util.DatastoreUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.enums.RoleAttributes;
import pt.unl.fct.di.apdc.firstwebapp.util.enums.UserRole;

public class PermissionsHolder {

    private static final String KEY_FORMAT = "%s/%s";

    private static final Datastore datastore = DatastoreUtil.getService();

    private static PermissionsHolder instance = null;

    private Map<String, Boolean> accesses;
    private Map<String, Boolean> permissions;


    public static PermissionsHolder getInstance(){
        if (instance == null)
            instance = new PermissionsHolder();
        
        return instance;
    }


    private PermissionsHolder() {
        accesses = new HashMap<>(N_ENDPOINTS * N_ROLES);
        permissions = new HashMap<>(N_ENDPOINTS * N_ROLES * N_ROLES);
    }

    private void loadPermissions(String endpointID) {

        for (UserRole cr : UserRole.values()) {

            Key  clientRoleKey = datastore.newKeyFactory()
                                .addAncestor(PathElement.of(OPERATION.value, endpointID))
                                .setKind(ROLE.value)
                                .newKey(cr.value);

            Entity clientRole = datastore.get(clientRoleKey);

            String accessKey = String.format(KEY_FORMAT, endpointID, cr.value);

            accesses.put(accessKey, clientRole.getBoolean(RoleAttributes.ACCESS.value));

            for (UserRole tr : UserRole.values()) {

                Key  targetRoleKey = datastore.newKeyFactory()
                                    .addAncestors(PathElement.of(OPERATION.value, endpointID),
                                        PathElement.of(ROLE.value, cr.value))
                                    .setKind(ROLE.value)
                                    .newKey(tr.value);

                Entity targetRole = datastore.get(targetRoleKey);

                String permissionKey = String.format(KEY_FORMAT, accessKey, tr.value);

                permissions.put(permissionKey, targetRole.getBoolean(RoleAttributes.ACCESS.value));

            }
        }

    }

    public boolean hasAccess(String endpointID, String clientRole) {
        String key = String.format(KEY_FORMAT, endpointID, clientRole);

        Boolean result = accesses.get(key);

        if (result != null)
            return result;

        loadPermissions(endpointID);
        return accesses.get(key).booleanValue();
    }

    public boolean hasPermission(String endpointID, String clientRole, String targetRole) {

        if (!hasAccess(endpointID, clientRole))
            return false;

        String key = String.format(KEY_FORMAT,
                                String.format(KEY_FORMAT, endpointID, clientRole),
                                targetRole);

        return permissions.get(key);

    }

}
