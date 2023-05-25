package pt.unl.fct.di.apdc.firstwebapp.resources;
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
import com.google.cloud.datastore.PathElement;

import org.apache.commons.codec.digest.DigestUtils;
import pt.unl.fct.di.apdc.firstwebapp.util.RemoveData;

@Path("/remove")
public class RemoveResource {

    private static final String SU = "SU";
    private static final String GS = "GS";
    private static final String GBO = "GBO";
    private static final String USER = "USER";
    private final Datastore datastore = DatastoreOptions.getDefaultInstance().getService();

    public RemoveResource(){}

    @POST
    @Path("/")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response remove(RemoveData data) {
          Key kToken = datastore.newKeyFactory().setKind("Token").newKey(data.username);
          Entity userToken = datastore.get(kToken);
          Key kRemToken = datastore.newKeyFactory().setKind("Token").newKey(data.userRem);
          if(userToken.getLong("expiration_time") < System.currentTimeMillis())
              return Response.status(Status.EXPECTATION_FAILED).entity("Token Expired").build();
          Key kUser = datastore.newKeyFactory().setKind("User").newKey(data.username);
          Entity user = datastore.get(kUser);
          Key kUserRem = datastore.newKeyFactory().setKind("User").newKey(data.userRem);
          Entity userRem = datastore.get(kUserRem);
          if(userRem == null)
              return Response.status(Status.BAD_REQUEST).entity("User not in database").build();
          String pwd = DigestUtils.sha512Hex(data.password);
          if(!userRem.getString("password").equals(pwd))
              return Response.status(Status.FORBIDDEN).entity("Wrong password").build();
          String userRole = user.getString("role");
          String userRemRole = userRem.getString("role");

          switch (userRole){
              case SU:
                  if(userRemRole.equals(SU))
                      return Response.status(Status.FORBIDDEN).entity("Don't have the permission to remove this user").build();
                  datastore.delete(kUserRem);
                  removeUserRemToken(kRemToken);
                  return Response.status(Status.OK).entity("User Deleted").build();
              case GS:
                  if(userRemRole.equals(SU) || userRemRole.equals(GS))
                      return Response.status(Status.FORBIDDEN).entity("Don't have the permission to remove this user").build();
                  datastore.delete(kUserRem);
                  removeUserRemToken(kRemToken);
                  return Response.status(Status.OK).entity("User Deleted").build();
              case GBO:
                  if(userRemRole.equals(SU) || userRemRole.equals(GS) || userRemRole.equals(GBO))
                      return Response.status(Status.FORBIDDEN).entity("Don't have the permission to remove this user").build();
                  datastore.delete(kUserRem);
                  removeUserRemToken(kRemToken);
                  return Response.status(Status.OK).entity("User Deleted").build();
              case USER:
                  if(!data.username.equals(data.userRem))
                      return Response.status(Status.FORBIDDEN).entity("Don't have the permission to remove this user").build();
                  datastore.delete(kUserRem);
                  datastore.delete(kToken);
                  return Response.status(Status.OK).entity("User Deleted").build();

          }
        return Response.status(Status.OK).entity("NAO CHEGA AQUII").build();
    }


    private void removeUserRemToken(Key kRemToken){
        Entity userRemToken = datastore.get(kRemToken);
        if(userRemToken != null)
            datastore.delete(kRemToken);
    }


}
