package pt.unl.fct.di.apdc.firstwebapp.resources;

import static pt.unl.fct.di.apdc.firstwebapp.util.enums.Globals.AUTH;

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

import javax.ws.rs.Consumes;
import javax.ws.rs.HeaderParam;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import com.google.cloud.datastore.Datastore;
import com.google.cloud.datastore.Entity;
import com.google.cloud.datastore.Key;
import com.google.cloud.datastore.Query;
import com.google.cloud.datastore.QueryResults;
import com.google.gson.Gson;

import pt.unl.fct.di.apdc.firstwebapp.util.DatastoreUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.TokenUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.RegisterData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.TokenData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.clientObjects.CompleteQueryResultData;
import pt.unl.fct.di.apdc.firstwebapp.util.enums.DatastoreEntities;
import pt.unl.fct.di.apdc.firstwebapp.util.enums.UserAttributes;
import pt.unl.fct.di.apdc.firstwebapp.util.enums.UserRole;


@Path("/list")
@Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
public class ListResource {
    
    private final Gson g = new Gson();
    private final Datastore datastore = DatastoreUtil.getService();
    private static final Logger LOG = Logger.getLogger(ListResource.class.getName());

    public ListResource() {}

    // @POST
    // @Path("/")
    // @Consumes(MediaType.APPLICATION_JSON)
    // public Response listUsers(TokenData data){
    //     Key tokenKey = datastore.newKeyFactory().setKind("Token").newKey(data.getUsername());
    //     Entity token = datastore.get(tokenKey);

    //     if(!TokenUtil.isTokenValid(LOG, data, token))
    //         return Response.status(Status.FORBIDDEN).build();

    //     Key userKey = datastore.newKeyFactory().setKind("User").newKey(data.getUsername());
    //     Entity user = datastore.get(userKey);

    //     String userRole = user.getString(UserAttributes.ROLE.value);
    //     List<String> list = new ArrayList<>();
    //     Query<Entity> query;
    //     QueryResults<Entity> tokens;

    //     // switch (userRole){
    //     //     case SU:
    //     //         query = Query.newEntityQueryBuilder().setKind("User").build();
    //     //         tokens = datastore.run(query);

    //     //         listAllUserInfo(list, tokens);
    //     //         return Response.ok(g.toJson(list)).build();
    //     //     case GS:
    //     //        query = Query.newEntityQueryBuilder().setKind("User")
    //     //                 .setFilter(PropertyFilter.eq(ROLE, USER)).build();
    //     //        tokens = datastore.run(query);

    //     //        Query<Entity> query1 = Query.newEntityQueryBuilder().setKind("User")
    //     //                 .setFilter(PropertyFilter.eq(ROLE, GBO)).build();
    //     //        QueryResults<Entity> tokens1 = datastore.run(query1);

    //     //         listAllUserInfo(list, tokens);

    //     //         listAllUserInfo(list, tokens1);

    //     //         return Response.ok(g.toJson(list)).build();

    //     //     case GBO:
    //     //         query = Query.newEntityQueryBuilder().setKind("User")
    //     //                 .setFilter(PropertyFilter.eq(ROLE, USER)).build();
    //     //         tokens = datastore.run(query);

    //     //         listAllUserInfo(list, tokens);

    //     //         return Response.ok(g.toJson(list)).build();

    //     //     case USER:
    //     //         query = Query.newEntityQueryBuilder().setKind("User")
    //     //                 .setFilter(PropertyFilter.eq(ROLE, USER)).build();
    //     //         tokens = datastore.run(query);
    //     //         listUserInfo(list, tokens);
    //     //         return Response.ok(g.toJson(list)).build();
    //     // }


    //     return Response.status(Status.OK).entity("{}").build();
    // }

    // private void listUserInfo(List<String> list, QueryResults<Entity> tokens) {
    //     tokens.forEachRemaining(userData ->{
    //         if(userData.getString("profile").equals(PROFILE) &&
    //                 userData.getString("state").equals(STATE)){
    //             list.add((

    //             userData.getKey().getName() + BLANK +
    //             userData.getString("email") + BLANK +
    //             userData.getString("name") + BLANK
    //             ));
    //         }});
    // }

    // private void listAllUserInfo(List<String> list, QueryResults<Entity> tokens1) {
    //     tokens1.forEachRemaining(userData ->{
    //         list.add((
    //                 userData.getKey().getName() + BLANK +
    //                 userData.getString("state") + BLANK +
    //                 userData.getString("role") + BLANK +
    //                 userData.getString("email") + BLANK +
    //                 userData.getString("name") + BLANK +
    //                 userData.getString("profile") + BLANK +
    //                 userData.getString("cellPhone") + BLANK +
    //                 userData.getString("fixPhone") + BLANK +
    //                 userData.getString("occupation") + BLANK +
    //                 userData.getString("workplace") + BLANK +
    //                 userData.getString("address 1") + BLANK +
    //                 userData.getString("address 2") + BLANK +
    //                 userData.getString("city") + BLANK +
    //                 userData.getString("outCode") + BLANK +
    //                 userData.getString("inCode") + BLANK +
    //                 userData.getString("NIF") + BLANK
    //         ));
    //     });
    // }




