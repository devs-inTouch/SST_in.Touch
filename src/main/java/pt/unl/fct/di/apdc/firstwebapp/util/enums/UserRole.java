package pt.unl.fct.di.apdc.firstwebapp.util.enums;

public enum UserRole {
    
    UNASSIGNED("NA"),       //*done

    STUDENT("ALUNO"),     //*done

    PROFESSOR("PROFESSOR"), //*done

    SECURITY("SEGURANÇA"),   //*done
    LIBRARY("BIBLIOTECA"),     //*done
    BOARD("DIREÇÃO"),         //*done
    ANNOUNCER("DIVULGAÇÃO"), //*done

    ADMIN("admin"),         //*done

    SU("superUser");        //*done

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

    public boolean isStaff(String role) {
        return role.equals(SECURITY.value) ||
            role.equals(LIBRARY.value) ||
            role.equals(BOARD.value) ||
            role.equals(ANNOUNCER.value) ||
            role.equals(ADMIN.value);
    }

}
