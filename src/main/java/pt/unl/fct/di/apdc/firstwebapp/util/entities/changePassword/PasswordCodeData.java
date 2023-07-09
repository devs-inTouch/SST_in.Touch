package pt.unl.fct.di.apdc.firstwebapp.util.entities.changePassword;

public class PasswordCodeData {

    private String userId, code;

    public PasswordCodeData() {
    }

    public PasswordCodeData(String userId, String newPassword, String code) {
        this.userId = userId;
        this.code = code;
    }

    public String getUserId() {
        return userId;
    }

    public String getCode() {
        return code;
    }
}
