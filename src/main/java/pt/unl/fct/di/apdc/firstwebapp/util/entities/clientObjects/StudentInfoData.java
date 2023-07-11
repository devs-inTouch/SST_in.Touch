package pt.unl.fct.di.apdc.firstwebapp.util.entities.clientObjects;

public class StudentInfoData extends UserInfoData{

    String studentNumber;

    public StudentInfoData() {}

    public StudentInfoData(String username, String name, String email, String role, String description, String department, String studentNumber) {
        super(username, name, email, role, description, department);
        this.studentNumber = studentNumber;
    }

    public String getStudentNumber() {
        return studentNumber;
    }
}
