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

import com.google.cloud.datastore.Datastore;
import com.google.cloud.datastore.Entity;
import com.google.cloud.datastore.Key;
import com.google.cloud.datastore.Transaction;

import pt.unl.fct.di.apdc.firstwebapp.util.DatastoreUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.TokenUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.TokenData;
import pt.unl.fct.di.apdc.firstwebapp.util.enums.DatastoreEntities;

@Path("/logout")
@Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
public class LogoutResource {

    private final Datastore datastore = DatastoreUtil.getService();

    private static final Logger LOG = Logger.getLogger(LogoutResource.class.getName());

    public LogoutResource(){}

    @POST
    @Path("/")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response logout(@HeaderParam(AUTH) String auth) {
        TokenData givenToken = TokenUtil.validateToken(LOG, auth);

        if (givenToken == null)
            return Response.status(Status.FORBIDDEN).build();

        Transaction txn = datastore.newTransaction();
        try{
            Key tokenKey = datastore.newKeyFactory().setKind(DatastoreEntities.TOKEN.value).newKey(givenToken.getSub());
            Entity user = txn.get(tokenKey);

            if(user == null)
                return Response.status(Status.EXPECTATION_FAILED).entity("User is not logged in").build();
                
            txn.delete(tokenKey);
            txn.commit();
            return Response.status(Status.OK).build();

		} catch (Exception e) {
			txn.rollback();
			LOG.severe(e.getMessage());
			return Response.status(Status.INTERNAL_SERVER_ERROR).build();

        } finally {
            if(txn.isActive()) {
                txn.rollback();
                return Response.status(Status.INTERNAL_SERVER_ERROR).build();
            }

        }
    }

}
