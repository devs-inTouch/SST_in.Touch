package pt.unl.fct.di.apdc.firstwebapp.resources;

import static pt.unl.fct.di.apdc.firstwebapp.util.enums.Globals.AUTH;

import java.util.logging.Logger;

import javax.ws.rs.Consumes;
import javax.ws.rs.HeaderParam;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import pt.unl.fct.di.apdc.firstwebapp.util.TokenUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.TokenData;

@Path("/home")
@Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
public class HomeResource {

    // private final Datastore datastore = DatastoreUtil.getService();
	private static final Logger LOG = Logger.getLogger(HomeResource.class.getName());

    public HomeResource(){}

    @POST
    @Path("/")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response doHome(@HeaderParam(AUTH) String auth, TokenData data) {
        TokenData token = TokenUtil.validateToken(LOG, auth);
        if(token == null)
            return Response.status(Status.FORBIDDEN).build();
        return Response.status(Status.OK).build();
    }
}
