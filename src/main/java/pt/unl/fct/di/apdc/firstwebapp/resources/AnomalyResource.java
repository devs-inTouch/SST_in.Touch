package pt.unl.fct.di.apdc.firstwebapp.resources;

import com.google.cloud.datastore.*;
import com.google.gson.Gson;
import pt.unl.fct.di.apdc.firstwebapp.util.DatastoreUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.TokenUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.TokenData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.anomaly.AnomalyData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.anomaly.AnomalyDeleteData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.anomaly.AnomalyInfoData;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.logging.Logger;

import static pt.unl.fct.di.apdc.firstwebapp.util.enums.Globals.AUTH;

@Path("/anomaly")
public class AnomalyResource {

    private static final Logger LOG = Logger.getLogger(LoginResource.class.getName());
    private static final String USER_NOT_IN_DATABASE = "User not in database";
    private static final String ANOMALY_CREATED_SUCCESSFULLY = "Anomaly created successfully";
    private static final String ANOMALY_NOT_IN_DATABASE = "Anomaly not in database";
    private static final String ANOMALY_DELETED_SUCCESSFULLY = "Anomaly deleted successfully";
    private static final String USER_NOT_ALLOWED_TO_DELETE_ANOMALY = "User not allowed to delete anomaly";
    private static final String ANOMALY_CREATED = "New anomaly!";
    private static final String ANOMALY_TYPE = "Anomaly";

    private final Datastore datastore = DatastoreUtil.getService();

    private final Gson g = new Gson();

    private final NotificationsResource notification;


    public AnomalyResource() {
        notification = new NotificationsResource();
    }

    @POST
    @Path("/create")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response createAnomaly(@HeaderParam(AUTH) String auth, AnomalyData data) {

        TokenData givenTokenData = TokenUtil.validateToken(LOG, auth);

        if(givenTokenData == null)
            return Response.status(Response.Status.FORBIDDEN).build();

        Key userKey = datastore.newKeyFactory().setKind("User").newKey(givenTokenData.getSub());

        Transaction txn = datastore.newTransaction();
        try {
            Entity user = txn.get(userKey);
            if (user == null)
                return Response.status(Response.Status.BAD_REQUEST).entity(USER_NOT_IN_DATABASE).build();

            int anomalyId = getNextAnomaly();
            Key k = datastore.newKeyFactory().setKind("Anomaly").newKey(anomalyId);
            Entity anomaly = Entity.newBuilder(k)
                    .set("username", givenTokenData.getSub())
                    .set("title", data.getTitle())
                    .set("description", data.getDescription())
                    .set("creation_date", System.currentTimeMillis())
                    .build();

            txn.add(anomaly);
            txn.commit();

            notification.createNotificationToAll(ANOMALY_CREATED, ANOMALY_TYPE);
            return Response.ok(g.toJson(ANOMALY_CREATED_SUCCESSFULLY)).build();
        } finally {
            if (txn.isActive()) {
                txn.rollback();
            }

        }
    }

    @POST
    @Path("/delete")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
    public Response deleteAnomaly(@HeaderParam(AUTH) String auth, AnomalyDeleteData data) {

        TokenData givenTokenData = TokenUtil.validateToken(LOG, auth);

        if(givenTokenData == null)
            return Response.status(Response.Status.FORBIDDEN).build();

        Key userKey = datastore.newKeyFactory().setKind("User").newKey(givenTokenData.getSub());
        Key creatorKey = datastore.newKeyFactory().setKind("User").newKey(data.getCreator());

        Transaction txn = datastore.newTransaction();
        try {
            Entity user = txn.get(userKey);
            Entity creator = txn.get(creatorKey);
            if (user == null || creator == null)
                return Response.status(Response.Status.BAD_REQUEST).entity(USER_NOT_IN_DATABASE).build();

            if(givenTokenData.getSub().equals(data.getCreator())) {
                Key k = datastore.newKeyFactory().setKind("Anomaly").newKey(Integer.parseInt(data.getAnomalyId()));
                Entity anomaly = txn.get(k);
                if (anomaly == null)
                    return Response.status(Response.Status.BAD_REQUEST).entity(ANOMALY_NOT_IN_DATABASE).build();

                txn.delete(k);
                txn.commit();
                return Response.ok(g.toJson(ANOMALY_DELETED_SUCCESSFULLY)).build();
            } else {
                return Response.status(Response.Status.BAD_REQUEST).entity(USER_NOT_ALLOWED_TO_DELETE_ANOMALY).build();
            }

        } finally {
            if(txn.isActive()) {
                txn.rollback();
            }
        }

    }

    @POST
    @Path("/list")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
    public Response listAnomalies() {
        LOG.fine("Attempt to list anomalies");

        Query<Entity> query = Query.newEntityQueryBuilder().setKind("Anomaly").build();
        QueryResults<Entity> results = datastore.run(query);

        List<AnomalyInfoData> list = new ArrayList<>();

        results.forEachRemaining(t -> {
            list.add(new AnomalyInfoData(t.getString("username"), t.getString("title"), t.getString("description")));
        });

        return Response.ok(g.toJson(list)).build();
    }

    private int getNextAnomaly() {
        AtomicInteger max = new AtomicInteger(0);

        Query<Entity> query = Query.newEntityQueryBuilder()
                .setKind("Anomaly").build();

        QueryResults<Entity> anomalyQuery = datastore.run(query);

        anomalyQuery.forEachRemaining(t -> {
            int val = Integer.parseInt(t.getKey().getId().toString());
            if (max.get() < val)
                max.set(val);
        });

        return max.incrementAndGet();
    }
}
