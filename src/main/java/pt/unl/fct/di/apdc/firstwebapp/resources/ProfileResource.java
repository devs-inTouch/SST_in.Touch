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
        Key kUserToken = datastore.newKeyFactory().setKind("Token").newKey(data.username);
        Entity userToken = datastore.get(kUserToken);
        if(userToken.getLong("expiration_time") < System.currentTimeMillis())
            return Response.status(Response.Status.EXPECTATION_FAILED).entity("Token Expired").build();
        Key kUser = datastore.newKeyFactory().setKind("User").newKey(data.username);
        Entity user = datastore.get(kUser);
        if (user == null)
            return Response.status(Response.Status.FORBIDDEN).entity("User not in database!").build();

        String userID = user.getKey().getName();
        String role = user.getString("role");
        String email = user.getString("email");
        String name = user.getString("name");
        String profile = user.getString("profile");
        String cellPhone = user.getString("cellPhone");
        String fixPhone = user.getString("fixPhone");
        String occupation = user.getString("occupation");
        String workplace = user.getString("workplace");
        String address1 = user.getString("address 1");
        String address2 = user.getString("address 2");
        String city = user.getString("city");
        String outCode = user.getString("outCode");
        String inCode = user.getString("inCode");
        String NIF = user.getString("NIF");
        List<String> info = new ArrayList<>();
        info.add(userID);
        info.add(name);
        info.add(role);
        info.add(email);
        info.add(profile);
        info.add(cellPhone);
        info.add(fixPhone);
        info.add(occupation);
        info.add(workplace);
        info.add(address1);
        info.add(address2);
        info.add(city);
        info.add(outCode);
        info.add(inCode);
        info.add(NIF);
        return Response.ok(g.toJson(info)).build();
    }
}
