package pt.unl.fct.di.apdc.firstwebapp.util.enums;

public enum TokenAttributes {
    USERNAME("token_user_id"),
    ID("token_id"),
    CREATION_TIME("token_creation_time"),
    EXPIRATION_TIME("token_expiration_time"),
    VERIFICATION("token_verification");

    public final String value;

    private TokenAttributes(String value) {
        this.value = value;
    }

}
