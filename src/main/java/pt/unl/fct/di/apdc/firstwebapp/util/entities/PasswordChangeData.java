package pt.unl.fct.di.apdc.firstwebapp.util.entities;

public class PasswordChangeData extends AbstractData {
    
    private String newPassword;

    public PasswordChangeData() {}

    
    public PasswordChangeData(String newPassword, TokenData token) {
        super(token);
        this.newPassword = newPassword;
    }


    /**
     * @return the newPassword
     */
    public String getNewPassword() {
        return newPassword;
    }

    

}
