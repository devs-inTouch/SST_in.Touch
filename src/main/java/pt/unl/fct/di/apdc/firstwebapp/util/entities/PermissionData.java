package pt.unl.fct.di.apdc.firstwebapp.util.entities;

public class PermissionData extends OperationData{
    
    private String permission;


    public PermissionData() {}

    /**
     * @param operationID
     * @param permission
     */
    public PermissionData(String operationID, String permission) {
        super(operationID);
        this.permission = permission;
    }

    /**
     * @return the permission
     */
    public String getPermission() {
        return permission;
    }

}
