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

import com.google.gson.Gson;

import pt.unl.fct.di.apdc.firstwebapp.util.TokenUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.TokenData;

@Path("/token")
public class TokenResource {

    // private final Datastore datastore = DatastoreUtil.getService();

	private static final Logger LOG = Logger.getLogger(TokenResource.class.getName());

    private final Gson g = new Gson();

    public TokenResource() {
    }

    @POST
    @Path("/")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response showToken(@HeaderParam(AUTH) String auth) {

        TokenData token = TokenUtil.validateToken(LOG, auth);

        if(token == null)
            return Response.status(Status.FORBIDDEN).build();

        return Response.status(Response.Status.OK).entity(g.toJson(token)).build();
        
    }


}
