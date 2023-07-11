package pt.unl.fct.di.apdc.firstwebapp.resources;

import com.google.cloud.datastore.*;
import com.google.gson.Gson;
import pt.unl.fct.di.apdc.firstwebapp.util.DatastoreUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.TokenUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.clientObjects.TokenData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.notification.NotificationData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.notification.NotificationDeleteData;
import pt.unl.fct.di.apdc.firstwebapp.util.enums.DatastoreEntities;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.logging.Logger;

import static pt.unl.fct.di.apdc.firstwebapp.util.enums.Globals.AUTH;

@Path("/notifications")
public class NotificationsResource {

    private static final Logger LOG = Logger.getLogger(NotificationsResource.class.getName());
    private static final String NOTIFICATION_DELETED = "Notification deleted.";
    private static final String NOTIFICATION_DOES_NOT_EXIST = "Notification does not exist.";
    private static final String ALL_NOTIFICATIONS_DELETED = "All notifications deleted";

    private final Datastore datastore = DatastoreUtil.getService();

    private final Gson g = new Gson();

    public NotificationsResource() {
    }

    protected void createNotification(String message, String sender, String receiver, String type, long creationDate) {
        LOG.fine("Attempt to create notification: " + sender);

        String notificationId = receiver + getNextNotification(receiver);
        Transaction txn = datastore.newTransaction();

        try {
            Key notKey = datastore.newKeyFactory().addAncestor(PathElement.of(DatastoreEntities.USER.value, receiver))
                    .setKind(DatastoreEntities.NOTIFICATION.value).newKey(notificationId);
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
        Key k = datastore.newKeyFactory().setKind(DatastoreEntities.USER.value).newKey(user);

        Query<Entity> query = Query.newEntityQueryBuilder()
                .setKind(DatastoreEntities.NOTIFICATION.value).setFilter(StructuredQuery.PropertyFilter.hasAncestor(k)).build();

        QueryResults<Entity> token = datastore.run(query);

        token.forEachRemaining(t -> {
            int val = Integer.parseInt(t.getKey().getName().replace(user, ""));
            if (max.get() < val)
                max.set(val);
        });

        return max.incrementAndGet();
    }


    public void createNotificationToAll(String message, String type) {
        Query<Entity> query = Query.newEntityQueryBuilder().setKind(DatastoreEntities.USER.value).build();
        QueryResults<Entity> listUsers = datastore.run(query);

        listUsers.forEachRemaining(user -> {
            createNotification(message, "System", user.getKey().getName(), type, System.currentTimeMillis());
        });
    }

    @POST
    @Path("/delete")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response deleteNotification(@HeaderParam(AUTH) String auth, NotificationDeleteData data) {

        TokenData givenTokenData = TokenUtil.validateToken(LOG, auth);

        if(givenTokenData == null)
            return Response.status(Response.Status.FORBIDDEN).build();

        Transaction txn = datastore.newTransaction();

        try {
            Key notificationKey = datastore.newKeyFactory().addAncestor(PathElement.of(DatastoreEntities.USER.value, givenTokenData.getUsername()))
                    .setKind(DatastoreEntities.NOTIFICATION.value).newKey(data.getNotificationId());
            Entity notification = txn.get(notificationKey);

            if (notification != null) {
                txn.delete(notificationKey);
                txn.commit();
                return Response.ok(g.toJson(NOTIFICATION_DELETED)).build();
            } else {
                return Response.status(Response.Status.FORBIDDEN).entity(NOTIFICATION_DOES_NOT_EXIST).build();
            }
        } finally {
            if (txn.isActive()) {
                txn.rollback();
            }
        }
    }

    @POST
    @Path("/deleteall")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response deleteAllNotifications(@HeaderParam(AUTH) String auth) {

        TokenData givenTokenData = TokenUtil.validateToken(LOG, auth);

        if(givenTokenData == null)
            return Response.status(Response.Status.FORBIDDEN).build();

        Transaction txn = datastore.newTransaction();

        try {
            Key userKey = datastore.newKeyFactory().setKind(DatastoreEntities.USER.value).newKey(givenTokenData.getUsername());
            Query<Entity> query = Query.newEntityQueryBuilder()
                    .setKind(DatastoreEntities.NOTIFICATION.value).setFilter(StructuredQuery.PropertyFilter.hasAncestor(userKey)).build();

            QueryResults<Entity> notifications = datastore.run(query);

            notifications.forEachRemaining(notification -> {
                txn.delete(notification.getKey());
            });

            txn.commit();
            return Response.ok(g.toJson(ALL_NOTIFICATIONS_DELETED)).build();
        } finally {
            if (txn.isActive()) {
                txn.rollback();
            }
        }
    }

    @POST
    @Path("/list")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response listAllNotifications(@HeaderParam(AUTH) String auth) {

        TokenData givenTokenData = TokenUtil.validateToken(LOG, auth);

        if(givenTokenData == null)
            return Response.status(Response.Status.FORBIDDEN).build();

        Key userKey = datastore.newKeyFactory().setKind(DatastoreEntities.USER.value).newKey(givenTokenData.getUsername());
        Query<Entity> query = Query.newEntityQueryBuilder()
                .setKind(DatastoreEntities.NOTIFICATION.value).setFilter(StructuredQuery.PropertyFilter.hasAncestor(userKey)).build();
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

