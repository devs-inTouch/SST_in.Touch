package pt.unl.fct.di.apdc.firstwebapp.util.entities.register;

public class RegisterStudentData extends RegisterData {

    private String studentNumber;
    private String activateCode;

    private String image;

    public RegisterStudentData() {
    }


    public RegisterStudentData(String username, String name, String email, String password,
                               String role, String description, String department, String image,
                               String studentNumber, String activateCode) {
        super(username, name, email, password, role, description, department);
        this.studentNumber = studentNumber;
        this.activateCode = activateCode;
        this.image = image;
    }

    public String getStudentNumber() {
        return studentNumber;
    }

    public String getActivateCode() {
        return activateCode;
    }

    public String getImage() {
        return image;
    }
}