package pt.unl.fct.di.apdc.firstwebapp.resources;

<<<<<<< Updated upstream
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.UserAttributes.CREATION_TIME;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.UserAttributes.DEPARTMENT;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.UserAttributes.DESCRIPTION;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.UserAttributes.EMAIL;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.UserAttributes.FOLLOWERS;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.UserAttributes.FOLLOWING;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.UserAttributes.NAME;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.UserAttributes.PASSWORD;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.UserAttributes.ROLE;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.UserAttributes.STATE;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.UserAttributes.STUDENT_NUMBER;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.UserAttributes.VISIBILITY;

import java.util.ArrayList;
import java.util.logging.Logger;

=======
>>>>>>> Stashed changes
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import com.google.cloud.datastore.*;

import pt.unl.fct.di.apdc.firstwebapp.util.DatastoreUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.RegisterData;
import pt.unl.fct.di.apdc.firstwebapp.util.enums.UserAttributes;
import pt.unl.fct.di.apdc.firstwebapp.util.enums.UserRole;

import org.apache.commons.codec.digest.DigestUtils;

import java.util.ArrayList;
import java.util.logging.Logger;

@Path("/register")
public class RegisterResource {

	/**
	 * Logger Object
	 */
	private static final Logger LOG = Logger.getLogger(RegisterResource.class.getName());

	private static final String USER_ALREADY_EXISTS = "Utilizador já criado";

	private final Datastore datastore = DatastoreUtil.getService();


	public RegisterResource() {}

	@POST
	@Path("/")
	@Consumes(MediaType.APPLICATION_JSON)
	public Response registerUser(RegisterData data){
		//ATENCION: If added a new field here, remember to added in ProfileResource
		// if (data.hasMandatoryInputs())
		// 	return Response.status(Status.BAD_REQUEST).entity(MANDATORY_FIELDS).build();

		// if(!data.validPwd() || !data.validEmail())
		// 	return Response.status(Status.BAD_REQUEST).entity(INVALID_INPUTS).build();

		Key userKey = datastore.newKeyFactory().setKind("User").newKey(data.getUsername());

		Transaction txn = datastore.newTransaction();
		try {
			Entity user = txn.get(userKey);
			if(user != null)
				return Response.status(Status.BAD_REQUEST).entity(USER_ALREADY_EXISTS).build();
			user = Entity.newBuilder(userKey)
<<<<<<< Updated upstream
					.set(NAME.value, data.getName())
					.set(PASSWORD.value, DigestUtils.sha512Hex(data.getPassword()))
					.set(CREATION_TIME.value, System.currentTimeMillis())
					.set(EMAIL.value, data.getEmail())
					.set(STUDENT_NUMBER.value, data.getStudentNumber())
					.set(ROLE.value, data.getRole())
					.set(DEPARTMENT.value, data.getDepartment())
					.set(DESCRIPTION.value, data.getDescription())
					.set(STATE.value, false)
					.set(VISIBILITY.value, false)
					.set(FOLLOWERS.value, new ArrayList<>())
					.set(FOLLOWING.value, new ArrayList<>())
=======
					.set(UserAttributes.NAME.value, data.getName())
					.set(UserAttributes.PASSWORD.value, DigestUtils.sha512Hex(data.getPassword()))
					.set(UserAttributes.CREATION_TIME.value, System.currentTimeMillis())
					.set(UserAttributes.EMAIL.value, data.getEmail())
					.set(UserAttributes.STUDENT_NUMBER.value, data.getStudentNumber())
					.set(UserAttributes.ROLE.value, UserRole.UNASSIGNED.value)
					.set(UserAttributes.DEPARTMENT.value, data.getDepartment())
					.set(UserAttributes.DESCRIPTION.value, data.getDescription())
					.set(UserAttributes.STATE.value, false)
					.set(UserAttributes.VISIBILITY.value, false)
					.set(UserAttributes.FOLLOWERS.value,ListValue.newBuilder().build())
					.set(UserAttributes.FOLLOWING.value, ListValue.newBuilder().build())
>>>>>>> Stashed changes
					.build();

			txn.add(user);
			txn.commit();
			LOG.fine("User registered" + data.getUsername());
			return Response.status(Status.OK).entity("Utilizador registado").build();

		} finally {
			if (txn.isActive()) {
				txn.rollback();
			}
		}

	}
}
