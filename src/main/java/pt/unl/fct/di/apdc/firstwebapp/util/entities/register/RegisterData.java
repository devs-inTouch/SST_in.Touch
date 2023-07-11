package pt.unl.fct.di.apdc.firstwebapp.util.entities.register;

public abstract class RegisterData {
	private String username;
	private String name;
	private String email;
	private String password;
	private String role;
	private String description;
	private String department;


	public RegisterData() {
	}

	public RegisterData(String username, String name, String email, String password,
						String role, String description, String department) {
		this.username = username;
		this.name = name;
		this.password = password;
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

	public String getPassword() {
		return password;
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