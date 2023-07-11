package pt.unl.fct.di.apdc.firstwebapp.util.entities.register;

public class RegisterStaffData extends RegisterData{

    private String image;

    public RegisterStaffData() {}

    public RegisterStaffData(String username, String name, String email, String password,
                             String role, String description, String department, String image) {
        super(username, name, email, password, role, description, department);
        this.image = image;
    }

    public String getImage() {
        return image;
    }
}
