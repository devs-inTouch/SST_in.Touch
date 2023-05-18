package pt.unl.fct.di.apdc.firstwebapp.resources;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import com.google.cloud.datastore.*;
import com.google.gson.Gson;

import pt.unl.fct.di.apdc.firstwebapp.util.LogoutData;

import java.util.ArrayList;
import java.util.List;

@Path("/token")
public class TokenResource {

    private final Datastore datastore = DatastoreOptions.getDefaultInstance().getService();

    private final Gson g = new Gson();

    public TokenResource() {
    }

    @POST
    @Path("/")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response showToken(LogoutData data){
        Key kUserToken = datastore.newKeyFactory().setKind("Token").newKey(data.username);
        Entity userToken = datastore.get(kUserToken);
        if(userToken.getLong("expiration_time") < System.currentTimeMillis())
            return Response.status(Response.Status.EXPECTATION_FAILED).entity("Token Expired").build();
        String userID = userToken.getKey().getName();
        String name = userToken.getString("user");
        String role = userToken.getString("role");
        String tokenID = userToken.getString("tokenID");
        long creationTime = userToken.getLong("creation_time");
        long expirationTime = userToken.getLong("expiration_time");
        List<String> info = new ArrayList<>();
        info.add("User: " + userID);
        info.add("Name: " + name);
        info.add("Role: " + role);
        info.add("TokenID: " + tokenID);
        info.add("CreationTime: " + creationTime);
        info.add("ExpirationTime: " + expirationTime);
        return Response.status(Response.Status.OK).entity(g.toJson(info)).build();
    }


}
