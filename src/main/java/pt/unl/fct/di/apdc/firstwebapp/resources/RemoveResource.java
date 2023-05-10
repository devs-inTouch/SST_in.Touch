package pt.unl.fct.di.apdc.firstwebapp.resources;
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

import pt.unl.fct.di.apdc.firstwebapp.util.TokenUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.TokenData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.UserData;
import pt.unl.fct.di.apdc.firstwebapp.util.enums.UserAttributes;

@Path("/remove")
public class RemoveResource {

    private final Datastore datastore = DatastoreOptions.getDefaultInstance().getService();

    private static final Logger LOG = Logger.getLogger(RemoveResource.class.getName());

    public RemoveResource(){}

    @POST
    @Path("/")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response remove(UserData data) {

        TokenData givenToken = data.getToken();

        Key tokenKey = datastore.newKeyFactory().setKind("Token").newKey(givenToken.getUsername());
        Entity token = datastore.get(tokenKey);
        
        if(!TokenUtil.isTokenValid(LOG, givenToken, token))
            return Response.status(Status.FORBIDDEN).build();

        Key managerKey = datastore.newKeyFactory().setKind("User").newKey(givenToken.getUsername());
        Entity manager = datastore.get(managerKey);

        Key targetKey = datastore.newKeyFactory().setKind("User").newKey(data.getTargetUsername());
        Entity target = datastore.get(targetKey);
        if(target == null)
            return Response.status(Status.BAD_REQUEST).entity("User not in database").build();

        String managerRole = manager.getString(UserAttributes.ROLE.value);
        String targetRole = target.getString(UserAttributes.ROLE.value);

        // switch (userRole){
        //     case SU:
        //         if(userRemRole.equals(SU))
        //             return Response.status(Status.FORBIDDEN).entity("Don't have the permission to remove this user").build();
        //         datastore.delete(targetKey);
        //         deleteTargetToken(kRemToken);
        //         return Response.status(Status.OK).entity("User Deleted").build();
        //     case GS:
        //         if(userRemRole.equals(SU) || userRemRole.equals(GS))
        //             return Response.status(Status.FORBIDDEN).entity("Don't have the permission to remove this user").build();
        //         datastore.delete(targetKey);
        //         deleteTargetToken(kRemToken);
        //         return Response.status(Status.OK).entity("User Deleted").build();
        //     case GBO:
        //         if(userRemRole.equals(SU) || userRemRole.equals(GS) || userRemRole.equals(GBO))
        //             return Response.status(Status.FORBIDDEN).entity("Don't have the permission to remove this user").build();
        //         datastore.delete(targetKey);
        //         deleteTargetToken(kRemToken);
        //         return Response.status(Status.OK).entity("User Deleted").build();
        //     case USER:
        //         if(!data.username.equals(data.userRem))
        //             return Response.status(Status.FORBIDDEN).entity("Don't have the permission to remove this user").build();
        //         datastore.delete(targetKey);
        //         datastore.delete(tokenKey);
        //         return Response.status(Status.OK).entity("User Deleted").build();

        //   }

        return Response.status(Status.OK).entity("{}").build(); //podera rapaz este codigo nao faz nada

    }


    private void deleteTargetToken(Key targetTokenKey){
        Entity userRemToken = datastore.get(targetTokenKey);
        if(userRemToken != null)
            datastore.delete(targetTokenKey);
    }


}
