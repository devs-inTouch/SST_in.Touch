package pt.unl.fct.di.apdc.firstwebapp.util.enums;

public enum Operation {

    // permissions
    EDIT_PERMISSIONS("editPermissions"),    //*done

    // manager operations
    ACTIVATE_USER("activateUser"),          //*done
    CHANGE_ATTRIBUTES("changeAttributes"),  //*done
    CHANGE_PASSWORD("changePassword"),      //*done
    LIST_USERS("listUsers"),                //*done
    REMOVE_USER("removeUser"),              //*done

    // common
    HOME("home"),                           //*done
    POST("post"),                           //*done
    SHOW_PROFILE("showProfile"),            //*done
    BOOK_ROOM("bookRoom"),                  //*done

    // debug
    SHOW_TOKEN("showToken");                //*done

    public final String value;

    private Operation(String value) {
        this.value = value;
    }
}
