package pt.unl.fct.di.apdc.firstwebapp.util.entities.changePassword;

public class ChangePasswordData {

    private String userId, newPassword;

    public ChangePasswordData() {
    }

    public ChangePasswordData(String userId, String newPassword) {
        this.userId = userId;
        this.newPassword = newPassword;
    }

    public String getUserId() {
        return userId;
    }

    public String getNewPassword() {
        return newPassword;
    }
}
