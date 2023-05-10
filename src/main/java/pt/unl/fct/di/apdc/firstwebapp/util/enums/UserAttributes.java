package pt.unl.fct.di.apdc.firstwebapp.util.enums;

/**
 * Used to standardize datastore User attributes' names
 * 
 * @author fjaleao
 */
public enum UserAttributes {

    // TODO check indexes
    
    // Mandatory fields
    USERNAME("user_id", String.class),
    NAME("user_name", String.class),
    PASSWORD("user_password", String.class),
    EMAIL("user_email", String.class),
    CREATION_TIME("user_creation_time", Long.class),
    ROLE("user_role", String.class),
    STATE("user_is_activated", Boolean.class),

    // Optional fields
    VISIBILITY("user_is_visible", Boolean.class),
    MOBILE("user_mobile_phone_number", String.class),
    PHONE("user_phone_number", String.class),
    DEPARTMENT("user_department", String.class),
    WORK_ADDRESS("user_work_address", String.class),
    ADDRESS("user_address", String.class),
    SECOND_ADDRESS("user_second_address", String.class),
    POST_CODE("user_post_code", String.class),
    NIF("user_nif", String.class);



    public final String value;

    public final String type;

    private UserAttributes(String value, Class<?> type) {
        this.value = value;
        this.type = type.getSimpleName();
    }
    
}
