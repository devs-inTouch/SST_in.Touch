package pt.unl.fct.di.apdc.firstwebapp.resources;

import static pt.unl.fct.di.apdc.firstwebapp.util.enums.DatastoreEntities.USER;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.Globals.AUTH;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.Globals.DEFAULT_FORMAT;

import static pt.unl.fct.di.apdc.firstwebapp.util.enums.UserAttributes.*;

import java.util.logging.Logger;

import javax.ws.rs.Consumes;
import javax.ws.rs.HeaderParam;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import com.google.cloud.datastore.Datastore;
import com.google.cloud.datastore.Entity;
import com.google.cloud.datastore.Key;
import com.google.cloud.datastore.KeyFactory;
import com.google.cloud.datastore.Transaction;

import pt.unl.fct.di.apdc.firstwebapp.resources.permissions.PermissionsHolder;
import pt.unl.fct.di.apdc.firstwebapp.util.DatastoreUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.TokenUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.clientObjects.TokenData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.clientObjects.UserData;
import pt.unl.fct.di.apdc.firstwebapp.util.enums.DatastoreEntities;
import pt.unl.fct.di.apdc.firstwebapp.util.enums.UserRole;

@Path("/userActivation")
@Consumes(MediaType.APPLICATION_JSON + DEFAULT_FORMAT)
@Produces(MediaType.APPLICATION_JSON + DEFAULT_FORMAT)
public class ActivationResource {

	/**
	 * Logger Object
	 */
	private static final Logger LOG = Logger.getLogger(ActivationResource.class.getName());

	private final Datastore datastore = DatastoreUtil.getService();

	private static final String USER_NOT_ALLOWED_TO_CREATE_NUCLEO = "User not allowed to create nucleo";

	private final KeyFactory userKeyFactory = datastore.newKeyFactory().setKind(DatastoreEntities.USER.value);

	private PermissionsHolder ph = PermissionsHolder.getInstance();

	@POST
	@Path("/activate")
	public Response activateUser(@HeaderParam(AUTH) String auth, UserData data) {

        TokenData token = TokenUtil.validateToken(LOG, auth);

        if (token == null)
            return Response.status(Status.UNAUTHORIZED).build();

        /*if (!ph.hasAccess(ACTIVATE_USER.value, token.getRole()))
            return Response.status(Status.FORBIDDEN).build();*/

		Key userKey = datastore.newKeyFactory().setKind(USER.value).newKey(token.getUsername());
		Entity user = datastore.get(userKey);

		if (user == null)
			return Response.status(Status.NOT_FOUND).build();

		if(!UserRole.isStaff(user.getString("user_role"))){
			return Response.status(Response.Status.FORBIDDEN).entity(USER_NOT_ALLOWED_TO_CREATE_NUCLEO).build();
		}

		Key targetKey = datastore.newKeyFactory().setKind(USER.value).newKey(data.getTargetUsername());
		Entity target = datastore.get(targetKey);

		if (target == null)
			return Response.status(Status.NOT_FOUND).build();

		/*if (!ph.hasPermission(ACTIVATE_USER.value, token.getRole(), target.getString(ROLE.value)))
			return Response.status(Status.FORBIDDEN).build();*/


		Transaction txn = datastore.newTransaction();

		try {
			target = Entity.newBuilder(target)
					.set(STATE.value, true)
					.build();
			
			txn.update(target);
			txn.commit();
			LOG.info("User'" + data.getTargetUsername() + "' activated successfully.");
			return Response.ok("STAFF activated").build();
									
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
