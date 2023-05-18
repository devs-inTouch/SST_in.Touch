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
@Path("/home")
@Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
public class HomeResource {

    private final Datastore datastore = DatastoreOptions.getDefaultInstance().getService();

    public HomeResource(){}

    @POST
    @Path("/")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response doHome(LoginData data) {
        Key keyToken = datastore.newKeyFactory().setKind("Token").newKey(data.username);
        Entity user = datastore.get(keyToken);
        if(user.getLong("expiration_time") < System.currentTimeMillis())
            return Response.status(Response.Status.EXPECTATION_FAILED).entity("Token Expired").build();
        return Response.status(Status.OK).build();
    }
}
