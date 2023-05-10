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
import com.google.cloud.datastore.Transaction;

import pt.unl.fct.di.apdc.firstwebapp.util.entities.TokenData;

@Path("/logout")
@Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
public class LogoutResource {

    private final Datastore datastore = DatastoreOptions.getDefaultInstance().getService();

    private static final Logger LOG = Logger.getLogger(LoginResource.class.getName());

    public LogoutResource(){}

    @POST
    @Path("/")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response logout(TokenData data) {
        Key keyToken = datastore.newKeyFactory().setKind("Token").newKey(data.getUsername());
        Transaction txn = datastore.newTransaction();
        try{
            Entity user = txn.get(keyToken);
            if(user == null)
                return Response.status(Status.EXPECTATION_FAILED).entity("User is not logged in").build();
            txn.delete(keyToken);
            txn.commit();
            return Response.status(Status.OK).build();
		} catch (Exception e) {
			txn.rollback();
			LOG.severe(e.getMessage());
			return Response.status(Status.INTERNAL_SERVER_ERROR).build();
        } finally {
            if(txn.isActive())
                txn.rollback();
        }
    }

}
