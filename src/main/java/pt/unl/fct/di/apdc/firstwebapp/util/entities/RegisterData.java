package pt.unl.fct.di.apdc.firstwebapp.util.entities;

public class RegisterData {
	
	private String username;
	private String name;
	private String email;
	private String password;
	private String studentNumber;
	private String course;
	private String role;
	private String description;
	private String department;

	
	public RegisterData() {}

	public RegisterData(String username, String name, String email, String password, String studentNumber,
						String course, String role, String description, String department) {
		this.username = username;
		this.name = name;
		this.email = email;
		this.password = password;
		this.studentNumber = studentNumber;
		this.course = course;
		this.role = role;
		this.description = description;
		this.department = department;
		this.role = role;


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
	 * @return the student number
	 */
	public String getStudentNumber() { return studentNumber; }

	/**
	 * @return the course
	 */
	public String getCourse() { return course; }

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
