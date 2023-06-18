package pt.unl.fct.di.apdc.firstwebapp.util.enums;

public enum DatastoreEntities {
    SECRET("Secret"),
    USER("User"),
    TOKEN("Token"),
    OPERATION("Operation"),
    MANAGER_ROLE("Manager_Role"),
    TARGET_ROLE("Target_Role");

    public final String value;

    /**
     * @param value
     */
    private DatastoreEntities(String value) {
        this.value = value;
    }
}
