package pt.unl.fct.di.apdc.firstwebapp.util.entities.register;

public abstract class RegisterData {
	
	private String username;
	private String name;
	private String email;
	private String password;
	private String role;
	private String description;
	private String department;


	
	public RegisterData() {}

	public RegisterData(String username, String name, String email, String password,
						String role, String description, String department) {
		this.username = username;
		this.name = name;
		this.password = password;
		this.email = email;
		this.role = role;
		//this.studentNumber = studentNumber;
		this.description = description;
		this.department = department;
		//this.activateAccount = activateAccount;


	}

	/**
	 * @return the username
	 */
	public String getUsername() {
		return username;
	}

	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}

	/**
	 * @return the password
	 */
	public String getPassword() {
		return password;
	}

	/**
	 * @return the email
	 */
	public String getEmail() {
		return email;
	}


	/**
	 * @return the role
	 */
	public String getRole() {
		return role;
	}
	/**
	 * @return the description
	 */
	public String getDescription() { return description; }

	/**
	 * @return the department
	 */
	public String getDepartment() {
		return department;
	}

}
