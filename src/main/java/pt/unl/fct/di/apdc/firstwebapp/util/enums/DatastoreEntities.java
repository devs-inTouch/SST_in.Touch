package pt.unl.fct.di.apdc.firstwebapp.util.enums;

public enum DatastoreEntities {
    SECRET("Secret"),
    USER("User"),
    TOKEN("Token"),
    OPERATION("Operation"),
    ROLE("Role"),
    POST("Post"),
    ANOMALY("Anomaly"),
    BOOKING("Booking"),
    NEWS("News"),
    EVENT("Event"),
    NOTIFICATION("Notification"),
    NUCLEO("Nucleo"),
    ROOM("Room");

    public final String value;

    /**
     * @param value
     */
    private DatastoreEntities(String value) {
        this.value = value;
    }
}
