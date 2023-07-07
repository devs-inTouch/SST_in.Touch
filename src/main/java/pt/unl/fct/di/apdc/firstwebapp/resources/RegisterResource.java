package pt.unl.fct.di.apdc.firstwebapp.resources;

import java.util.ArrayList;
import java.util.logging.Logger;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import com.google.cloud.datastore.*;
import org.apache.commons.codec.digest.DigestUtils;

import pt.unl.fct.di.apdc.firstwebapp.util.DatastoreUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.RegisterData;
import pt.unl.fct.di.apdc.firstwebapp.util.enums.DatastoreEntities;

import static pt.unl.fct.di.apdc.firstwebapp.util.enums.UserAttributes.*;

@Path("/register")
public class RegisterResource {

	/**
	 * Logger Object
	 */
	private static final Logger LOG = Logger.getLogger(RegisterResource.class.getName());

	private static final String USER_ALREADY_EXISTS = "Utilizador já criado";

	private final Datastore datastore = DatastoreUtil.getService();

	private final KeyFactory userKeyFactory = datastore.newKeyFactory().setKind(DatastoreEntities.USER.value);



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
					.set(ACTIVATE_ACCOUNT.value, data.getActivateAccount())
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

	@GET
	@Path("/activate")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
	public Response activateUser(@QueryParam("code") String code, @QueryParam("username") String username) {
		Transaction txn = datastore.newTransaction();
		try {
			{
				Key userKey = userKeyFactory.newKey(username);
				Entity user = txn.get(userKey);
				if (user == null) {
					LOG.warning("Failed activate " +username+ " because it does not exist.");
					return Response.status(Status.NOT_FOUND).build();
				}
				String userActivateCode = user.getString("user_activate_code");

				if(!userActivateCode.equals(code)) {
					LOG.warning("Failed activate " + username + " because the code is wrong.");
					return Response.status(Status.BAD_REQUEST).build();
				}

				Entity updatedUser = Entity.newBuilder(user)
						.set(STATE.value, true)
						.remove(ACTIVATE_ACCOUNT.value)
						.build();
				txn.update(updatedUser);

				txn.commit();

				return Response.status(Status.OK).entity("Utilizador ativado").build();
			}
		}finally {
			if (txn.isActive()) {
				txn.rollback();
			}
		}
	}
}
