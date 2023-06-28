package pt.unl.fct.di.apdc.firstwebapp.util.entities;

import java.util.Map;

public class PermissionsData extends OperationData {

    /**
     * This map serves to indicate the permissions roles has over other roles, in a given operation.
     * This concept is acheived through the sample entry as a template:
     * 
     *              clientRole/targetRole : value
     * 
     * Example:     superUser/student : true
     * 
     */
    private Map<String, Boolean> permissions;

    public PermissionsData() {}

    public PermissionsData(String operationID, Map<String, Boolean> permissions) {
        super(operationID);
        this.permissions = permissions;
    }

    /**
     * @return the permissions
     */
    public Map<String, Boolean> getPermissions() {
        return permissions;
    }

}
