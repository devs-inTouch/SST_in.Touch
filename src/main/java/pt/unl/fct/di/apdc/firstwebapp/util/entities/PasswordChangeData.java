package pt.unl.fct.di.apdc.firstwebapp.util.entities;

import pt.unl.fct.di.apdc.firstwebapp.util.entities.clientObjects.UserData;

public class PasswordChangeData extends UserData {
    
    private String newPassword;

    public PasswordChangeData() {}

    
    public PasswordChangeData(String newPassword, String targetUsername) {
        super(targetUsername);
        this.newPassword = newPassword;
    }


    /**
     * @return the newPassword
     */
    public String getNewPassword() {
        return newPassword;
    }

    

}
