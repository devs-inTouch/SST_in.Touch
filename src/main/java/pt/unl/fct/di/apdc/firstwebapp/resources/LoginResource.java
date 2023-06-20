package pt.unl.fct.di.apdc.firstwebapp.resources;

import java.util.logging.Logger;

import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import org.apache.commons.codec.digest.DigestUtils;

import com.google.cloud.datastore.Datastore;
import com.google.cloud.datastore.Entity;
import com.google.cloud.datastore.Key;
import com.google.cloud.datastore.KeyFactory;
import com.google.cloud.datastore.Transaction;
import com.google.gson.Gson;

import pt.unl.fct.di.apdc.firstwebapp.resources.authentication.AuthToken;
import pt.unl.fct.di.apdc.firstwebapp.util.DatastoreUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.LoginData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.clientObjects.ClientTokenData;
import pt.unl.fct.di.apdc.firstwebapp.util.enums.DatastoreEntities;
import pt.unl.fct.di.apdc.firstwebapp.util.enums.TokenAttributes;
import pt.unl.fct.di.apdc.firstwebapp.util.enums.UserAttributes;


@Path("/login")
@Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
public class LoginResource {

	/**
	 * Logger Object
	 */
	private static final Logger LOG = Logger.getLogger(LoginResource.class.getName());
	
	private final Gson g = new Gson();

	private final Datastore datastore = DatastoreUtil.getService();

	private final KeyFactory userKeyFactory = datastore.newKeyFactory().setKind(DatastoreEntities.USER.value);
	private final KeyFactory tokenKeyFactory = datastore.newKeyFactory().setKind(DatastoreEntities.TOKEN.value);
	
	public LoginResource() {}

	@POST
	@Path("/")
	public Response loginUser(LoginData data) {
		
		LOG.fine("Attempt to login user: " + data.getUsername());

		Key userKey = userKeyFactory.newKey(data.getUsername());
		Entity user = datastore.get(userKey);

		if (user == null) {
			LOG.warning("Failed login attempt for username: " + data.getUsername());
			return Response.status(Status.NOT_FOUND).build();
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

		AuthToken token = new AuthToken(data.getUsername());

		Key tokenKey = tokenKeyFactory.newKey(data.getUsername());

		Transaction txn = datastore.newTransaction();

		try {
			Entity tkn = Entity.newBuilder(tokenKey)
						.set(TokenAttributes.USERNAME.value, token.getUsername())
						.set(TokenAttributes.CREATION_TIME.value, token.getCreationDate())
						.set(TokenAttributes.EXPIRATION_TIME.value, token.getExpirationDate())
						.build();

			txn.put(tkn);
			txn.commit();
			LOG.info("User'" + data.getUsername() + "' logged in successfully.");
			return Response.ok(g.toJson(new ClientTokenData(token.getEncodedToken()))).build();

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
}
