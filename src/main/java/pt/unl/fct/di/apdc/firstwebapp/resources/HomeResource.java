package pt.unl.fct.di.apdc.firstwebapp.resources;

import java.util.logging.Logger;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import com.google.cloud.datastore.Datastore;
import com.google.cloud.datastore.DatastoreOptions;
import com.google.cloud.datastore.Entity;
import com.google.cloud.datastore.Key;

import pt.unl.fct.di.apdc.firstwebapp.util.TokenUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.TokenData;
@Path("/home")
@Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
public class HomeResource {

    private final Datastore datastore = DatastoreOptions.getDefaultInstance().getService();
	private static final Logger LOG = Logger.getLogger(HomeResource.class.getName());

    public HomeResource(){}

    @POST
    @Path("/")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response doHome(TokenData data) {
        Key tokenKey = datastore.newKeyFactory().setKind("Token").newKey(data.getUsername());
        Entity user = datastore.get(tokenKey);
        if(!TokenUtil.isTokenValid(LOG, data, user))
            return Response.status(Status.FORBIDDEN).build();
        return Response.status(Status.OK).build();
    }
}
