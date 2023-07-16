package pt.unl.fct.di.apdc.firstwebapp.resources.permissions;

import static pt.unl.fct.di.apdc.firstwebapp.util.enums.DatastoreEntities.ACCESS;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.DatastoreEntities.PERMISSION;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.Globals.ACCESS_FORMAT;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.Globals.N_ENDPOINTS;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.Globals.N_ROLES;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.Globals.PERMISSION_FORMAT;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.PermissionsAttributes.VALUE;

import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;

import com.google.cloud.datastore.Datastore;
import com.google.cloud.datastore.Entity;
import com.google.cloud.datastore.Key;
import com.google.cloud.datastore.KeyFactory;

import pt.unl.fct.di.apdc.firstwebapp.util.DatastoreUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.enums.UserRole;

public class PermissionsHolder {

    private static final String ACCESS_TEST_KEY = UserRole.SU.value;
    private static final String PERMISSION_TEST_KEY = String.format(ACCESS_FORMAT, UserRole.SU.value, UserRole.SU.value);


    private static final Datastore datastore = DatastoreUtil.getService();

    private final KeyFactory accessKeyFactory =  datastore.newKeyFactory().setKind(ACCESS.value);
    private final KeyFactory permissionKeyFactory =  datastore.newKeyFactory().setKind(PERMISSION.value);

    private static PermissionsHolder instance = null;

    private Map<String, Boolean> accesses;
    private Map<String, Boolean> permissions;


    public static PermissionsHolder getInstance() {
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

            String accessID = String.format(ACCESS_FORMAT, endpointID, cr.value);

            Key accessKey = accessKeyFactory.newKey(accessID);

            Entity access = datastore.get(accessKey);

            accesses.put(accessID, access.getBoolean(VALUE.value));

            for (UserRole tr : UserRole.values()) {

                String permissionID = String.format(PERMISSION_FORMAT, endpointID, cr.value, tr.value);

                Key permissionKey = permissionKeyFactory.newKey(permissionID);

                Entity permission = datastore.get(permissionKey);

                permissions.put(permissionID, permission.getBoolean(VALUE.value));

            }
        }

    }

    public boolean hasAccess(String endpointID, String clientRole) {
        String id = String.format(ACCESS_FORMAT, endpointID, clientRole);

        Boolean result = accesses.get(id);

        if (result != null)
            return result;

        loadPermissions(endpointID);
        return accesses.get(id).booleanValue();
    }

    public boolean hasPermission(String endpointID, String clientRole, String targetRole) {

        if (!hasAccess(endpointID, clientRole))
            return false;

        String id = String.format(PERMISSION_FORMAT, endpointID, clientRole, targetRole);

        return permissions.get(id).booleanValue();

    }

    public void editAccess(String endpointID, String clientRole, boolean access) {

        String id = String.format(ACCESS_FORMAT, endpointID, clientRole);

        Boolean current = accesses.get(id);

        if (current == null)
            loadPermissions(endpointID);

        accesses.put(id, access);

    }

    public void editPermission(String endpointID, String clientRole, String targetRole, boolean access) {

        String id = String.format(PERMISSION_FORMAT, endpointID, clientRole, targetRole);

        Boolean current = permissions.get(id);

        if (current == null)
            loadPermissions(endpointID);

        permissions.put(id, access);

    }

    public int getClearance(String endpointID, String clientRole) {
        return -1;
    }

    public Map<String, Boolean> getPermissions(String endpointID) {

        Boolean test = permissions.get(ACCESS_TEST_KEY);

        if (test == null)
            loadPermissions(endpointID);

        Map<String, Boolean> res = new HashMap<>(N_ROLES * N_ROLES);

        permissions.forEach((k, v) -> {
            if (this.getEndpointID(k).equals(endpointID))
                res.put(k, v);
        });

        return res;
    }

    private String getEndpointID(String key) {
        return key.split("-")[0];
    }

}
