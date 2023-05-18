package pt.unl.fct.di.apdc.firstwebapp.util;

public class ModifyData {
    public String username, modUsername, state, role, email, name, password,
            profile, cellPhone, fixPhone, occupation, workplace, address1,
            address2, city, outCode, inCode, NIF;

    public ModifyData(){}

    public ModifyData(String username, String modUsername, String state, String role,
                      String email, String name, String password, String profile,
                      String cellPhone, String fixPhone, String occupation, String workplace,
                      String address1, String address2, String city, String outCode, String inCode,
                      String NIF){
        this.username = username;
        this.modUsername = modUsername;
        this.state = state;
        this.role = role;
        this.email = email;
        this.name = name;
        this.password = password;
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
        boolean result = modUsername == null || email == null || name == null || password == null;
        return result;
    }
}
