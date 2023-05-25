package pt.unl.fct.di.apdc.firstwebapp.util;

public class ChangePwdData {
    public String username, password, newPwd, confNewPwd;

    public ChangePwdData(){}

    public ChangePwdData(String username, String password, String newPwd, String confNewPwd){
        this.username = username;
        this.password = password;
        this.newPwd = newPwd;
        this.confNewPwd = confNewPwd;
    }
}
