package pt.unl.fct.di.apdc.firstwebapp.resources.permissions;

import static pt.unl.fct.di.apdc.firstwebapp.util.enums.Globals.N_ENDPOINTS;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.Globals.N_ROLES;


import java.util.HashMap;
import java.util.Map;

import com.google.cloud.datastore.Datastore;

import pt.unl.fct.di.apdc.firstwebapp.util.DatastoreUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.enums.UserRole;

public class PermissionsHolder {

    private static final Datastore datastore = DatastoreUtil.getService();

    private static PermissionsHolder instance = null;

    private Map<String, Map<String, String>> permissions;


    public static PermissionsHolder getInstance(){
        if (instance == null)
            instance = new PermissionsHolder();
        
        return instance;
    }


    private PermissionsHolder() {
        permissions = new HashMap<>(N_ENDPOINTS);
    }

    private void loadPermissions(String endpointID) {

        Map<String, String> endpointPermissions = new HashMap<>(N_ROLES);

        permissions.put(endpointID, endpointPermissions);

    }

    public boolean hasPermission(String endpointID, UserRole clientRole) {
        return false;
    }

    public boolean hasPermission(String endpointID, UserRole clientRole, UserRole targetRole) {
        return false;
    }


}
