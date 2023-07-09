package pt.unl.fct.di.apdc.firstwebapp.resources;

import static pt.unl.fct.di.apdc.firstwebapp.util.enums.Globals.AUTH;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.Globals.DEFAULT_FORMAT;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.Operation.SHOW_TOKEN;

import java.util.logging.Logger;

import javax.ws.rs.Consumes;
import javax.ws.rs.HeaderParam;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import com.google.gson.Gson;

import pt.unl.fct.di.apdc.firstwebapp.resources.permissions.PermissionsHolder;
import pt.unl.fct.di.apdc.firstwebapp.util.TokenUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.TokenData;;

@Path("/token")
public class TokenResource {

    protected static final String PATH = "token";

	private static final Logger LOG = Logger.getLogger(TokenResource.class.getName());

    private final Gson g = new Gson();

    public TokenResource() {
    }

    @POST
    @Path("/")
    @Consumes(MediaType.APPLICATION_JSON + DEFAULT_FORMAT)
    @Produces(MediaType.APPLICATION_JSON + DEFAULT_FORMAT)
    public Response showToken(@HeaderParam(AUTH) String auth) {

        TokenData token = TokenUtil.validateToken(LOG, auth);

        if (token == null || !PermissionsHolder.getInstance().hasAccess(SHOW_TOKEN.value, token.getRole()))
            return Response.status(Status.FORBIDDEN).build();

        return Response.status(Status.OK).entity(g.toJson(token)).build();
        
    }


}
