package pt.unl.fct.di.apdc.firstwebapp.util;

public class RegisterData {
    private static final String UNDEFINED = "Undefined";
    public String username, email, name, pwd,
            confPwd, profile, cellPhone, fixPhone, occupation,
            workplace, address1, address2, city, outCode, inCode,
            NIF, profileImg;


    public  RegisterData(){}
    public RegisterData(String username, String email, String name, String pwd,
                        String confPwd, String profile, String cellPhone, String fixPhone,
                        String occupation, String workplace, String address1, String address2,
                        String city, String outCode, String inCode, String NIF, String profileImg) {
        this.username = username;
        this.email = email;
        this.name = name;
        this.pwd = pwd;
        this.confPwd = confPwd;
        this.profile = profile;
        this.cellPhone = cellPhone;
        this.fixPhone = fixPhone;
        this.occupation = occupation;
        this.workplace = workplace;
        this.address1 = address1;
        this.address2 = address2;
        this.city = city;
        this.outCode = outCode;
        this.inCode = inCode;
        this.NIF = NIF;
    }

    public boolean hasMandatoryInputs(){
        boolean result = username == null || email == null || name == null || pwd == null;
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
