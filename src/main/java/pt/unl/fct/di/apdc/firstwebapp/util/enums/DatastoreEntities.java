package pt.unl.fct.di.apdc.firstwebapp.util.enums;

public enum DatastoreEntities {
    SECRET("Secret"),
    USER("User"),
    TOKEN("Token"),
    OPERATION("Operation"),
    ROLE("Role");

    public final String value;

    /**
     * @param value
     */
    private DatastoreEntities(String value) {
        this.value = value;
    }
}
