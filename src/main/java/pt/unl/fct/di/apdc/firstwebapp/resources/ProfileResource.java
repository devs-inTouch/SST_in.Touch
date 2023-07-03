package pt.unl.fct.di.apdc.firstwebapp.resources;

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

import javax.ws.rs.Consumes;
import javax.ws.rs.HeaderParam;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import com.google.cloud.datastore.*;
import com.google.cloud.storage.Acl;
import com.google.gson.Gson;

import pt.unl.fct.di.apdc.firstwebapp.util.TokenUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.TokenData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.UserData;
import pt.unl.fct.di.apdc.firstwebapp.util.enums.UserAttributes;

import static pt.unl.fct.di.apdc.firstwebapp.util.enums.Globals.AUTH;

@Path("/profile")
public class ProfileResource {

    private final Datastore datastore = DatastoreOptions.getDefaultInstance().getService();

    private static final Logger LOG = Logger.getLogger(ProfileResource.class.getName());

    private static final String USER_NOT_FOUND = "User not in database!";

    private final Gson g = new Gson();

    public ProfileResource(){}

    // TODO resolver escalabilidade

    @POST
    @Path("/")
    @Consumes(MediaType.APPLICATION_JSON)
        public Response showProfile(@HeaderParam(AUTH) String auth) {
            LOG.fine("Attempt to show profile: " );
            TokenData givenToken = TokenUtil.validateToken(LOG, auth);
            //send data to the client
            Key userKey = datastore.newKeyFactory().setKind("User").newKey(givenToken.getUsername());
            Transaction txn = datastore.newTransaction();
            try {
                Entity user = txn.get(userKey);
                if (user == null)
                    return Response.status(Status.BAD_REQUEST).entity(USER_NOT_FOUND).build();

                List<String> info = new ArrayList<>();
                info.add(user.getKey().toString());
                info.add(user.getString(UserAttributes.DEPARTMENT.value));
                info.add(user.getString(UserAttributes.DESCRIPTION.value));
                info.add(user.getString(UserAttributes.EMAIL.value));
                info.add(user.getString(UserAttributes.NAME.value));
                info.add(user.getString(UserAttributes.STUDENT_NUMBER.value));
                /*info.add(user.getString(UserAttributes.ROLE.value));
                info.add(user.getString(UserAttributes.DEPARTMENT.value));
                info.add(user.getString(UserAttributes.WORK_ADDRESS.value));
                */

                txn.commit();
                return Response.ok(g.toJson(info)).build();
            }catch (Exception e) {
                LOG.severe(e.getMessage());
                return Response.status(Status.INTERNAL_SERVER_ERROR).build();
            }
            finally {
                if (txn.isActive())
                    txn.rollback();
            }


        
    }

    @POST
    @Path("/follow")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response followUser(@HeaderParam(AUTH) String auth, UserData user) {
        TokenData givenToken = TokenUtil.validateToken(LOG, auth);

        if(givenToken == null) {
            return Response.status(Response.Status.FORBIDDEN).build();
        }

        String username = givenToken.getUsername();
        Key userToFollowKey =  datastore.newKeyFactory().setKind("User").newKey(user.getTargetUsername());
        Key userThatFollowsKey =  datastore.newKeyFactory().setKind("User").newKey(username);

        Transaction txn = datastore.newTransaction();

        try {
            Entity userToFollow = txn.get(userToFollowKey);
            Entity userThatFollows = txn.get(userThatFollowsKey);

            if (userToFollow == null || userThatFollows == null)
                return Response.status(Response.Status.BAD_REQUEST).entity("USER_NOT_IN_DATABASE").build();

            //Adicionar a lista de seguidores
            List<Value<String>> firstArray = userToFollow.getList(UserAttributes.FOLLOWERS.value);
            List<Value<String>> updatedFirstArray = new ArrayList<>(firstArray);
            updatedFirstArray.add(StringValue.newBuilder(username).build());

            userToFollow = Entity.newBuilder(userToFollow).set(UserAttributes.FOLLOWERS.value, updatedFirstArray).build();

            txn.update(userToFollow);

            //Adicionar a lista de quem vai seguir

            List<Value<String>> secondArray = userThatFollows.getList(UserAttributes.FOLLOWING.value);
            List<Value<String>> updatedSecondProperty = new ArrayList<>(secondArray);
            updatedSecondProperty.add(StringValue.newBuilder(user.getTargetUsername()).build());

            userThatFollows = Entity.newBuilder(userThatFollows).set(UserAttributes.FOLLOWERS.value, updatedSecondProperty).build();

            txn.update(userThatFollows);

            return Response.ok(g.toJson("following")).build();

        } finally {
            if (txn.isActive())
                txn.rollback();
        }
    }

    /*
    @POST
    @Path("/unfollow")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response unfollowUser(@HeaderParam(AUTH) String auth, UserData user) {


    }

    @POST
    @Path("/getFollowingList")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response getFollowingList(@HeaderParam(AUTH) String auth, UserData user) {


    }

    @POST
    @Path("/getFollowersList")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response getFollowersList(@HeaderParam(AUTH) String auth, UserData user) {


    }*/



}
