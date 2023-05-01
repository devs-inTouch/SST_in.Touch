package pt.unl.fct.di.apdc.firstwebapp.resources;

import com.google.cloud.datastore.Datastore;
import com.google.cloud.datastore.DatastoreOptions;
import com.google.cloud.datastore.Entity;
import com.google.cloud.datastore.Key;
import pt.unl.fct.di.apdc.firstwebapp.util.LoginData;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

@Path("/logout")
@Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
public class LogoutResource {

    private final Datastore datastore = DatastoreOptions.getDefaultInstance().getService();

    public LogoutResource(){}

    @POST
    @Path("/")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response doLogout(LoginData data) {
        Key keyToken = datastore.newKeyFactory().setKind("Token").newKey(data.username);
        Entity user = datastore.get(keyToken);
        if(user == null)
            return Response.status(Status.EXPECTATION_FAILED).entity("User is not logged in").build();
        datastore.delete(keyToken);
        return Response.status(Status.OK).build();
    }

}
