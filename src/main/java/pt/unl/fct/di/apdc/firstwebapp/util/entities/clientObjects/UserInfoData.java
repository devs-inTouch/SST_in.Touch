package pt.unl.fct.di.apdc.firstwebapp.util.entities.clientObjects;

public abstract class  UserInfoData {

    private String username, name, email, role, description, department;

    public UserInfoData() {}

    public UserInfoData(String username, String name, String email, String role, String description, String department) {
    	this.username = username;
    	this.name = name;
    	this.email = email;
    	this.role = role;
    	this.description = description;
    	this.department = department;
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
