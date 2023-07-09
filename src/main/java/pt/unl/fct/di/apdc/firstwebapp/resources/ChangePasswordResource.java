package pt.unl.fct.di.apdc.firstwebapp.resources;

import static pt.unl.fct.di.apdc.firstwebapp.util.enums.Globals.AUTH;

import java.util.logging.Logger;

import javax.ws.rs.Consumes;
import javax.ws.rs.HeaderParam;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import org.apache.commons.codec.digest.DigestUtils;

import com.google.cloud.datastore.Datastore;
import com.google.cloud.datastore.Entity;
import com.google.cloud.datastore.Key;

import pt.unl.fct.di.apdc.firstwebapp.util.DatastoreUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.TokenUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.PasswordChangeData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.TokenData;

@Path("/changePwd")
public class ChangePasswordResource {

    private final Datastore datastore = DatastoreUtil.getService();
	private static final Logger LOG = Logger.getLogger(ChangePasswordResource.class.getName());

    public ChangePasswordResource() {}

    @POST
    @Path("/")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response changePwd(@HeaderParam(AUTH) String auth, PasswordChangeData data) {

        TokenData givenToken = TokenUtil.validateToken(LOG, auth);
        if(givenToken == null)
            return Response.status(Status.FORBIDDEN).build();

        Key targetKey = datastore.newKeyFactory().setKind("User").newKey(data.getTargetUsername());
        Entity target = datastore.get(targetKey);
        if (target == null)
            return Response.status(Status.BAD_REQUEST).entity("User not in database!").build();

        String hashedPwd = DigestUtils.sha512Hex(data.getNewPassword());

        Entity changeUser = Entity.newBuilder(target)
                .set("state", target.getString("state"))
                .set("role", target.getString("role"))
                .set("email", target.getString("email"))
                .set("name", target.getString("name"))
                .set("password", hashedPwd)
                .set("profile", target.getString("profile"))
                .set("cellPhone", target.getString("cellPhone"))
                .set("fixPhone", target.getString("fixPhone"))
                .set("occupation", target.getString("occupation"))
                .set("workplace", target.getString("workplace"))
                .set("address 1", target.getString("address 1"))
                .set("address 2", target.getString("address 2"))
                .set("city", target.getString("state"))
                .set("outCode", target.getString("state"))
                .set("inCode", target.getString("state"))
                .set("NIF", target.getString("state"))
                //image here
                .build();
        datastore.put(changeUser);

        return Response.ok().entity("{}").build();
    }
}
