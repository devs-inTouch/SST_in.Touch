package pt.unl.fct.di.apdc.firstwebapp.resources;

import static pt.unl.fct.di.apdc.firstwebapp.util.enums.DatastoreEntities.ACCESS;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.DatastoreEntities.PERMISSION;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.Globals.ACCESS_FORMAT;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.Globals.AUTH;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.Globals.DEFAULT_FORMAT;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.Globals.PERMISSION_FORMAT;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.PermissionsAttributes.VALUE;

import java.util.LinkedList;
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

import com.google.cloud.datastore.BooleanValue;
import com.google.cloud.datastore.Datastore;
import com.google.cloud.datastore.Entity;
import com.google.cloud.datastore.Key;
import com.google.cloud.datastore.KeyFactory;
import com.google.cloud.datastore.Transaction;

import pt.unl.fct.di.apdc.firstwebapp.resources.permissions.PermissionsHolder;
import pt.unl.fct.di.apdc.firstwebapp.util.DatastoreUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.TokenUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.OperationRegisterData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.RoleRegisterData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.clientObjects.TokenData;
import pt.unl.fct.di.apdc.firstwebapp.util.enums.Operation;
import pt.unl.fct.di.apdc.firstwebapp.util.enums.UserRole;

@Path("/devTools")
public class DevelopmentResource {

	private static final Logger LOG = Logger.getLogger(PermissionsResource.class.getName());

    private final Datastore datastore = DatastoreUtil.getService();

    private final KeyFactory accessKeyFactory =  datastore.newKeyFactory().setKind(ACCESS.value);
    private final KeyFactory permissionKeyFactory =  datastore.newKeyFactory().setKind(PERMISSION.value);

    private PermissionsHolder ph = PermissionsHolder.getInstance();


    public DevelopmentResource() {}

    @POST
    @Path("/registerOperation")
    @Consumes(MediaType.APPLICATION_JSON + DEFAULT_FORMAT)
    @Produces(MediaType.APPLICATION_JSON + DEFAULT_FORMAT)
    public Response registerOperation(@HeaderParam(AUTH) String auth, OperationRegisterData data) {

        TokenData token = TokenUtil.validateToken(LOG, auth);

        if (token == null)
            return Response.status(Status.UNAUTHORIZED).build();

        // if (!ph.hasAccess(EDIT_ACCESSES.value, token.getRole()))
        //     return Response.status(Status.FORBIDDEN).build();

        Queue<Entity> toLoad = new LinkedList<>();

        for (UserRole cr : UserRole.values()) {

            Operation newOperation = Operation.toOperation(data.getOperationID());

            toLoad.add(registerAccess(newOperation, cr.value));

            if (newOperation.hasPermissions)
                for (UserRole tr : UserRole.values())
                    toLoad.add(registerPermission(newOperation, cr.value, tr.value));

        }

        Status res = DatastoreUtil.loadToDatastore(datastore, toLoad, LOG);

        ResponseBuilder rb = Response.status(res);

        if (res.equals(Status.OK))
            rb.entity("{}");

        return rb.build();
    }

    @POST
    @Path("/registerAllOperations")
    @Produces(MediaType.APPLICATION_JSON + DEFAULT_FORMAT)
    public Response registerAllOperations(@HeaderParam(AUTH) String auth) {

        TokenData token = TokenUtil.validateToken(LOG, auth);

        if (token == null)
            return Response.status(Status.UNAUTHORIZED).build();

        // if (!ph.hasAccess(EDIT_ACCESSES.value, token.getRole()))
        //     return Response.status(Status.FORBIDDEN).build();

        Queue<Entity> toLoad = new LinkedList<>();

        for (Operation o : Operation.values())
            for (UserRole cr : UserRole.values()) {

                toLoad.add(registerAccess(o, cr.value));

                if (o.hasPermissions)
                    for (UserRole tr : UserRole.values())
                        toLoad.add(registerPermission(o, cr.value, tr.value));
            }

        Status res = DatastoreUtil.loadToDatastore(datastore, toLoad, LOG);

        ResponseBuilder rb = Response.status(res);

        if (res.equals(Status.OK))
            rb.entity("{}");

        return rb.build();
        
    }

    @POST
    @Path("/registerRole")
    @Consumes(MediaType.APPLICATION_JSON + DEFAULT_FORMAT)
    @Produces(MediaType.APPLICATION_JSON + DEFAULT_FORMAT)
    public Response registerRole(@HeaderParam(AUTH) String auth, RoleRegisterData data) {

        TokenData token = TokenUtil.validateToken(LOG, auth);

        if (token == null)
            return Response.status(Status.UNAUTHORIZED).build();

        // if (!ph.hasAccess(EDIT_ACCESSES.value, token.getRole()))
        //     return Response.status(Status.FORBIDDEN).build();

        Transaction txn = datastore.newTransaction();

        try {

            for (Operation o : Operation.values()) {

                UserRole newRole = UserRole.toRole(data.getRoleID());
    
                txn.put(registerAccess(o, newRole.value));

                for (UserRole r : UserRole.values()) {
    
                        if (o.hasPermissions)
                            txn.put(
                                registerPermission(o, r.value, newRole.value),
                                registerPermission(o, newRole.value, r.value));
    
                    }
                }

            txn.commit();
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

    private Entity registerAccess(Operation o, String clientRole) {

        Key accessKey = accessKeyFactory
                        .newKey(String.format(ACCESS_FORMAT,
                                            o.value,
                                            clientRole));

        Entity access = Entity.newBuilder(accessKey)
                        .set(VALUE.value,
                            BooleanValue.newBuilder(true)
                                .setExcludeFromIndexes(true)
                                .build())
                        .build();

        return access;

    }

    private Entity registerPermission(Operation o, String clientRole, String targetRole) {

        Key permissionKey = permissionKeyFactory
                        .newKey(String.format(PERMISSION_FORMAT,
                                            o.value,
                                            clientRole,
                                            targetRole));

        Entity permission = Entity.newBuilder(permissionKey)
                        .set(VALUE.value,
                            BooleanValue.newBuilder(true)
                                .setExcludeFromIndexes(true)
                                .build())
                        .build();

        return permission;

    }
    
}
