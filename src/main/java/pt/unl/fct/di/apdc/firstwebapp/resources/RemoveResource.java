package pt.unl.fct.di.apdc.firstwebapp.resources;

import static pt.unl.fct.di.apdc.firstwebapp.util.enums.DatastoreEntities.USER;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.Globals.AUTH;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.Operation.REMOVE_USER;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.TokenAttributes.ROLE;

import java.util.logging.Logger;

import javax.ws.rs.Consumes;
import javax.ws.rs.HeaderParam;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import com.google.cloud.datastore.Datastore;
import com.google.cloud.datastore.DatastoreOptions;
import com.google.cloud.datastore.Entity;
import com.google.cloud.datastore.Key;
import com.google.cloud.datastore.Transaction;

import pt.unl.fct.di.apdc.firstwebapp.resources.permissions.PermissionsHolder;
import pt.unl.fct.di.apdc.firstwebapp.util.TokenUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.clientObjects.TokenData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.clientObjects.UserData;

@Path("/remove")
public class RemoveResource {

    private final Datastore datastore = DatastoreOptions.getDefaultInstance().getService();

    private static final Logger LOG = Logger.getLogger(RemoveResource.class.getName());

    private PermissionsHolder ph = PermissionsHolder.getInstance();

    public RemoveResource(){}

    @POST
    @Path("/")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response remove(@HeaderParam(AUTH) String auth, UserData data) {

        TokenData token = TokenUtil.validateToken(LOG, auth);

        if (token == null)
            return Response.status(Status.UNAUTHORIZED).build();

        if (!ph.hasAccess(REMOVE_USER.value, token.getRole()))
            return Response.status(Status.FORBIDDEN).build();

        Key targetKey = datastore.newKeyFactory().setKind(USER.value).newKey(data.getTargetUsername());
        Entity target = datastore.get(targetKey);

        if (target == null)
            return Response.status(Status.NOT_FOUND).build();

        if (!ph.hasPermission(REMOVE_USER.value, token.getRole(), target.getString(ROLE.value)))
            return Response.status(Status.FORBIDDEN).build();

        Transaction txn = datastore.newTransaction();

        try {
			
            TokenUtil.deleteToken(token.getUsername());
			txn.delete(targetKey);
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
