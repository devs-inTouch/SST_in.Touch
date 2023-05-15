package pt.unl.fct.di.apdc.firstwebapp.util.entities;

public class RegisterData {

	public static final String USERNAME = "user_id";
	public static final String NAME = "user_name";
	public static final String PASSWORD = "user_password";
	public static final String EMAIL = "user_email";
	public static final String CREATION_TIME = "user_creation_time";
	public static final String TYPE = "user_type";
	public static final String STATE = "user_state_activated";
	public static final String STUDENT_NUMBER = "user_student_number";
	public static final String COURSE = "user_course";
	public static final String DESCRIPTION = "user_description";

	public static final String VISIBILITY = "user_visibility";
	public static final String MOBILE = "user_mobile_phone_number";
	public static final String PHONE = "user_phone_number";
	public static final String OCCUPATION = "user_occupation";
	public static final String WORK_ADDRESS = "user_work_address";
	public static final String ADDRESS = "user_address";
	public static final String SECOND_ADDRESS = "user_second_address";
	public static final String POST_CODE = "user_post_code";
	public static final String NIF = "user_nif";

	
	private String username;
	private String name;
	private String email;
	private String password;
	private String studentNumber;
	private String course;
	private String description;
	private String department;

	/*private boolean visible;
	private String mobilePhoneNumber;
	private String phoneNumber;
	private String workAddress;
	private String address;
	private String secondAddress;
	private String postCode;
	private String nif;*/

	
	public RegisterData() {}

	public RegisterData(String username, String name, String email, String password, String studentNumber,
						String course, String description, String department) {
		this.username = username;
		this.name = name;
		this.email = email;
		this.password = password;
		this.studentNumber = studentNumber;
		this.course = course;
		this.description = description;
		this.department = department;

	}

	public boolean isValid() {
		return !(this.username == null || this.password == null || this.email == null);
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
