package pt.unl.fct.di.apdc.firstwebapp.util.enums;

/**
 * Used to standardize datastore User attributes' names
 * 
 * @author fjaleao
 */
public enum UserAttributes {
    
    // Mandatory fields
    USERNAME("user_id"),
    NAME("user_name"),
    PASSWORD("user_password"),
    EMAIL("user_email"),
    CREATION_TIME("user_creation_time"),
    TYPE("user_type"),
    STATE("user_state_activated"),

    // Optional fields
    VISIBILITY("user_visibility"),
    MOBILE("user_mobile_phone_number"),
    PHONE("user_phone_number"),
    OCCUPATION("user_occupation"),
    WORK_ADDRESS("user_work_address"),
    ADDRESS("user_address"),
    SECOND_ADDRESS("user_second_address"),
    POST_CODE("user_post_code"),
    NIF("user_nif");



    public final String value;

    private UserAttributes(String value) {
        this.value = value;
    }
    
}
