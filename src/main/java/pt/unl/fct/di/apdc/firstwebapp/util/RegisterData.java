package pt.unl.fct.di.apdc.firstwebapp.util;

public class RegisterData {
    private static final String UNDEFINED = "Undefined";
    public String usernameClip, email, name, pwd,
            confPwd, department, role;


    public  RegisterData(){}
    public RegisterData(String usernameClip, String email, String name, String pwd,
                        String confPwd, String role, String department) {
        this.usernameClip = usernameClip;
        this.email = email;
        this.name = name;
        this.pwd = pwd;
        this.confPwd = confPwd;
        this.role = role;
        this.department = department;
    }

    public boolean hasMandatoryInputs(){
        boolean result = usernameClip == null || email == null || name == null || pwd == null || role == null;
        return result;
    }

    public boolean validEmail() {
        String EMAIL = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$";
        boolean result = email.matches(EMAIL);
        return result;
    }

    public boolean validPwd(){
        boolean result = pwd.equals(confPwd) && pwd.length() > 4;
        return result;
    }

}
