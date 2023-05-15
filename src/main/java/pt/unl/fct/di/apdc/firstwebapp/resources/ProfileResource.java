package pt.unl.fct.di.apdc.firstwebapp.resources;

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import com.google.cloud.datastore.Datastore;
import com.google.cloud.datastore.DatastoreOptions;
import com.google.cloud.datastore.Entity;
import com.google.cloud.datastore.Key;
import com.google.cloud.datastore.Transaction;
import com.google.gson.Gson;

import pt.unl.fct.di.apdc.firstwebapp.util.TokenUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.TokenData;
import pt.unl.fct.di.apdc.firstwebapp.util.enums.UserAttributes;

@Path("/profile")
public class ProfileResource {

    private final Datastore datastore = DatastoreOptions.getDefaultInstance().getService();

    private static final Logger LOG = Logger.getLogger(ProfileResource.class.getName());


    private final Gson g = new Gson();

    public ProfileResource(){}

    // TODO resolver escalabilidade

    @POST
    @Path("/")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response showProfile(TokenData data) {
        Key tokenKey = datastore.newKeyFactory().setKind("Token").newKey(data.getUsername());
        Entity token = datastore.get(tokenKey);
        
        if(!TokenUtil.isTokenValid(LOG, data, token))
            return Response.status(Status.FORBIDDEN).build(); //o leitao disse que este era o codigo mais correto para esta situacao

        Key userKey = datastore.newKeyFactory().setKind("User").newKey(data.getUsername());
        Entity user = datastore.get(userKey);

        if (user == null)
            return Response.status(Response.Status.FORBIDDEN).entity("User not in database!").build();
        
        //Add fields to an array to be returned as a json
        List<String> info = new ArrayList<>();
        info.add(user.getString(UserAttributes.USERNAME.value));
        info.add(user.getString(UserAttributes.NAME.value));
        info.add(user.getString(UserAttributes.EMAIL.value));
        info.add(user.getString(UserAttributes.CREATION_TIME.value));
        info.add(user.getString(UserAttributes.ROLE.value));
        info.add(user.getString(UserAttributes.STATE.value));
        info.add(user.getString(UserAttributes.VISIBILITY.value));
        info.add(user.getString(UserAttributes.MOBILE.value));
        info.add(user.getString(UserAttributes.PHONE.value));
        info.add(user.getString(UserAttributes.DEPARTMENT.value));
        info.add(user.getString(UserAttributes.WORK_ADDRESS.value));
        info.add(user.getString(UserAttributes.ADDRESS.value));
        info.add(user.getString(UserAttributes.SECOND_ADDRESS.value));
        info.add(user.getString(UserAttributes.POST_CODE.value));
        info.add(user.getString(UserAttributes.NIF.value));

        return Response.ok(g.toJson(info)).build();
    }
}
