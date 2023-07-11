package pt.unl.fct.di.apdc.firstwebapp.resources;

import static pt.unl.fct.di.apdc.firstwebapp.util.enums.DatastoreEntities.OPERATION;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.DatastoreEntities.ROLE;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.Globals.AUTH;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.Globals.*;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.Operation.EDIT_ACCESSES;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.Operation.EDIT_PERMISSIONS;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.RoleAttributes.ACCESS;

import java.util.HashMap;
import java.util.Map;
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

import com.google.cloud.datastore.BooleanValue;
import com.google.cloud.datastore.Datastore;
import com.google.cloud.datastore.Entity;
import com.google.cloud.datastore.Key;
import com.google.cloud.datastore.KeyFactory;
import com.google.cloud.datastore.PathElement;
import com.google.cloud.datastore.Transaction;
import com.google.gson.Gson;

import pt.unl.fct.di.apdc.firstwebapp.resources.permissions.PermissionsHolder;
import pt.unl.fct.di.apdc.firstwebapp.util.DatastoreUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.TokenUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.AccessData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.OperationData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.PermissionData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.PermissionsData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.RoleRegisterData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.clientObjects.TokenData;
import pt.unl.fct.di.apdc.firstwebapp.util.enums.Operation;
import pt.unl.fct.di.apdc.firstwebapp.util.enums.UserRole;

@Path("/debug")
@Consumes(MediaType.APPLICATION_JSON + DEFAULT_FORMAT)
@Produces(MediaType.APPLICATION_JSON + DEFAULT_FORMAT)
public class DebugResource {

	private static final Logger LOG = Logger.getLogger(PermissionsResource.class.getName());

    private final Datastore datastore = DatastoreUtil.getService();
    
    private final Gson g = new Gson();

    private PermissionsHolder ph = PermissionsHolder.getInstance();
    
    
    public DebugResource(){}

    @POST
    @Path("/permissions")
    public Response debugPermissions(PermissionsData data) {

        // TokenData token = TokenUtil.validateToken(LOG, auth);

        // if (token == null)
        //     return Response.status(Status.UNAUTHORIZED).build();

        Map<String, Map<String, Boolean>> res = new HashMap<>(N_ROLES);

        for (Entry<String, Boolean> e : data.getPermissions().entrySet()) {

            String[] parts = e.getKey().split("/");
            String clientRole = parts[0];
            String targetRole = parts[1];

            Map<String, Boolean> client = res.get(clientRole);
            client = client == null ? new HashMap<>(N_ROLES) : client;

            Key key = datastore.newKeyFactory()
                    .addAncestors(
                        PathElement.of(OPERATION.value, data.getOperationID()),
                        PathElement.of(ROLE.value, clientRole)
                        )
                    .setKind(ROLE.value)
                    .newKey(targetRole);

            Entity permission = datastore.get(key);

            client.put(targetRole, permission.getBoolean(ACCESS.value));

            res.put(clientRole, client);
        }

        return Response.ok(g.toJson(res)).build();
    }

}
