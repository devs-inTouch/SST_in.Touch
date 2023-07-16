package pt.unl.fct.di.apdc.firstwebapp.util.entities.clientObjects;

import java.util.Map;

public class PermissionsInfoData {
    
    private String operationID;
    private String clientRole;
    private boolean access;
    private Map<String, Boolean> permissions;


    public PermissionsInfoData() {}

    public PermissionsInfoData(String operationID, String clientRole, boolean access, Map<String, Boolean> permissions) {
        this.operationID = operationID;
        this.clientRole = clientRole;
        this.access = access;
        this.permissions = permissions;
    }

    /**
     * @return the operationID
     */
    public String getOperationID() {
        return operationID;
    }

    /**
     * @return the clientRole
     */
    public String getClientRole() {
        return clientRole;
    }

    /**
     * @return the access
     */
    public boolean getAccesses() {
        return access;
    }

    /**
     * @return the permissions
     */
    public Map<String, Boolean> getPermissions() {
        return permissions;
    }

}
