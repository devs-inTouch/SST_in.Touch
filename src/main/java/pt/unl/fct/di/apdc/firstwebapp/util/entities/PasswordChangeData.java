package pt.unl.fct.di.apdc.firstwebapp.util.entities;

public class PasswordChangeData extends UserData {
    
    private String newPassword;

    public PasswordChangeData() {}

    
    public PasswordChangeData(String newPassword, String targetUsername, TokenData token) {
        super(token, targetUsername);
        this.newPassword = newPassword;
    }


    /**
     * @return the newPassword
     */
    public String getNewPassword() {
        return newPassword;
    }

    

}
