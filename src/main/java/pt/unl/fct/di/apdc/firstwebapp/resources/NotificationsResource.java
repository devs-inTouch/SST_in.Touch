package pt.unl.fct.di.apdc.firstwebapp.resources;

import com.google.cloud.datastore.*;
import com.google.gson.Gson;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.NotificationData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.NotificationDeleteData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.UserData;

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

@Path("/notifications")
@Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
public class NotificationsResource {

    private static final Logger LOG = Logger.getLogger(LoginResource.class.getName());

    private final Datastore datastore = DatastoreOptions.getDefaultInstance().getService();

    private final Gson g = new Gson();

    public NotificationsResource() {
    }
    
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

    @POST
    @Path("/delete")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response deleteNotification(NotificationDeleteData data) {
        LOG.fine("Attempt to delete notification: " + data.username);

        Transaction txn = datastore.newTransaction();

        try {
            Key notificationKey = datastore.newKeyFactory().addAncestor(PathElement.of("User", data.username))
                    .setKind("Notification").newKey(data.notificationId);
            Entity notification = txn.get(notificationKey);

            if (notification != null) {
                txn.delete(notificationKey);
                txn.commit();
                return Response.ok().build();
            } else {
                return Response.status(Response.Status.FORBIDDEN).entity("Notification does not exist.").build();
            }
        } finally {
            if (txn.isActive()) {
                txn.rollback();
            }
        }
    }

    @POST
    @Path("deleteAll")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response deleteAllNotifications(UserData data) {
        LOG.fine("Attempt to delete all notifications: " + data.getTargetUsername());

        Transaction txn = datastore.newTransaction();

        try {
            Key userKey = datastore.newKeyFactory().setKind("User").newKey(data.getTargetUsername());
            Query<Entity> query = Query.newEntityQueryBuilder()
                    .setKind("Notification").setFilter(StructuredQuery.PropertyFilter.hasAncestor(userKey)).build();

            QueryResults<Entity> notifications = datastore.run(query);

            notifications.forEachRemaining(notification -> {
                txn.delete(notification.getKey());
            });

            txn.commit();
            return Response.ok().build();
        } finally {
            if (txn.isActive()) {
                txn.rollback();
            }
        }
    }

    @POST
    @Path("listAll")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response listAllNotifications(UserData data) {
        LOG.fine("Attempt to list all notifications: " + data.getTargetUsername());

        //TODO tratar token

        Key userKey = datastore.newKeyFactory().setKind("User").newKey(data.getTargetUsername());
        Query<Entity> query = Query.newEntityQueryBuilder()
                .setKind("Notification").setFilter(StructuredQuery.PropertyFilter.hasAncestor(userKey)).build();
        QueryResults<Entity> notifications = datastore.run(query);
        List<NotificationData> list = new ArrayList<>();

        notifications.forEachRemaining(x ->{
            NotificationData not = new NotificationData(x.getKey().getName(), x.getString("Message"),
                    x.getString("Sender"), x.getString("Receiver"), x.getString("Type"));
            not.setCreationDate(x.getLong("Creation_Date"));
            list.add(not);
        });

        return Response.ok(g.toJson(list)).build();
    }
}

