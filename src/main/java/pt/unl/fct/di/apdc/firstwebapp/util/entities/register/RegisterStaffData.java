package pt.unl.fct.di.apdc.firstwebapp.util.entities.register;

public class RegisterStaffData extends RegisterData{


    public RegisterStaffData() {}

    public RegisterStaffData(String username, String name, String email, String password,
                             String role, String description, String department) {
        super(username, name, email, password, role, description, department);
    }

}
