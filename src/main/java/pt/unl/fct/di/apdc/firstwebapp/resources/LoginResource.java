package pt.unl.fct.di.apdc.firstwebapp.resources;

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import com.google.cloud.datastore.*;
import com.google.gson.Gson;
import org.apache.commons.codec.digest.DigestUtils;

import pt.unl.fct.di.apdc.firstwebapp.util.AuthToken;
import pt.unl.fct.di.apdc.firstwebapp.util.LoginData;




@Path("/login")
@Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
public class LoginResource {
	private static final String STATE = "Inactive";

	private static final String ROLE = "User";

	/**
	 * Logger Object
	 */
	private static final Logger LOG = Logger.getLogger(LoginResource.class.getName());

	private final Datastore datastore = DatastoreOptions.getDefaultInstance().getService();
	private final Gson g = new Gson();
	public LoginResource() {} // Nothing to be done here
	
	@POST
	@Path("/")
	@Consumes(MediaType.APPLICATION_JSON)
	public Response doLogin(LoginData data) { 
		LOG.fine("Attempt to login user: " + data.username);
		Key key = datastore.newKeyFactory().setKind("User").newKey(data.username);
		Entity user = datastore.get(key);
		if(user == null)
			return Response.status(Status.BAD_REQUEST).entity("User is not registered").build();
		if(user.getString("state").equals(STATE))
			return Response.status(Status.FORBIDDEN).entity("User not Activated").build();

		String pwd = DigestUtils.sha512Hex(data.password);
		if(!pwd.equals(user.getString("password")))
			return Response.status(Status.UNAUTHORIZED).entity("Wrong Password").build();

		String role = user.getString("role");
		List<String> info = new ArrayList<>();
		info.add(role);
		AuthToken t = new AuthToken(data.username);
		Key userKey =
				datastore.newKeyFactory().setKind("Token").newKey(t.username);
		Entity userToken = Entity.newBuilder(userKey)
				.set("user", user.getString("name"))
				.set("role", user.getString("role"))
				.set("tokenID", t.tokenID)
				.set("creation_time", t.creationData)
				.set("expiration_time", t.expirationData)
				.build();
		datastore.put(userToken);
		return Response.ok(g.toJson(info)).build();
	}
	
}
