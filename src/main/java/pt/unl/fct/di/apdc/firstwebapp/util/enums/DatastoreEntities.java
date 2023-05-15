package pt.unl.fct.di.apdc.firstwebapp.util.enums;

public enum DatastoreEntities {
    USER("User"),
    Token("Token");

    public final String value;

    /**
     * @param value
     */
    private DatastoreEntities(String value) {
        this.value = value;
    }
}
