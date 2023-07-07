package pt.unl.fct.di.apdc.firstwebapp.resources;

import static pt.unl.fct.di.apdc.firstwebapp.util.enums.DatastoreEntities.OPERATION;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.DatastoreEntities.ROLE;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.Globals.AUTH;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.Globals.DEFAULT_FORMAT;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.RoleAttributes.ACCESS;

import java.util.Map.Entry;
import java.util.logging.Logger;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
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
import com.google.cloud.datastore.PathElement;
import com.google.cloud.datastore.Transaction;

import pt.unl.fct.di.apdc.firstwebapp.resources.permissions.PermissionsHolder;
import pt.unl.fct.di.apdc.firstwebapp.util.DatastoreUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.TokenUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.AccessData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.OperationRegisterData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.PermissionsData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.RoleRegisterData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.TokenData;
import pt.unl.fct.di.apdc.firstwebapp.util.enums.Operation;
import pt.unl.fct.di.apdc.firstwebapp.util.enums.UserRole;

@Path("/permissions")
public class PermissionsResource {
    //TODO change permisions initial values to better fit security protocols

	private static final Logger LOG = Logger.getLogger(PermissionsResource.class.getName());

    private final Datastore datastore = DatastoreUtil.getService();

    private PermissionsHolder ph = PermissionsHolder.getInstance();
    

    public PermissionsResource() {}
    
    @GET
    @Path("/list")
    @Produces(MediaType.APPLICATION_JSON + DEFAULT_FORMAT)
    public Response listPermissions(@HeaderParam(AUTH) String auth) {
        return Response.status(Status.NOT_IMPLEMENTED).build();
    }

