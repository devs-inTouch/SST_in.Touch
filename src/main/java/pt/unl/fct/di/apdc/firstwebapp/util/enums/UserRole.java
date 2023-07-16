package pt.unl.fct.di.apdc.firstwebapp.util.enums;

public enum UserRole {
    
    UNASSIGNED("NA"),

    STUDENT("ALUNO"),

    PROFESSOR("PROFESSOR"),

    SECURITY("SEGURANÇA"),
    LIBRARY("BIBLIOTECA"),
    BOARD("DIREÇÃO"),
    ANNOUNCER("DIVULGAÇÃO"),

    ADMIN("admin"),

    SU("superUser");

    public final String value;

    /**
     * @param type
     */
    private UserRole(String type) {
        this.value = type;
    }

    public static UserRole toRole(String role) {
        for (UserRole t : UserRole.values())
            if (t.value.equals(role))
                return t;
        return null;
    }

    public static boolean isStudent(String role) {
        return role.equals(STUDENT.value);
    }

    public static boolean isStaff(String role) {
        return role.equals(SECURITY.value) ||
                role.equals(LIBRARY.value) ||
                role.equals(BOARD.value) ||
                role.equals(ANNOUNCER.value) ||
                role.equals(ADMIN.value) ||
                role.equals(SU.value);
    }

}
