package pt.unl.fct.di.apdc.firstwebapp.resources;

import static pt.unl.fct.di.apdc.firstwebapp.util.enums.Globals.AUTH;

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

import pt.unl.fct.di.apdc.firstwebapp.util.DatastoreUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.TokenUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.TokenData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.UserData;
import pt.unl.fct.di.apdc.firstwebapp.util.enums.DatastoreEntities;
import pt.unl.fct.di.apdc.firstwebapp.util.enums.UserAttributes;

@Path("/activateUser")
@Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
public class ActivationResource {

	/**
	 * Logger Object
	 */
	private static final Logger LOG = Logger.getLogger(ActivationResource.class.getName());

	private final Datastore datastore = DatastoreUtil.getService();

	private final KeyFactory userKeyFactory = datastore.newKeyFactory().setKind(DatastoreEntities.USER.value);

	@POST
	@Path("/")
	@Consumes(MediaType.APPLICATION_JSON)
	public Response activateUser(@HeaderParam(AUTH) String auth, UserData data) {

		TokenData givenToken = TokenUtil.validateToken(LOG, auth);

		if (givenToken == null)
			return Response.status(Status.FORBIDDEN).build();

		Key targetKey = userKeyFactory.newKey(data.getTargetUsername());
		Entity target = datastore.get(targetKey);

		if (target == null)
			return Response.status(Status.FORBIDDEN).build();

		Transaction txn = datastore.newTransaction();

		try {
			Entity activatedTarget = Entity.newBuilder(targetKey)
									.set(UserAttributes.STATE.value, true)
									.build();
			
			txn.update(activatedTarget);
			txn.commit();
			LOG.info("User'" + data.getTargetUsername() + "' activated successfully.");
			return Response.ok("{}").build();
									
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
