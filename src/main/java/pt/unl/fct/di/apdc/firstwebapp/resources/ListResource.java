package pt.unl.fct.di.apdc.firstwebapp.resources;

import static com.google.cloud.datastore.aggregation.Aggregation.count;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.DatastoreEntities.ANOMALY;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.DatastoreEntities.BOOKING;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.DatastoreEntities.POST;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.DatastoreEntities.TOKEN;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.DatastoreEntities.USER;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.Globals.AUTH;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.Globals.COUNT;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.Globals.DEFAULT_FORMAT;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.TokenAttributes.EXPIRATION_TIME;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.UserAttributes.*;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Logger;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.HeaderParam;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import com.google.cloud.datastore.*;
import com.google.cloud.datastore.StructuredQuery.PropertyFilter;
import com.google.common.collect.Iterables;
import com.google.gson.Gson;

import pt.unl.fct.di.apdc.firstwebapp.resources.permissions.PermissionsHolder;
import pt.unl.fct.di.apdc.firstwebapp.util.DatastoreUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.TokenUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.register.RegisterInfoData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.TokenData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.clientObjects.BaseQueryResultData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.clientObjects.CompleteQueryResultData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.clientObjects.StatsData;


@Path("/list")
public class ListResource {

    private static final Logger LOG = Logger.getLogger(ListResource.class.getName());

    private final Gson g = new Gson();
    private final Datastore datastore = DatastoreUtil.getService();

    private PermissionsHolder ph = PermissionsHolder.getInstance();

    public ListResource() {}

    @POST
    @Path("/users")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON + DEFAULT_FORMAT)
    public Response listUsers(@HeaderParam(AUTH) String auth) {

        TokenData token = TokenUtil.validateToken(LOG, auth);

        if (token == null)
            return Response.status(Status.UNAUTHORIZED).build();

        /*if (!ph.hasAccess(LIST_USERS.value, token.getRole()))
            return Response.status(Status.FORBIDDEN).build();*/
        Key userKey = datastore.newKeyFactory().setKind(USER.value).newKey(token.getUsername());
        Entity user = datastore.get(userKey);

        if (user == null)
            return Response.status(Status.FORBIDDEN).build();

        if(!user.getString(ROLE.value).equals("admin"))
            return Response.status(Status.BAD_REQUEST).build();

        EntityQuery query = Query.newEntityQueryBuilder()
                .setKind(USER.value)
                .setFilter(
                        PropertyFilter.eq(STATE.value, true)
                )
                .build();

        List<RegisterInfoData> resultList = fillUserArray(query);

        LOG.info("Listing successful!");
        return Response.ok(g.toJson(resultList)).build();
    }

    @POST
    @Path("/unactivated")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON + DEFAULT_FORMAT)
    public Response listUnactivatedUsers(@HeaderParam(AUTH) String auth) {

        TokenData token = TokenUtil.validateToken(LOG, auth);

        if (token == null)
            return Response.status(Status.UNAUTHORIZED).build();

        /*if (!ph.hasAccess(LIST_UNNACTIVATED_USERS.value, token.getRole()))
            return Response.status(Status.FORBIDDEN).build();*/

        Key userKey = datastore.newKeyFactory().setKind(USER.value).newKey(token.getUsername());
        Entity user = datastore.get(userKey);

        if (user == null)
            return Response.status(Status.FORBIDDEN).build();

        if(!user.getString(ROLE.value).equals("admin"))
            return Response.status(Status.BAD_REQUEST).build();

        EntityQuery query = EntityQuery.newEntityQueryBuilder()
                .setKind(USER.value)
                .setFilter(
                        PropertyFilter.eq(STATE.value, false)
                )
                .build();
        List<RegisterInfoData> resultList = fillUserArray(query);

        return Response.ok(g.toJson(resultList)).build();
    }

    private List fillUserArray(EntityQuery query) {
        QueryResults<Entity> unactivatedUsers = datastore.run(query);

        List<RegisterInfoData> resultList = new ArrayList<>();

        unactivatedUsers.forEachRemaining(t -> {
            resultList.add(new RegisterInfoData(t.getKey().getName(),
                    t.getString(NAME.value),
                    t.getString(EMAIL.value),
                    t.getString(ROLE.value)));
        });
        return resultList;
    }


    @POST
    @Path("/stats")
    public Response statistics(@HeaderParam(AUTH) String auth) {

        TokenData token = TokenUtil.validateToken(LOG, auth);

        if (token == null)
            return Response.status(Status.UNAUTHORIZED).build();

        /*if (!ph.hasAccess(STATS.value, token.getRole()))
            return Response.status(Status.FORBIDDEN).build();*/

        Key userKey = datastore.newKeyFactory().setKind(USER.value).newKey(token.getUsername());
        Entity user = datastore.get(userKey);

        if (user == null)
            return Response.status(Status.FORBIDDEN).build();

        if(!user.getString(ROLE.value).equals("admin"))
            return Response.status(Status.BAD_REQUEST).build();

        var stats = new StatsData(
                getNumOnlineUsers(),
                getNumPosts(),
                getNumAnomalies(),
                getNumUnactivatedUsers(),
                0l, //TODO put appropriate value
                0l //TODO put appropriate value
        );


        return Response.ok(g.toJson(stats)).build();
    }



    private BaseQueryResultData getBaseQueryResultData(Entity user) {
        return new BaseQueryResultData(user.getString(USERNAME.value));
    }

    private CompleteQueryResultData getCompleteQueryResultData(Entity user) {
        return new CompleteQueryResultData(user.getString(USERNAME.value),
                user.getString(NAME.value),
                user.getString(EMAIL.value),
                user.getLong(CREATION_TIME.value),
                user.getString(ROLE.value),
                user.getBoolean(STATE.value));
    }

    private long getNumOnlineUsers() {

        long now = new Date().getTime();

        EntityQuery query = Query.newEntityQueryBuilder()
                .setKind(TOKEN.value)
                .setFilter(
                        PropertyFilter.lt(EXPIRATION_TIME.value, now)
                )
                .build();

        return doCount(query);

    }

    private long getNumPosts() {

        EntityQuery query = Query.newEntityQueryBuilder()
                .setKind(POST.value)
                .build();

        return doCount(query);
    }

    private long getNumAnomalies() {

        EntityQuery query = Query.newEntityQueryBuilder()
                .setKind(ANOMALY.value)
                .setFilter(
                        PropertyFilter.eq(STATE.value, false)
                )
                .build();

        return doCount(query);
    }

    private long getNumUnactivatedUsers() {

        EntityQuery query = Query.newEntityQueryBuilder()
                .setKind(USER.value)
                .setFilter(
                        PropertyFilter.eq(STATE.value, false)
                )
                .build();

        return doCount(query);
    }

    //TODO fit properties
    private long getNumUnhandledReservations() {

        EntityQuery query = Query.newEntityQueryBuilder()
                .setKind(BOOKING.value)
                // .setFilter(
                //smt
                // )
                .build();

        return doCount(query);
    }

    private long doCount(EntityQuery query) {

        AggregationQuery unactivatedUsers = Query.newAggregationQueryBuilder()
                .over(query)
                .addAggregation(
                        count().as(COUNT)
                )
                .build();

        AggregationResult result = Iterables.getOnlyElement(datastore.runAggregation(unactivatedUsers));

        return result.get(COUNT);
    }

}