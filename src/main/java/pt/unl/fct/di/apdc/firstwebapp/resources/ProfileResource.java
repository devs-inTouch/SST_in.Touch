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

@Path("/profile")
public class ProfileResource {

    private final Datastore datastore = DatastoreOptions.getDefaultInstance().getService();

    private final Gson g = new Gson();

    public ProfileResource(){}
    @POST
    @Path("/")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response showProfile(LogoutData data) {
        Key userKeyToken = datastore.newKeyFactory().setKind("Token").newKey(data.usernameClip);
        Entity userToken = datastore.get(userKeyToken);
        if(userToken.getLong("expiration_time") < System.currentTimeMillis())
            return Response.status(Response.Status.EXPECTATION_FAILED).entity("Token Expired").build();
        Key kUser = datastore.newKeyFactory().setKind("User").newKey(data.usernameClip);

        Transaction txt = datastore.newTransaction();
        try{
            Entity user = txt.get(kUser);
            if (user == null)
                return Response.status(Response.Status.FORBIDDEN).entity("User not in database!").build();
            String userID = user.getKey().getName();
            String role = user.getString("role");
            String email = user.getString("email");
            String name = user.getString("name");
            String department = user.getString("department");
            //Add fields to an array to be returned as a json
            List<String> info = new ArrayList<>();
            info.add(userID);
            info.add(role);
            info.add(email);
            info.add(name);
            info.add(department);

            txt.commit();
            return Response.ok(g.toJson(info)).build();
        }finally {
            if(txt.isActive())
                txt.rollback();
        }
    }
}
