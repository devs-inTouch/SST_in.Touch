package pt.unl.fct.di.apdc.firstwebapp.util.enums;

/**
 * Used to standardize datastore User attributes' names
 * 
 * @author fjaleao
 */
public enum UserAttributes {

    // TODO check indexes
    
    // Mandatory fields
    USERNAME("user_id"),
    NAME("user_name"),
    PASSWORD("user_password"),
    EMAIL("user_email"),
    CREATION_TIME("user_creation_time"),
    ROLE("user_role"),
    STATE("user_is_activated"),

    FOLLOWERS("user_followers"),

    FOLLOWING("user_following"),
    // Optional fields
    VISIBILITY("user_is_visible"),
    MOBILE("user_mobile_phone_number"),
    PHONE("user_phone_number"),
    DEPARTMENT("user_department"),
    WORK_ADDRESS("user_work_address"),
    ADDRESS("user_address"),
    SECOND_ADDRESS("user_second_address"),
    POST_CODE("user_post_code"),
    NIF("user_nif"),
    STUDENT_NUMBER("user_student_number"),
    COURSE("user_course"),
    DESCRIPTION("user_description");

    public final String value;

    private UserAttributes(String value) {
        this.value = value;
    }
    
}
