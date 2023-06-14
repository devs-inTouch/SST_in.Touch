package pt.unl.fct.di.apdc.firstwebapp.resources;

import com.google.cloud.datastore.*;
import com.google.gson.Gson;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.anomaly.AnomalyData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.anomaly.AnomalyDeleteData;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.logging.Logger;

@Path("/anomaly")
public class AnomalyResource {

    private static final Logger LOG = Logger.getLogger(LoginResource.class.getName());

    private final Datastore datastore = DatastoreOptions.getDefaultInstance().getService();

    private final Gson g = new Gson();

    private final NotificationsResource notification;

    private static final String ANOMALY_CREATED = "Nova anomalia!";
    private static final String ANOMALY_TYPE = "Anomaly";

    public AnomalyResource() {
        notification = new NotificationsResource();
    }

    @POST
    @Path("/create")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response createAnomaly(AnomalyData data) {
        LOG.fine("Attempt to create anomaly: " + data.username);

        //TODO token verification

        Key userKey = datastore.newKeyFactory().setKind("User").newKey(data.username);

        Transaction txn = datastore.newTransaction();
        try {
            Entity user = txn.get(userKey);
            if (user == null)
                return Response.status(Response.Status.BAD_REQUEST).entity("User not in database").build();

            int anomalyId = getNextAnomaly();
            Key k = datastore.newKeyFactory().setKind("Anomaly").newKey(anomalyId);
            Entity anomaly = Entity.newBuilder(k)
                    .set("username", data.username)
                    .set("title", data.title)
                    .set("description", data.description)
                    .set("creation_date", System.currentTimeMillis())
                    .build();

            txn.add(anomaly);
            txn.commit();

            notification.createNotificationToAll(ANOMALY_CREATED, ANOMALY_TYPE);
            return Response.ok(g.toJson("Anomaly created successfully")).build();
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
    public Response deleteAnomaly(AnomalyDeleteData data) {
        LOG.fine("Attempt to delete anomaly: " + data.username);

        //TODO token verification

        Key userKey = datastore.newKeyFactory().setKind("User").newKey(data.username);
        Key creatorKey = datastore.newKeyFactory().setKind("User").newKey(data.creator);

        Transaction txn = datastore.newTransaction();
        try {
            Entity user = txn.get(userKey);
            Entity creator = txn.get(creatorKey);
            if (user == null || creator == null)
                return Response.status(Response.Status.BAD_REQUEST).entity("User not in database").build();

            if(data.username.equals(data.creator)) {
                Key k = datastore.newKeyFactory().setKind("Anomaly").newKey(Integer.parseInt(data.anomalyId));
                Entity anomaly = txn.get(k);
                if (anomaly == null)
                    return Response.status(Response.Status.BAD_REQUEST).entity("Anomaly not in database").build();

                txn.delete(k);
                txn.commit();
                return Response.ok(g.toJson("Anomaly deleted successfully")).build();
            } else {
                return Response.status(Response.Status.BAD_REQUEST).entity("User not allowed to delete anomaly").build();
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

        List<AnomalyData> list = new ArrayList<>();

        results.forEachRemaining(t -> {
            list.add(new AnomalyData(t.getString("username"), t.getString("title"), t.getString("description")));
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