    // // !=====================================================================

    @POST
    @Path("/")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response listUsersV2(@HeaderParam(AUTH) String auth) {

        TokenData managerToken = TokenUtil.validateToken(LOG, auth);

        if (managerToken == null) {
            return Response.status(Status.FORBIDDEN).build();
        }

        Key managerKey = datastore.newKeyFactory().setKind(DatastoreEntities.USER.value).newKey(managerToken.getUsername());
        Entity manager = datastore.get(managerKey);
        UserRole managerRole = UserRole.toRole(manager.getString(UserAttributes.ROLE.value));
        Query<Entity> query;
        QueryResults<Entity> users;
        List<CompleteQueryResultData> resultList = new ArrayList<>();
        // switch(managerRole) {
        //     case SU:
        //         query = Query.newEntityQueryBuilder()
        //             .setKind("User")
        //             .build();
        //         users = datastore.run(query);
        //         users.forEachRemaining( user -> {
        //             resultList.add(getCompleteQueryResultData(user));
        //         });

        //         break;
        //     case GS:
        //         query = Query.newEntityQueryBuilder()
        //             .setKind("User")
        //             .setFilter(
        //                 PropertyFilter.eq(RegisterData.TYPE, UserType.GBO.type)
        //             )
        //             .build();
        //         users = datastore.run(query);
        //         users.forEachRemaining( user -> {
        //             resultList.add(getCompleteQueryResultData(user));
        //         });

        //         query = Query.newEntityQueryBuilder()
        //             .setKind("User")
        //             .setFilter(
        //                 PropertyFilter.eq(RegisterData.TYPE, UserType.USER.type)
        //             )
        //             .build();
        //         users = datastore.run(query);
        //         users.forEachRemaining( user -> {
        //             resultList.add(getCompleteQueryResultData(user));
        //         });

        //         break;
        //     case GA:
        //         LOG.warning("Behaviour for GA not defined.");
        //         return Response.status(Status.NOT_IMPLEMENTED).build();
        //     case GBO:
        //         query = Query.newEntityQueryBuilder()
        //             .setKind("User")
        //             .setFilter(
        //                 PropertyFilter.eq(RegisterData.TYPE, UserType.USER.type)
        //             )
        //             .build();
        //         users = datastore.run(query);
        //         users.forEachRemaining( user -> {
        //             resultList.add(getCompleteQueryResultData(user));
        //         });
        //     case USER:
        //         List<BaseQueryResultData> resultListUSER = new ArrayList<>();
        //         query = Query.newEntityQueryBuilder()
        //             .setKind("User")
        //             .setFilter(
        //                 CompositeFilter.and(
        //                     PropertyFilter.eq(RegisterData.TYPE, UserType.USER.type),
        //                     PropertyFilter.eq(RegisterData.STATE, true)
        //                 )
        //                 )
        //             .build();
        //         users = datastore.run(query);
        //         users.forEachRemaining( user -> {
        //             resultListUSER.add(new BaseQueryResultData(user.getString(RegisterData.USERNAME),
        //                                                         user.getString(RegisterData.NAME),
        //                                                         user.getString(RegisterData.EMAIL)));
        //         });
        //         LOG.info("Listing successful!");
        //         return Response.ok(g.toJson(resultListUSER)).build();

        //     default:
        //         LOG.severe("Could not resolve manager type.");
        //         return Response.status(Status.INTERNAL_SERVER_ERROR).build();
        // }

        LOG.info("Listing successful!");
        return Response.ok(g.toJson(resultList)).build();
    }

    private CompleteQueryResultData getCompleteQueryResultData(Entity user) {
        return new CompleteQueryResultData(user.getString(RegisterData.USERNAME),
                                        user.getString(RegisterData.NAME),
                                        user.getString(RegisterData.EMAIL),
                                        user.getString(RegisterData.PASSWORD),
                                        user.getTimestamp(RegisterData.CREATION_TIME),
                                        user.getString(RegisterData.TYPE),
                                        user.getBoolean(RegisterData.STATE),
                                        user.getBoolean(RegisterData.VISIBILITY),
                                        user.getString(RegisterData.MOBILE),
                                        user.getString(RegisterData.PHONE),
                                        user.getString(RegisterData.OCCUPATION),
                                        user.getString(RegisterData.WORK_ADDRESS),
                                        user.getString(RegisterData.ADDRESS),
                                        user.getString(RegisterData.SECOND_ADDRESS),
                                        user.getString(RegisterData.POST_CODE),
                                        user.getString(RegisterData.NIF));
    }
}

