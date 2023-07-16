package pt.unl.fct.di.apdc.firstwebapp.resources;

import static pt.unl.fct.di.apdc.firstwebapp.util.enums.DatastoreEntities.PERMISSION;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.Globals.AUTH;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.Globals.DEFAULT_FORMAT;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.Operation.EDIT_ACCESSES;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.Operation.EDIT_PERMISSIONS;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.PermissionsAttributes.VALUE;

import java.util.LinkedList;
import java.util.Map.Entry;
import java.util.Queue;
import java.util.logging.Logger;

import javax.ws.rs.Consumes;
import javax.ws.rs.HeaderParam;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.ResponseBuilder;
import javax.ws.rs.core.Response.Status;

import com.google.cloud.datastore.Datastore;
import com.google.cloud.datastore.Entity;
import com.google.cloud.datastore.Key;
import com.google.cloud.datastore.KeyFactory;
import com.google.cloud.datastore.Transaction;

import pt.unl.fct.di.apdc.firstwebapp.resources.permissions.PermissionsHolder;
import pt.unl.fct.di.apdc.firstwebapp.util.DatastoreUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.TokenUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.AccessData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.PermissionsData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.clientObjects.TokenData;

@Path("/permissions")
@Produces(MediaType.APPLICATION_JSON + DEFAULT_FORMAT)
public class PermissionsResource {
    //TODO change permisions initial values to better fit security protocols

	private static final Logger LOG = Logger.getLogger(PermissionsResource.class.getName());

    private final Datastore datastore = DatastoreUtil.getService();

    private final KeyFactory accessKeyFactory =  datastore.newKeyFactory().setKind(VALUE.value);
    private final KeyFactory permissionKeyFactory =  datastore.newKeyFactory().setKind(PERMISSION.value);

    private PermissionsHolder ph = PermissionsHolder.getInstance();
    

    public PermissionsResource() {}

    @POST
    @Path("/access/edit")
    @Consumes(MediaType.APPLICATION_JSON + DEFAULT_FORMAT)
    public Response editAccesses(@HeaderParam(AUTH) String auth, AccessData data) {

        TokenData token = TokenUtil.validateToken(LOG, auth);

        if (token == null)
            return Response.status(Status.UNAUTHORIZED).build();

        if (!ph.hasAccess(EDIT_ACCESSES.value, token.getRole()))
            return Response.status(Status.FORBIDDEN).build();

        Transaction txn = datastore.newTransaction();

        try {

            for (Entry<String, Boolean> e : data.getAccessPermissions().entrySet()) {

                Key roleAccessKey = accessKeyFactory.newKey(data.getOperationID() + e.getKey());

                Entity roleAccess = Entity.newBuilder(roleAccessKey)
                                    .set(VALUE.value, e.getValue())
                                    .build();
                
                txn.put(roleAccess);
                ph.editAccess(data.getOperationID(), e.getKey(), e.getValue());
            }

            txn.commit();
            LOG.info("Accesses for " + data.getOperationID() + " updated successfully!");
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

    @POST
    @Path("/over/edit")
    @Consumes(MediaType.APPLICATION_JSON + DEFAULT_FORMAT)
    public Response editPermissions(@HeaderParam(AUTH) String auth, PermissionsData data) {

        TokenData token = TokenUtil.validateToken(LOG, auth);

        if (token == null)
            return Response.status(Status.UNAUTHORIZED).build();

        if (!ph.hasAccess(EDIT_PERMISSIONS.value, token.getRole()))
            return Response.status(Status.FORBIDDEN).build();

        Queue<Entity> toLoad = new LinkedList<>();

        for (Entry<String, Boolean> e : data.getPermissions().entrySet()) {

            Key permissionKey = permissionKeyFactory.newKey(data.getOperationID() + e.getKey());

            Entity permission = Entity.newBuilder(permissionKey)
                                .set(VALUE.value, e.getValue())
                                .build();
            
            toLoad.add(permission);

            String[] keyParts = e.getKey().split("-");

            ph.editPermission(data.getOperationID(), keyParts[0], keyParts[1], e.getValue());

        }

        Status res = DatastoreUtil.loadToDatastore(datastore, toLoad, LOG);

        ResponseBuilder rb = Response.status(res);

        if (res.equals(Status.OK))
            rb.entity("{}");

        return rb.build();
    }



}
