package pt.unl.fct.di.apdc.firstwebapp.util.enums;

public enum Operation {

    // permissions
    EDIT_PERMISSIONS("editPermissions", true),                
    EDIT_ACCESSES("editAccesses", true),
    LIST_PERMISSIONS("showPermissions", false),

    //dev
    REGISTER_OPERATION("registerOperation", false),
    REGISTER_ROLE("registerRole", false),

    // manager operations
    ACTIVATE_USER("activateUser", true),                      
    CHANGE_ATTRIBUTES("changeAttributes", true),              
    CHANGE_PASSWORD("changePassword", true),                  
    LIST_USERS("listUsers", true),                            
    REMOVE_USER("removeUser", true),                          
    LIST_UNNACTIVATED_USERS("listUnactivatedUsers", true),    
    STATS("showStats", false),
    LIST_ANOMALIES("listAnomalies", false),
    DELETE_ANOMALY("deleteAnomaly", false),
    LIST_REPORTS("listReports", false),
    ADD_ROOM("addRoom", false),
    DELETE_ROOM("deleteRoom", false),
    LIST_USER_BOOKINGS("listUserBookings", false),
    APPROVE_BOOKING("approveBooking", false),
    REJECT_BOOKING("rejectBooking", false),

    // common
    HOME("home", false),                                               
    CREATE_POST("createPost", false),                                  
    LIST_POSTS("listPosts", false),
    ADD_UP("addUp", false),
    ADD_DOWN("addDown", false),
    DELETE_POST("deletePost", true),
    SHOW_PROFILE("showProfile", false),                                
    FOLLOW("follow", false),
    UNFOLOW("unfollow", false),
    LIST_FOLLOWERS("listFollowers", false),
    LIST_FOLLOWING("listFollowing", false),
    BOOK_ROOM("bookRoom", false),                                      
    CANCEL_BOOKING("cancelBooking", false),
    LIST_AVAILABLE_ROOMS("listAvailableRooms", false),
    LIST_AVAILABLE_ROOMS_BY_HOUR("listAvailableRoomsByHour", false),
    CREATE_ANOMALY("createAnomaly", false),
    CREATE_CALENDAR_EVENT("createCalendarEvent", false),
    UPDATE_CALENDAR_EVENT("updateCalendarEvent", false),
    DELETE_CALENDAR_EVENT("deleteCalendarEvent", false),
    SHOW_CALENDAR("showCalendar", false),
    REPORT_POST("reportPost", false),
    DELETE_NOTIFICATION("deleteNotification", false),
    DELETE_ALL_NOTIFICATIONS("deleteAllNotifications", false),
    LIST_NOTIFICATIONS("listNotifications", false),


    //other
    CREATE_EVENT("createEvent", false),
    DELETE_EVENT("deleteEvent", false),
    LIST_EVENTS("listEvents", false),
    SUBSCRIBE_EVENT("subscribeEvent", false),
    CREATE_NEWS("createNews", false),
    DELETE_NEWS("deleteNews", false),
    LIST_NEWS("listNews", false),

    // debug
    SHOW_TOKEN("showToken", false);
    
    // new

    public final String value;
    public final boolean hasPermissions;

    private Operation(String value, boolean hasPermissions) {
        this.value = value;
        this.hasPermissions = hasPermissions;
    }

    public static Operation toOperation(String opID) {
        for (Operation o : Operation.values())
            if (o.value.equals(opID))
                return o;
        return null;
    }
}
