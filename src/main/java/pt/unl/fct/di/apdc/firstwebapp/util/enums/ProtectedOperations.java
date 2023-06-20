package pt.unl.fct.di.apdc.firstwebapp.util.enums;

public enum ProtectedOperations {

    ACTIVATE_USER("activate_user"),
    CHANGE_ATTRIBUTES("change_attributes"),
    CHANGE_PASSWORD("change_password"),
    LIST_USERS("list_users"),
    REMOVE_USER("remove_user");

    public final String value;

    private ProtectedOperations(String value) {
        this.value = value;
    }

}