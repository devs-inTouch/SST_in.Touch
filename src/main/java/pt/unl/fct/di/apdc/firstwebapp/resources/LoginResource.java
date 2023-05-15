package pt.unl.fct.di.apdc.firstwebapp.resources;

import java.util.Random;
import java.util.logging.Logger;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import org.apache.commons.codec.digest.DigestUtils;

import com.google.cloud.datastore.Datastore;
import com.google.cloud.datastore.DatastoreOptions;
import com.google.cloud.datastore.Entity;
import com.google.cloud.datastore.Key;
import com.google.cloud.datastore.Transaction;
import com.google.gson.Gson;

import pt.unl.fct.di.apdc.firstwebapp.resources.authentication.AuthenticationInterface;
import pt.unl.fct.di.apdc.firstwebapp.resources.authentication.AuthenticationResource;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.AuthToken;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.LoginData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.TokenData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.UserData;
import pt.unl.fct.di.apdc.firstwebapp.util.enums.TokenAttributes;
import pt.unl.fct.di.apdc.firstwebapp.util.enums.UserAttributes;


@Path("/login")
@Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
public class LoginResource {


	private static final String USER_NOT_REGISTERED = "Utilizador nao esta registado";
	private static final String USER_NOT_ACTIVATED = "Utilizador nao esta activo";
	private static final String WRONG_PASSWORD = "Password errada";
	private static final String LINK_ALREADY_USED = "Link já foi utilizado";
	private static final String USER_ACTIVATED = "Utilizador activado";

	/**
	 * Logger Object
	 */
	private static final Logger LOG = Logger.getLogger(LoginResource.class.getName());
	
	private final Gson g = new Gson();

	private final Datastore datastore = DatastoreOptions.getDefaultInstance().getService();
	
	public LoginResource() {}

	@POST
	@Path("/")
	public Response loginUser(LoginData data) {
		
		LOG.fine("Attempt to login user: " + data.getUsername());

		Key userKey = datastore.newKeyFactory().setKind("User").newKey(data.getUsername());
		Entity user = datastore.get(userKey);

		if (user == null) {
			LOG.warning("Failed login attempt for username: " + data.getUsername());
			return Response.status(Status.FORBIDDEN).build();
		}

		if(!user.getBoolean(UserAttributes.STATE.value)) {
			LOG.warning("User must be activated to log-in.");
			return Response.status(Status.BAD_REQUEST).build();
		}

		String hashedPassword = user.getString(UserAttributes.PASSWORD.value);
		if (!hashedPassword.equals(DigestUtils.sha512Hex(data.getPassword()))) {
			LOG.warning("Wrong password for username: " + data.getUsername());
			return Response.status(Status.FORBIDDEN).build();
		}

		String tokenVerification = Long.toString(new Random().nextLong());
		AuthToken token = new AuthToken(data.getUsername(), tokenVerification);

		Key tokenKey = datastore.newKeyFactory().setKind("Token").newKey(data.getUsername());

		Transaction txn = datastore.newTransaction();

		try {
			Entity tkn = Entity.newBuilder(tokenKey)
						.set(TokenAttributes.USERNAME.value, token.getUsername())
						.set(TokenAttributes.ID.value, token.getTokenID())
						.set(TokenAttributes.CREATION_TIME.value, token.getCreationDate())
						.set(TokenAttributes.EXPIRATION_TIME.value, token.getExpirationDate())
						.set(TokenAttributes.VERIFICATION.value, DigestUtils.sha512Hex(tokenVerification))
						.build();

			txn.put(tkn);
			txn.commit();
			LOG.info("User'" + data.getUsername() + "' logged in successfully.");
			return Response.ok(g.toJson(token)).build();

		} catch (Exception e) {
			txn.rollback();
			LOG.severe(e.getMessage());
			return Response.status(Status.INTERNAL_SERVER_ERROR).build();
			
		} finally {
			if (txn.isActive()) {
				txn.rollback();
				return Response.status(Status.INTERNAL_SERVER_ERROR).build();

			}

		}
	}

	@POST
	@Path("/activateUser")
	@Consumes(MediaType.APPLICATION_JSON)
	public Response activateUser(UserData data) {

		TokenData givenToken = data.getToken();

		Key targetKey = datastore.newKeyFactory().setKind("User").newKey(data.getTargetUsername());
		Entity target = datastore.get(targetKey);

		if(target == null)
			return Response.status(Status.FORBIDDEN).entity(USER_NOT_REGISTERED).build();

		if(target.getString("Email verification").equals("yes") && target.getString("state").equals("Inactive"))
			return Response.status(Status.UNAUTHORIZED).entity(LINK_ALREADY_USED).build();

		if(target.getString("Email verification").equals("yes") && target.getString("state").equals("Active"))
			return Response.status(Status.FORBIDDEN).entity(LINK_ALREADY_USED).build();

		// ??????
		AuthenticationInterface auth = new AuthenticationResource();
		auth.activateUser(data.getTargetUsername());

		return Response.status(Status.OK).entity(USER_ACTIVATED).build();
	
	}
}
