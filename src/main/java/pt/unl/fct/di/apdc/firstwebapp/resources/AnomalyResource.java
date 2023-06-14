package pt.unl.fct.di.apdc.firstwebapp.resources;

import com.google.cloud.datastore.*;
import com.google.gson.Gson;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.AnomalyData;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
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

            int anomalyId = getNextFeed();
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

    private int getNextFeed() {
        AtomicInteger max = new AtomicInteger(0);

        Query<Entity> query = Query.newEntityQueryBuilder()
                .setKind("Anomaly").build();

        QueryResults<Entity> news = datastore.run(query);

        news.forEachRemaining(t -> {
            int val = Integer.parseInt(t.getKey().getId().toString());
            if (max.get() < val)
                max.set(val);
        });

        return max.incrementAndGet();
    }
}
