package pt.unl.fct.di.apdc.firstwebapp.util.enums;

public enum UserRole {
    
    UNASSIGNED("NA"),
    STUDENT("student"),
    PROFESSOR("professor"),
    STAFF("staff"),
    MANAGER("manager"),
    SU("superUser");

    public final String type;

    /**
     * @param type
     */
    private UserRole(String type) {
        this.type = type;
    }

    public static UserRole toRole(String role) {
        for (UserRole t : UserRole.values())
            if (t.type.equals(role))
                return t;
        return null;
    }

}
