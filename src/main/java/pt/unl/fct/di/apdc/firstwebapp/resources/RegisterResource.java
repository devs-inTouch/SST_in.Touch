package pt.unl.fct.di.apdc.firstwebapp.resources;

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

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import org.apache.commons.codec.digest.DigestUtils;

import com.google.cloud.datastore.Datastore;
import com.google.cloud.datastore.Entity;
import com.google.cloud.datastore.Key;
import com.google.cloud.datastore.Transaction;

import pt.unl.fct.di.apdc.firstwebapp.util.DatastoreUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.RegisterData;

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

		Key userKey = datastore.newKeyFactory().setKind("User").newKey(data.getUsername());

		Transaction txn = datastore.newTransaction();
		try {
			Entity user = txn.get(userKey);
			if(user != null)
				return Response.status(Status.BAD_REQUEST).entity(USER_ALREADY_EXISTS).build();
			user = Entity.newBuilder(userKey)
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
