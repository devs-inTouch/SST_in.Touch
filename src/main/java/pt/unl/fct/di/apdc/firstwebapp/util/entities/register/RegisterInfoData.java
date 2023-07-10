package pt.unl.fct.di.apdc.firstwebapp.util.entities.register;

public class RegisterInfoData {

    private String username;
    private String name;
    private String email;
    private String studentNumber;
    private String course;
    private String role;
    private String description;
    private String department;

    public RegisterInfoData() {}

    public RegisterInfoData(String username, String name, String email,
    						 String role) {
    	this.username = username;
    	this.name = name;
    	this.email = email;
    	this.role = role;
    }

    public String getUsername() {
    	return username;
    }

    public String getName() {
    	return name;
    }

    public String getEmail() {
    	return email;
    }

    public String getStudentNumber() {
    	return studentNumber;
    }

    public String getCourse() {
    	return course;
    }

    public String getRole() {
    	return role;
    }

    public String getDescription() {
    	return description;
    }

    public String getDepartment() {
    	return department;
    }

}
