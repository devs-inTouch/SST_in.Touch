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
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.Operation.LIST_UNNACTIVATED_USERS;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.Operation.LIST_USERS;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.TokenAttributes.EXPIRATION_TIME;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.UserAttributes.CREATION_TIME;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.UserAttributes.EMAIL;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.UserAttributes.NAME;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.UserAttributes.ROLE;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.UserAttributes.STATE;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.UserAttributes.USERNAME;

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

import com.google.cloud.datastore.AggregationQuery;
import com.google.cloud.datastore.AggregationResult;
import com.google.cloud.datastore.Datastore;
import com.google.cloud.datastore.Entity;
import com.google.cloud.datastore.EntityQuery;
import com.google.cloud.datastore.Query;
import com.google.cloud.datastore.QueryResults;
import com.google.cloud.datastore.StructuredQuery.PropertyFilter;
import com.google.common.collect.Iterables;
import com.google.gson.Gson;

import pt.unl.fct.di.apdc.firstwebapp.resources.permissions.PermissionsHolder;
import pt.unl.fct.di.apdc.firstwebapp.util.DatastoreUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.TokenUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.TokenData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.clientObjects.BaseQueryResultData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.clientObjects.CompleteQueryResultData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.clientObjects.StatsData;


@Path("/list")
@Produces(MediaType.APPLICATION_JSON + DEFAULT_FORMAT)
public class ListResource {

    private static final Logger LOG = Logger.getLogger(ListResource.class.getName());
    
    private final Gson g = new Gson();
    private final Datastore datastore = DatastoreUtil.getService();

    private PermissionsHolder ph = PermissionsHolder.getInstance();

    public ListResource() {}

    @POST
    @Path("/users")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response listUsers(@HeaderParam(AUTH) String auth) {

        TokenData token = TokenUtil.validateToken(LOG, auth);

        if (token == null)
            return Response.status(Status.UNAUTHORIZED).build();

        if (!ph.hasAccess(LIST_USERS.value, token.getRole()))
            return Response.status(Status.FORBIDDEN).build();

        EntityQuery query = Query.newEntityQueryBuilder()
                            .setKind(USER.value)
                            .setFilter(
                                PropertyFilter.eq(STATE.value, true)
                            )
                            .build();

        QueryResults<Entity> users = datastore.run(query);
        var resultList = new ArrayList<>();

        // switch (ph.getClearance(LIST_USERS.value, token.getRole())) {} //TODO add this later

        users.forEachRemaining(user -> {
            if (ph.hasPermission(LIST_USERS.value, token.getRole(), user.getString(ROLE.value)))
                resultList.add(getCompleteQueryResultData(user));
        });

        LOG.info("Listing successful!");
        return Response.ok(g.toJson(resultList)).build();
    }
    
	@GET
	@Path("/unactivated")
	public Response listUnactivatedUsers(@HeaderParam(AUTH) String auth) {

        TokenData token = TokenUtil.validateToken(LOG, auth);

        if (token == null)
            return Response.status(Status.UNAUTHORIZED).build();

        if (!ph.hasAccess(LIST_USERS.value, token.getRole()))
            return Response.status(Status.FORBIDDEN).build();

		List<BaseQueryResultData> result = new ArrayList<>();

		EntityQuery query = EntityQuery.newEntityQueryBuilder()
							.setKind(USER.value)
							.setFilter(
                                PropertyFilter.eq(STATE.value, false)
							)
							.build();

		QueryResults<Entity> unactivatedUsers = datastore.run(query);
		unactivatedUsers.forEachRemaining(user -> {
            if (ph.hasPermission(LIST_UNNACTIVATED_USERS.value, token.getRole(), user.getString(ROLE.value)))
			    result.add(getBaseQueryResultData(user));
		});

		return Response.ok(g.toJson(result)).build();
	}


    @GET
    @Path("/stats")
    public Response statistics(@HeaderParam(AUTH) String auth) {

        TokenData token = TokenUtil.validateToken(LOG, auth);

        if (token == null)
            return Response.status(Status.UNAUTHORIZED).build();

        if (!ph.hasAccess(LIST_USERS.value, token.getRole()))
            return Response.status(Status.FORBIDDEN).build();

        var stats = new StatsData(
                        getNumOnlineUsers(),
                        getNumPosts(),
                        getNumAnomalies(),
                        getNumUnactivatedUsers(),
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

