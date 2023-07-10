package pt.unl.fct.di.apdc.firstwebapp.resources;

import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.logging.Logger;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import com.google.cloud.datastore.*;
import org.apache.commons.codec.digest.DigestUtils;

import pt.unl.fct.di.apdc.firstwebapp.util.DatastoreUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.register.RegisterData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.register.RegisterStaffData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.register.RegisterStudentData;
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


	private static final String KIND = "User";


	public RegisterResource() {}

	@POST
	@Path("/createStudent")
	@Consumes(MediaType.APPLICATION_JSON)
	public Response registerStudent(RegisterStudentData data){

		Key userKey = datastore.newKeyFactory().setKind("User").newKey(data.getUsername());
		Query<Entity> query = Query.newEntityQueryBuilder()
				.setKind(KIND)
				.setFilter(StructuredQuery.PropertyFilter.eq("user_email", data.getEmail()))
				.build();
		QueryResults<Entity> result = datastore.run(query);
		Transaction txn = datastore.newTransaction();
		try {
			Entity user = txn.get(userKey);
			if(user != null)
				return Response.status(Status.BAD_REQUEST).entity(USER_ALREADY_EXISTS).build();
			if(result.hasNext())
				return Response.status(Status.BAD_REQUEST).entity("Email já registado").build();
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
					.set(ACTIVATE_ACCOUNT.value, data.getActivateCode())
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

	@POST
	@Path("/createSTAFF")
	@Consumes(MediaType.APPLICATION_JSON)
	public Response registerStaff(RegisterStaffData data){

		Key userKey = datastore.newKeyFactory().setKind("User").newKey(data.getUsername());
		Query<Entity> query = Query.newEntityQueryBuilder()
				.setKind(KIND)
				.setFilter(StructuredQuery.PropertyFilter.eq("user_email", data.getEmail()))
				.build();
		QueryResults<Entity> result = datastore.run(query);

		Transaction txn = datastore.newTransaction();
		try {
			Entity user = txn.get(userKey);
			if(user != null)
				return Response.status(Status.BAD_REQUEST).entity(USER_ALREADY_EXISTS).build();
			if(result.hasNext())
				return Response.status(Status.BAD_REQUEST).entity("Email já registado").build();
			user = Entity.newBuilder(userKey)
					.set(NAME.value, data.getName())
					.set(PASSWORD.value, DigestUtils.sha512Hex(data.getPassword()))
					.set(CREATION_TIME.value, System.currentTimeMillis())
					.set(EMAIL.value, data.getEmail())
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
					return Response.status(Status.NOT_FOUND).entity("Utilizador não encontrado").build();
				}

				String userActivateCode = user.getString(ACTIVATE_ACCOUNT.value);

				if(!userActivateCode.equals(code)) {
					return Response.status(Status.BAD_REQUEST).entity("Failed activate " + username + " because the code is wrong.").build();
				}

				Entity updatedUser = Entity.newBuilder(user)
						.set(STATE.value, true)
						.remove(ACTIVATE_ACCOUNT.value)
						.build();
				txn.update(updatedUser);

				txn.commit();
				//JOptionPane.showMessageDialog(null, "User " + username + " has been activated!");

				return Response.temporaryRedirect(new java.net.URI("https://steel-sequencer-385510.oa.r.appspot.com/?activated=true")).build();
			}
		} catch (URISyntaxException e) {
			throw new RuntimeException(e);
		} finally {
			if (txn.isActive()) {
				txn.rollback();
			}
		}
	}
}
