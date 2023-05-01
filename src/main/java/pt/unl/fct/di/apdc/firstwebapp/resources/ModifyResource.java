package pt.unl.fct.di.apdc.firstwebapp.resources;

import com.google.cloud.Timestamp;
import com.google.cloud.datastore.Datastore;
import com.google.cloud.datastore.DatastoreOptions;
import com.google.gson.Gson;
import org.apache.commons.codec.digest.DigestUtils;
import pt.unl.fct.di.apdc.firstwebapp.util.ModifyData;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;
import com.google.cloud.datastore.Entity;
import com.google.cloud.datastore.Key;

@Path("/modify")
public class ModifyResource {
    private static final String SU = "SU";
    private static final String GS = "GS";
    private static final String GBO = "GBO";
    private static final String USER = "USER";

    private final Datastore datastore = DatastoreOptions.getDefaultInstance().getService();

    public ModifyResource() {}

    @POST
    @Path("/")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response modifyUser(ModifyData data){
        if (data.hasMandatoryInputs())
            return Response.status(Status.BAD_REQUEST).entity("Mandatory fields are empty").build();
        Key kToken = datastore.newKeyFactory().setKind("Token").newKey(data.username);
        Entity userToken = datastore.get(kToken);
        if(userToken.getLong("expiration_time") < System.currentTimeMillis())
            return Response.status(Status.EXPECTATION_FAILED).entity("Token Expired").build();
        Key kUser = datastore.newKeyFactory().setKind("User").newKey(data.username);
        Entity user = datastore.get(kUser);
        Key kUserMod = datastore.newKeyFactory().setKind("User").newKey(data.modUsername);
        Entity userMod = datastore.get(kUserMod);
        if(userMod == null)
            return Response.status(Status.FORBIDDEN).entity("User not in database").build();
        String userRole = user.getString("role");
        String userModRole = userMod.getString("role");
       switch (userRole){
            case SU:
                if(userModRole.equals(SU))
                    return Response.status(Status.FORBIDDEN).entity("Not enough permissions!").build();
                modifyAllUser(data, kUserMod, userMod);
                return Response.status(Status.OK).entity("User updated").build();
            case GS:
                if (userModRole.equals(SU) || userModRole.equals(GS))
                    return Response.status(Status.FORBIDDEN).entity("Not enough permissions!").build();
                modifyAllUser(data, kUserMod, userMod);
                return Response.status(Status.OK).entity("User updated").build();
            case GBO:
                if(!userModRole.equals(USER))
                    return Response.status(Status.FORBIDDEN).entity("Not enough permissions!").build();
                modifyAllUser(data, kUserMod, userMod);
                return Response.status(Status.OK).entity("User updated").build();
            case USER:
                if(!data.username.equals(data.modUsername))
                    return Response.status(Status.FORBIDDEN).entity("Not enough permissions!").build();
                modifyUser(data, kUserMod, userMod);
                return Response.status(Status.OK).entity("User updated").build();
        }
        return Response.status(Status.OK).entity("NAO CHEGA AQUII").build();

    }

    private void modifyUser(ModifyData data, Key kUserMod, Entity userMod){
        Entity newUser = Entity.newBuilder(kUserMod)
                .set("state", userMod.getString("state"))
                .set("role", userMod.getString("role"))
                .set("user_creation_time", userMod.getLong("user_creation_time"))
                .set("email", userMod.getString("email"))
                .set("name", userMod.getString("name"))
                .set("password", DigestUtils.sha512Hex(data.password))
                .set("profile", data.profile)
                .set("cellPhone", data.cellPhone)
                .set("fixPhone", data.fixPhone)
                .set("occupation", data.occupation)
                .set("workplace", data.workplace)
                .set("address 1", data.address1)
                .set("address 2", data.address2)
                .set("city", data.city)
                .set("outCode", data.outCode)
                .set("inCode", data.inCode)
                .set("NIF", data.NIF)
                .build();
        datastore.put(newUser);
    }

    private void modifyAllUser(ModifyData data, Key kUserMod, Entity userMod) {
        Entity newUser = Entity.newBuilder(kUserMod)
                .set("state", data.state)
                .set("role", data.role)
                .set("user_creation_time", userMod.getLong("user_creation_time"))
                .set("email", data.email)
                .set("name", data.name)
                .set("password", DigestUtils.sha512Hex(data.password))
                .set("profile", data.profile)
                .set("cellPhone", data.cellPhone)
                .set("fixPhone", data.fixPhone)
                .set("occupation", data.occupation)
                .set("workplace", data.workplace)
                .set("address 1", data.address1)
                .set("address 2", data.address2)
                .set("city", data.city)
                .set("outCode", data.outCode)
                .set("inCode", data.inCode)
                .set("NIF", data.NIF)
                .build();
        datastore.put(newUser);
    }

}
