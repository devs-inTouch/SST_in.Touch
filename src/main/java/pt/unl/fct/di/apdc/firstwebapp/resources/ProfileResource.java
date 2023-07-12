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
import com.google.cloud.datastore.Query;
import com.google.cloud.datastore.QueryResults;
import com.google.cloud.datastore.StructuredQuery.CompositeFilter;
import com.google.cloud.datastore.StructuredQuery.PropertyFilter;


import com.google.cloud.datastore.*;
import com.google.gson.Gson;

import org.apache.commons.codec.digest.DigestUtils;
import pt.unl.fct.di.apdc.firstwebapp.util.TokenUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.clientObjects.TokenData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.clientObjects.UserData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.EditData;
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
    public Response showProfile(@HeaderParam(AUTH) String auth, UserData username) {
        LOG.fine("Attempt to show profile: " );
        TokenData givenToken = TokenUtil.validateToken(LOG, auth);

        if(givenToken == null) {
            return Response.status(Response.Status.FORBIDDEN).build();
        }
        //send data to the client
        Key userKey = datastore.newKeyFactory().setKind("User").newKey(username.getTargetUsername());
        Transaction txn = datastore.newTransaction();
        try {
            Entity user = txn.get(userKey);
            if (user == null)
                return Response.status(Status.BAD_REQUEST).entity(USER_NOT_FOUND).build();

            List<String> info = new ArrayList<>();
            info.add(user.getKey().getName());
            info.add(user.getString(UserAttributes.DEPARTMENT.value));
            info.add(user.getString(UserAttributes.DESCRIPTION.value));
            info.add(user.getString(UserAttributes.EMAIL.value));
            info.add(user.getString(UserAttributes.NAME.value));
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
    @Path("/edit")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response editProfile(@HeaderParam(AUTH) String auth, EditData data) {
        LOG.fine("Attempt to show profile: " );
        TokenData givenToken = TokenUtil.validateToken(LOG, auth);
        //send data to the client
        Key userKey = datastore.newKeyFactory().setKind("User").newKey(givenToken.getUsername());
        Transaction txn = datastore.newTransaction();
        try {
            Entity user = txn.get(userKey);
            if (user == null)
                return Response.status(Status.BAD_REQUEST).entity(USER_NOT_FOUND).build();



            Entity edited = Entity.newBuilder(user).set(UserAttributes.PASSWORD.value, DigestUtils.sha512Hex(data.getPassword()))
                    .set(UserAttributes.DESCRIPTION.value, data.getDescription()).build();

            txn.update(edited);

            txn.commit();
            return Response.ok().build();
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
    @Path("/getUsername")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response getUsername(@HeaderParam(AUTH) String auth) {
        LOG.fine("Attempt to show profile: " );
        TokenData givenToken = TokenUtil.validateToken(LOG, auth);

        if(givenToken == null) {
            return Response.status(Response.Status.FORBIDDEN).build();
        }
        //send data to the client
        return Response.ok(g.toJson(givenToken.getUsername())).build();
    }

    @POST
    @Path("/getProfilePic")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response getPhoto(@HeaderParam(AUTH) String auth, UserData data) {
        LOG.fine("Attempt to show profile: " );
        TokenData givenToken = TokenUtil.validateToken(LOG, auth);

        if(givenToken == null) {
            return Response.status(Response.Status.FORBIDDEN).build();
        }
        Transaction txn = datastore.newTransaction();

        Key userKey =  datastore.newKeyFactory().setKind("User").newKey(data.getTargetUsername());
        Entity user = txn.get(userKey);

        String url = user.getString("profile_imageURL");
        //send data to the client
        return Response.ok(g.toJson(givenToken.getUsername())).build();
    }

    private Entity modifyAddFollow(String list,Entity user, String username) {
        List<Value<String>> firstArray = user.getList(list);
        List<Value<String>> updatedFirstArray = new ArrayList<>(firstArray);
        updatedFirstArray.add(StringValue.of(username));

        return Entity.newBuilder(user).set(list, updatedFirstArray).build();

    }

    private Entity modifyRemoveFollow(String list,Entity user, String username) {
        List<Value<String>> firstArray = user.getList(list);
        List<Value<String>> updatedFirstArray = new ArrayList<>(firstArray);
        updatedFirstArray.remove(StringValue.of(username));

        return Entity.newBuilder(user).set(list, updatedFirstArray).build();
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
        Key userThatFollowsKey =  datastore.newKeyFactory().setKind("User").newKey(username);

        Transaction txn = datastore.newTransaction();

        try {

            Entity userThatFollows = txn.get(userThatFollowsKey);
            if (userThatFollows == null)
                return Response.status(Response.Status.BAD_REQUEST).entity("USER_NOT_IN_DATABASE").build();

            //Adicionar a lista de quem vai seguir

            txn.update(modifyAddFollow(UserAttributes.FOLLOWING.value ,userThatFollows, user.getTargetUsername()));

            txn.commit();
            return Response.ok(g.toJson("following")).build();

        } finally {
            if (txn.isActive())
                txn.rollback();
        }

    }

    @POST
    @Path("/unfollow")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response unfollowUser(@HeaderParam(AUTH) String auth, UserData user) {
        TokenData givenToken = TokenUtil.validateToken(LOG, auth);

        if(givenToken == null) {
            return Response.status(Response.Status.FORBIDDEN).build();
        }

        String username = givenToken.getUsername();
        Key userThatFollowsKey =  datastore.newKeyFactory().setKind("User").newKey(username);

        Transaction txn = datastore.newTransaction();

        try {

            Entity userThatFollows = txn.get(userThatFollowsKey);

            if (userThatFollows == null)
                return Response.status(Response.Status.BAD_REQUEST).entity("USER_NOT_IN_DATABASE").build();

            //Adicionar a lista de quem vai seguir
            txn.update(modifyRemoveFollow(UserAttributes.FOLLOWING.value,userThatFollows, user.getTargetUsername()));
            txn.commit();
            return Response.ok(g.toJson("following")).build();

        } finally {
            if (txn.isActive())
                txn.rollback();
        }

    }

    @POST
    @Path("/search")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response getUserSearch(@HeaderParam(AUTH) String auth, UserData user) {
        TokenData givenToken = TokenUtil.validateToken(LOG, auth);

        if(givenToken == null) {
            return Response.status(Response.Status.FORBIDDEN).build();
        }

        String username = user.getTargetUsername();
        KeyFactory factory = datastore.newKeyFactory().setKind("User");


        Query<Entity> query = Query.newEntityQueryBuilder().setKind("User")
                .setFilter(
                        CompositeFilter.and(
                                PropertyFilter.ge("user_name".toLowerCase(), username.toLowerCase()),
                                PropertyFilter.neq("user_name".toLowerCase(), givenToken.getUsername().toLowerCase()))
                ).build();

        QueryResults<Entity> postQuery = datastore.run(query);


        List<String> list = new ArrayList<>();

        postQuery.forEachRemaining(t -> {
            list.add(t.getKey().getName());
        });


        return Response.ok(g.toJson(list)).build();

    }
    private List<String> getValues(Entity user, String list) {
        List<String> toRet = new ArrayList<>();
        List<Value<String>> arrayProperty = user.getList(list);
        for(Value<String> value: arrayProperty) {
            toRet.add(value.get());
        }
        return toRet;
    }



    @POST
    @Path("/getFollowingList")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response getFollowingList(@HeaderParam(AUTH) String auth) {

        TokenData givenToken = TokenUtil.validateToken(LOG, auth);

        if(givenToken == null) {
            return Response.status(Response.Status.FORBIDDEN).build();
        }

        String username = givenToken.getUsername();
        Key userKey =  datastore.newKeyFactory().setKind("User").newKey(username);

        Transaction txn = datastore.newTransaction();

        try {
            Entity user = txn.get(userKey);


            if (user == null)
                return Response.status(Response.Status.BAD_REQUEST).entity("USER_NOT_IN_DATABASE").build();

            return Response.ok(g.toJson(getValues(user,UserAttributes.FOLLOWING.value))).build();

        } finally {
            if (txn.isActive())
                txn.rollback();
        }

    }


    @POST
    @Path("/getFollowersList")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response getFollowersList(@HeaderParam(AUTH) String auth) {
        TokenData givenToken = TokenUtil.validateToken(LOG, auth);

        if(givenToken == null) {
            return Response.status(Response.Status.FORBIDDEN).build();
        }

        String username = givenToken.getUsername();
        Key userKey =  datastore.newKeyFactory().setKind("User").newKey(username);

        Transaction txn = datastore.newTransaction();

        try {
            Entity user = txn.get(userKey);

            if (user == null)
                return Response.status(Response.Status.BAD_REQUEST).entity("USER_NOT_IN_DATABASE").build();

            return Response.ok(g.toJson(getValues(user,UserAttributes.FOLLOWERS.value))).build();
        } finally {
            if (txn.isActive())
                txn.rollback();
        }

    }



}
