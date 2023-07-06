package pt.unl.fct.di.apdc.firstwebapp.resources;

import static pt.unl.fct.di.apdc.firstwebapp.util.enums.Globals.AUTH;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.Globals.DEFAULT_FORMAT;

import javax.ws.rs.Consumes;
import javax.ws.rs.HeaderParam;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

@Path("/moderation")
@Consumes(MediaType.APPLICATION_JSON + DEFAULT_FORMAT)
@Produces(MediaType.APPLICATION_JSON + DEFAULT_FORMAT)
public class ModerationResource {

    @POST
    @Path("/report")
    public Response reportPost(@HeaderParam(AUTH) String auth) {
        return Response.status(Status.NOT_IMPLEMENTED).build();
    }
    
}