    @POST
    @Path("/access/edit")
    @Consumes(MediaType.APPLICATION_JSON + DEFAULT_FORMAT)
    @Produces(MediaType.APPLICATION_JSON + DEFAULT_FORMAT)
    public Response editAccesses(@HeaderParam(AUTH) String auth, AccessData data) {

        TokenData token = TokenUtil.validateToken(LOG, auth);

        if (token == null /*|| !ph.hasAccess(EDIT_ACCESSES.value, token.getRole())*/)
            return Response.status(Status.FORBIDDEN).build();

        KeyFactory clientAccessKeyFactory = datastore.newKeyFactory()
            .addAncestor(PathElement.of(OPERATION.value, data.getOperationID()))
            .setKind(ROLE.value);

        Transaction txn = datastore.newTransaction();

        try {

            for (Entry<String, Boolean> e : data.getAccessPermissions().entrySet()) {
                Key roleAccessKey = clientAccessKeyFactory.newKey(e.getKey());
                Entity roleAccess = Entity.newBuilder(roleAccessKey)
                                    .set(ACCESS.value, e.getValue())
                                    .build();
                
                txn.put(roleAccess);
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
    @Path("/edit")
    @Consumes(MediaType.APPLICATION_JSON + DEFAULT_FORMAT)
    @Produces(MediaType.APPLICATION_JSON + DEFAULT_FORMAT)
    public Response editPermissions(@HeaderParam(AUTH) String auth, PermissionsData data) {

        TokenData token = TokenUtil.validateToken(LOG, auth);

        if (token == null /*|| !PermissionsHolder.getInstance().hasPermission(SHOW_TOKEN.value, token.getRole())*/)
            return Response.status(Status.FORBIDDEN).build();

        Transaction txn = datastore.newTransaction();

        try {
            for (Entry<String, Boolean> e : data.getPermissions().entrySet()) {

                String[] parts = e.getKey().split("/");
                String clientRole = parts[0];
                String targetRole = parts[1];

                KeyFactory permissionsKeyFactory = datastore.newKeyFactory()
                    .addAncestors(
                        PathElement.of(OPERATION.value, data.getOperationID()),
                        PathElement.of(ROLE.value, clientRole))
                    .setKind(ROLE.value);
                    
                Key permissionKey = permissionsKeyFactory.newKey(targetRole);

                Entity permission = Entity.newBuilder(permissionKey)
                                    .set(ACCESS.value, e.getValue())
                                    .build();
                
                txn.put(permission);
                ph.editPermission(auth, clientRole, targetRole, e.getValue());
            }

            txn.commit();
            LOG.info("Permissions for " + data.getOperationID() + " updated successfully!");
            return Response.ok("{}").build();

        } catch (Exception e) {
			txn.rollback();
			LOG.severe(e.getMessage());
			return Response.status(Status.INTERNAL_SERVER_ERROR).entity(e.getLocalizedMessage()).build();
			
		} finally {
			if (txn.isActive()) {
				txn.rollback();
				return Response.status(Status.INTERNAL_SERVER_ERROR).build();
			}
		}
    }

    @POST
    @Path("/register/operation")
    @Consumes(MediaType.APPLICATION_JSON + DEFAULT_FORMAT)
    @Produces(MediaType.APPLICATION_JSON + DEFAULT_FORMAT)
    public Response registerOperation(@HeaderParam(AUTH) String auth, OperationRegisterData data) {

        TokenData token = TokenUtil.validateToken(LOG, auth);

        if (token == null /*|| !PermissionsHolder.getInstance().hasPermission(SHOW_TOKEN.value, token.getRole())*/)
            return Response.status(Status.FORBIDDEN).build();

        Transaction txn = datastore.newTransaction();

        try {
            for (UserRole cr : UserRole.values()) {

                    KeyFactory accessesKeyFactory = datastore.newKeyFactory()
                                .addAncestor(PathElement.of(OPERATION.value, data.getOperationID()))
                                .setKind(ROLE.value);

                    Key accessKey = accessesKeyFactory.newKey(cr.value);

                    Entity access = Entity.newBuilder(accessKey)
                                    .set(ACCESS.value, true)
                                    .build();
                for (UserRole tr : UserRole.values()) {

                    KeyFactory permissionsKeyFactory = datastore.newKeyFactory()
                                .addAncestors(PathElement.of(OPERATION.value, data.getOperationID()),
                                    PathElement.of(ROLE.value, cr.value))
                                .setKind(ROLE.value);

                    Key permissionKey = permissionsKeyFactory.newKey(tr.value);

                    Entity permission = Entity.newBuilder(permissionKey)
                                    .set(ACCESS.value, true)
                                    .build();

                    txn.put(access, permission);

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

    @POST
    @Path("/register/role")
    @Consumes(MediaType.APPLICATION_JSON + DEFAULT_FORMAT)
    @Produces(MediaType.APPLICATION_JSON + DEFAULT_FORMAT)
    public Response registerRole(@HeaderParam(AUTH) String auth, RoleRegisterData data) {

        TokenData token = TokenUtil.validateToken(LOG, auth);

        if (token == null /*|| !PermissionsHolder.getInstance().hasPermission(SHOW_TOKEN.value, token.getRole())*/)
            return Response.status(Status.FORBIDDEN).build();

        Transaction txn = datastore.newTransaction();

        try {

            for (Operation o : Operation.values()) {
                for (UserRole r : UserRole.values()) {

                    KeyFactory accessesKeyFactory = datastore.newKeyFactory()
                                .addAncestor(PathElement.of(OPERATION.value, o.value))
                                .setKind(ROLE.value);

                    Key accessKey = accessesKeyFactory.newKey(data.getRoleID());

                    Entity access = Entity.newBuilder(accessKey)
                                    .set(ACCESS.value, true)
                                    .build();


                    KeyFactory permissionsKeyFactory = datastore.newKeyFactory()
                                .addAncestors(PathElement.of(OPERATION.value, o.value),
                                    PathElement.of(ROLE.value, r.value))
                                .setKind(ROLE.value);

                    Key permissionKey = permissionsKeyFactory.newKey(data.getRoleID());

                    Entity permission = Entity.newBuilder(permissionKey)
                                    .set(ACCESS.value, true)
                                    .build();


                    KeyFactory reversePermissionsKeyFactory = datastore.newKeyFactory()
                                .addAncestors(PathElement.of(OPERATION.value, o.value),
                                    PathElement.of(ROLE.value, data.getRoleID()))
                                .setKind(ROLE.value);

                    Key reversePermissionKey = reversePermissionsKeyFactory.newKey(r.value);

                    Entity reversePermission = Entity.newBuilder(reversePermissionKey)
                                    .set(ACCESS.value, true)
                                    .build();


                    txn.put(access, permission, reversePermission);
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


}
