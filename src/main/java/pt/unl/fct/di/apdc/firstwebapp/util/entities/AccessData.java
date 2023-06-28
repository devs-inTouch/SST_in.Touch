package pt.unl.fct.di.apdc.firstwebapp.util.entities;

import java.util.Map;

public class AccessData extends OperationData {

    /**
     * This map serves to provide access to roles to a certain operation.
     * This concept is acheived through the sample entry as a template:
     * 
     *              clientRole : value
     * 
     * Example:     superUser : true
     * 
     */
    private Map<String, Boolean> accessPermissions;

    public AccessData() {}

    public AccessData(String operationID, Map<String, Boolean> accessPermissions) {
        super(operationID);
        this.accessPermissions = accessPermissions;
    }

    /**
     * @return the accessPermissions
     */
    public Map<String, Boolean> getAccessPermissions() {
        return accessPermissions;
    }

}
