package pt.unl.fct.di.apdc.firstwebapp.resources;

import com.google.cloud.datastore.*;
import com.google.gson.Gson;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.NotificationData;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.logging.Logger;

@Path("/notifications")
@Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
public class NotificationsResource {

    private static final Logger LOG = Logger.getLogger(LoginResource.class.getName());

    private final Datastore datastore = DatastoreOptions.getDefaultInstance().getService();

    private final Gson g = new Gson();

    public NotificationsResource() {
    }

    @POST
    @Path("/send")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
    public void createNotification(String message, String sender, String receiver, String type, long creationDate) {
        LOG.fine("Attempt to create notification: " + sender);

        String notificationId = receiver + getNextNotification(receiver);
        Transaction txn = datastore.newTransaction();

        try {
            Key notKey = datastore.newKeyFactory().addAncestor(PathElement.of("User", receiver))
                    .setKind("Notification").newKey(notificationId);
            Entity notification = Entity.newBuilder(notKey)
                    .set("Message", message)
                    .set("Sender", sender)
                    .set("Receiver", receiver)
                    .set("Type", type)
                    .set("Creation_Date", creationDate)
                    .build();

            txn.add(notification);
            txn.commit();
        } finally {
            if (txn.isActive()) {
                txn.rollback();
            }
        }
    }

    private int getNextNotification(String user) {
        AtomicInteger max = new AtomicInteger(-1);
        Key k = datastore.newKeyFactory().setKind("User").newKey(user);

        Query<Entity> query = Query.newEntityQueryBuilder()
                .setKind("Notification").setFilter(StructuredQuery.PropertyFilter.hasAncestor(k)).build();

        QueryResults<Entity> token = datastore.run(query);

        token.forEachRemaining(t -> {
            int val = Integer.parseInt(t.getKey().getName().replace(user, ""));
            if (max.get() < val)
                max.set(val);
        });

        return max.incrementAndGet();
    }

    @POST
    @Path("/sendAll")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public void createNotificationToAll(String message, String type) {
        Query<Entity> query = Query.newEntityQueryBuilder().setKind("User").build();
        QueryResults<Entity> listUsers = datastore.run(query);

        listUsers.forEachRemaining(user -> {
            createNotification(message, "System", user.getKey().getName(), type, System.currentTimeMillis());
        });
    }

}

