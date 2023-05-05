package pt.unl.fct.di.apdc.firstwebapp.resources;

import com.google.cloud.datastore.Datastore;
import com.google.cloud.datastore.DatastoreOptions;
import com.google.cloud.datastore.Entity;
import com.google.cloud.datastore.Key;

import pt.unl.fct.di.apdc.firstwebapp.util.entities.PasswordChangeData;

import org.apache.commons.codec.digest.DigestUtils;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

@Path("/changePwd")
public class ChangePwdResource {

    private final Datastore datastore = DatastoreOptions.getDefaultInstance().getService();

    public ChangePwdResource() {}

    @POST
    @Path("/")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response changePwd(PasswordChangeData data){
        Key kToken = datastore.newKeyFactory().setKind("Token").newKey(data.username);
        Entity userToken = datastore.get(kToken);
        if(userToken.getLong("expiration_time") < System.currentTimeMillis())
            return Response.status(Response.Status.EXPECTATION_FAILED).entity("Token Expired").build();

        Key kUser = datastore.newKeyFactory().setKind("User").newKey(data.username);
        Entity user = datastore.get(kUser);
        if (user == null)
            return Response.status(Response.Status.BAD_REQUEST).entity("User not in database!").build();
        String pwd = user.getString("password");
        String inputPwd = DigestUtils.sha512Hex(data.password);
        String inputNewPwd = DigestUtils.sha512Hex(data.newPwd);
        String inputConfPwd = DigestUtils.sha512Hex(data.confNewPwd);
        if(!pwd.equals(inputPwd))
            return Response.status(Response.Status.FORBIDDEN).entity("Wrong password").build();
        if(!inputNewPwd.equals(inputConfPwd))
            return Response.status(Response.Status.BAD_REQUEST).entity("New passwords doesn't match").build();
        if(data.newPwd.length() < 4)
            return Response.status(Response.Status.BAD_REQUEST).entity("Password is to short!").build();

        Entity changeUser = Entity.newBuilder(user)
                .set("state", user.getString("state"))
                .set("role", user.getString("role"))
                .set("email", user.getString("email"))
                .set("name", user.getString("name"))
                .set("password", inputNewPwd)
                .set("profile", user.getString("profile"))
                .set("cellPhone", user.getString("cellPhone"))
                .set("fixPhone", user.getString("fixPhone"))
                .set("occupation", user.getString("occupation"))
                .set("workplace", user.getString("workplace"))
                .set("address 1", user.getString("address 1"))
                .set("address 2", user.getString("address 2"))
                .set("city", user.getString("state"))
                .set("outCode", user.getString("state"))
                .set("inCode", user.getString("state"))
                .set("NIF", user.getString("state"))
                //image here
                .build();
        datastore.put(changeUser);

        return Response.status(Response.Status.OK).entity("Password Changed").build();
    }
}
