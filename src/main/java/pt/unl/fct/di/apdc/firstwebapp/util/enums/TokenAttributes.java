package pt.unl.fct.di.apdc.firstwebapp.util.enums;

public enum TokenAttributes {
    USERNAME("username"),
    ID("id"),
    CREATION_TIME("creationTime"),
    EXPIRATION_TIME("expirationTime");

    public final String value;

    private TokenAttributes(String value) {
        this.value = value;
    }

}
