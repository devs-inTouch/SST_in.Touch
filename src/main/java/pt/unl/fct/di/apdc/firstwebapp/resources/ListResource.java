package pt.unl.fct.di.apdc.firstwebapp.resources;

import com.google.cloud.datastore.*;
import com.google.gson.Gson;

import pt.unl.fct.di.apdc.firstwebapp.util.entities.old.LogoutData;

import com.google.cloud.datastore.StructuredQuery.PropertyFilter;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;
import java.util.ArrayList;
import java.util.List;


@Path("/list")
@Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
public class ListResource {
    private static final String SU = "SU";
    private static final String GS = "GS";
    private static final String GBO = "GBO";
    private static final String USER = "USER";
    private static final String BLANK = " ";
    private static final String ROLE = "role";
    private static final String STATE = "Active";
    private static final String PROFILE = "Public";
    private final Gson g = new Gson();
    private final Datastore datastore = DatastoreOptions.getDefaultInstance().getService();

    public ListResource() {}

    @POST
    @Path("/")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response listUsers(LogoutData data){
        Key kUserToken = datastore.newKeyFactory().setKind("Token").newKey(data.username);
        Entity userToken = datastore.get(kUserToken);

        if(userToken.getLong("expiration_time") < System.currentTimeMillis())
            return Response.status(Response.Status.EXPECTATION_FAILED).entity("Token Expired").build();

        Key kUser = datastore.newKeyFactory().setKind("User").newKey(data.username);
        Entity user = datastore.get(kUser);
        if (user == null)
            return Response.status(Status.FORBIDDEN).entity("User not in database!").build();
        String userRole = user.getString("role");
        List<String> list = new ArrayList<>();
        Query<Entity> query;
        QueryResults<Entity> tokens;

        switch (userRole){
            case SU:
                query = Query.newEntityQueryBuilder().setKind("User").build();
                tokens = datastore.run(query);

                listAllUserInfo(list, tokens);
                return Response.ok(g.toJson(list)).build();
            case GS:
               query = Query.newEntityQueryBuilder().setKind("User")
                        .setFilter(PropertyFilter.eq(ROLE, USER)).build();
               tokens = datastore.run(query);

               Query<Entity> query1 = Query.newEntityQueryBuilder().setKind("User")
                        .setFilter(PropertyFilter.eq(ROLE, GBO)).build();
               QueryResults<Entity> tokens1 = datastore.run(query1);

                listAllUserInfo(list, tokens);

                listAllUserInfo(list, tokens1);

                return Response.ok(g.toJson(list)).build();

            case GBO:
                query = Query.newEntityQueryBuilder().setKind("User")
                        .setFilter(PropertyFilter.eq(ROLE, USER)).build();
                tokens = datastore.run(query);

                listAllUserInfo(list, tokens);

                return Response.ok(g.toJson(list)).build();

            case USER:
                query = Query.newEntityQueryBuilder().setKind("User")
                        .setFilter(PropertyFilter.eq(ROLE, USER)).build();
                tokens = datastore.run(query);
                listUserInfo(list, tokens);
                return Response.ok(g.toJson(list)).build();
        }


        return Response.status(Status.OK).entity("NAO CHEGA AQUII").build();
    }

    private void listUserInfo(List<String> list, QueryResults<Entity> tokens) {
        tokens.forEachRemaining(userData ->{
            if(userData.getString("profile").equals(PROFILE) &&
                    userData.getString("state").equals(STATE)){
                list.add((

                userData.getKey().getName() + BLANK +
                userData.getString("email") + BLANK +
                userData.getString("name") + BLANK
                ));
            }});
    }

    private void listAllUserInfo(List<String> list, QueryResults<Entity> tokens1) {
        tokens1.forEachRemaining(userData ->{
            list.add((
                    userData.getKey().getName() + BLANK +
                    userData.getString("state") + BLANK +
                    userData.getString("role") + BLANK +
                    userData.getString("email") + BLANK +
                    userData.getString("name") + BLANK +
                    userData.getString("profile") + BLANK +
                    userData.getString("cellPhone") + BLANK +
                    userData.getString("fixPhone") + BLANK +
                    userData.getString("occupation") + BLANK +
                    userData.getString("workplace") + BLANK +
                    userData.getString("address 1") + BLANK +
                    userData.getString("address 2") + BLANK +
                    userData.getString("city") + BLANK +
                    userData.getString("outCode") + BLANK +
                    userData.getString("inCode") + BLANK +
                    userData.getString("NIF") + BLANK
            ));
        });
    }


}
