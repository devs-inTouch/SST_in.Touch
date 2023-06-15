package pt.unl.fct.di.apdc.firstwebapp.resources;

import com.google.cloud.datastore.Datastore;
import com.google.cloud.datastore.DatastoreOptions;
import com.google.gson.Gson;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.logging.Logger;

@Path("/gmailer")
@Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
public class GmailerResoruce {

    private static final Logger LOG = Logger.getLogger(GmailerResoruce.class.getName());

    private final Gson g = new Gson();

    private final Datastore datastore = DatastoreOptions.getDefaultInstance().getService();


    public GmailerResoruce() {
    }

    @POST
    @Path("/")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response sendFCTMail() {
    	LOG.info("Update Hoje na FCT mail ");

    	return Response.ok().build();
    }



}
