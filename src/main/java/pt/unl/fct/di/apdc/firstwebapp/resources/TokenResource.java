package pt.unl.fct.di.apdc.firstwebapp.resources;

import java.util.logging.Logger;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import com.google.cloud.datastore.Datastore;
import com.google.cloud.datastore.DatastoreOptions;
import com.google.cloud.datastore.Entity;
import com.google.cloud.datastore.Key;
import com.google.gson.Gson;

import pt.unl.fct.di.apdc.firstwebapp.util.TokenUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.TokenData;

@Path("/token")
public class TokenResource {

    private final Datastore datastore = DatastoreOptions.getDefaultInstance().getService();

	private static final Logger LOG = Logger.getLogger(TokenResource.class.getName());

    private final Gson g = new Gson();

    public TokenResource() {
    }

    @POST
    @Path("/")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response showToken(TokenData data) {

        Key tokenKey = datastore.newKeyFactory().setKind("Token").newKey(data.getUsername());
        Entity token = datastore.get(tokenKey);

        if(!TokenUtil.isTokenValid(LOG, data, token))
            return Response.status(Status.FORBIDDEN).build();

        return Response.status(Response.Status.OK).entity(g.toJson(data)).build();
        
    }


}
