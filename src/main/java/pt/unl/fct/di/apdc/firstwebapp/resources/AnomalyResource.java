package pt.unl.fct.di.apdc.firstwebapp.resources;

import com.google.cloud.datastore.*;
import com.google.gson.Gson;
import pt.unl.fct.di.apdc.firstwebapp.util.DatastoreUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.TokenUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.TokenData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.anomaly.AnomalyData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.anomaly.AnomalyInfoData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.anomaly.ApproveAnomalyData;
import pt.unl.fct.di.apdc.firstwebapp.util.enums.DatastoreEntities;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.logging.Logger;

import static pt.unl.fct.di.apdc.firstwebapp.util.enums.DatastoreEntities.USER;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.Globals.AUTH;
import static pt.unl.fct.di.apdc.firstwebapp.util.enums.UserAttributes.ROLE;

@Path("/anomaly")
public class AnomalyResource {

    private static final Logger LOG = Logger.getLogger(AnomalyResource.class.getName());
    private static final String USER_NOT_IN_DATABASE = "User not in database";
    private static final String ANOMALY_CREATED_SUCCESSFULLY = "Anomaly created successfully";
    private static final String ANOMALY_NOT_IN_DATABASE = "Anomaly not in database";
    private static final String ANOMALY_DELETED_SUCCESSFULLY = "Anomaly deleted successfully";
    private static final String USER_NOT_ALLOWED_TO_DELETE_ANOMALY = "User not allowed to delete anomaly";
    private static final String ANOMALY_CREATED = "Nova anomalia, aguardar confirmacao";
    private static final String ANOMALY_TYPE = "Anomaly";
    private static final String CAN_NOT_DELETE_ANOMALY = "Can not delete anomaly";
    private static final String NOVA_ANOMALIA = "Nova anomalia";
    private static final String ANOMALIA_REJEITADA = "Anomalia rejeitada";

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

        Key userKey = datastore.newKeyFactory().setKind(DatastoreEntities.USER.value).newKey(givenTokenData.getUsername());

        Transaction txn = datastore.newTransaction();
        try {
            Entity user = txn.get(userKey);
            if (user == null)
                return Response.status(Response.Status.BAD_REQUEST).entity(USER_NOT_IN_DATABASE).build();

            String anomalyId = getNextAnomaly();
            Key k = datastore.newKeyFactory().setKind(DatastoreEntities.ANOMALY.value).newKey(anomalyId);
            Entity anomaly = Entity.newBuilder(k)
                    .set("username", givenTokenData.getUsername())
                    .set("title", data.getTitle())
                    .set("description", data.getDescription())
                    .set("creation_date", System.currentTimeMillis())
                    .set("isApproved", false)
                    .build();

            txn.add(anomaly);
            txn.commit();

            notification.createNotification(ANOMALY_CREATED,"System", givenTokenData.getUsername(), ANOMALY_TYPE, System.currentTimeMillis());
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
    public Response deleteAnomaly(@HeaderParam(AUTH) String auth, ApproveAnomalyData data) {

        TokenData givenTokenData = TokenUtil.validateToken(LOG, auth);

        if(givenTokenData == null)
            return Response.status(Response.Status.FORBIDDEN).build();

        Key userKey = datastore.newKeyFactory().setKind(DatastoreEntities.USER.value).newKey(givenTokenData.getUsername());

        Transaction txn = datastore.newTransaction();

        try {
            Entity user = txn.get(userKey);
            if (user == null)
                return Response.status(Response.Status.BAD_REQUEST).entity(USER_NOT_IN_DATABASE).build();

            if (!user.getString("user_role").equals("admin"))
                return Response.status(Response.Status.BAD_REQUEST).entity(USER_NOT_ALLOWED_TO_DELETE_ANOMALY).build();

            Key k = datastore.newKeyFactory().setKind(DatastoreEntities.ANOMALY.value).newKey(Integer.parseInt(data.getAnomalyId()));
            Entity anomaly = txn.get(k);
            if (anomaly == null)
                return Response.status(Response.Status.BAD_REQUEST).entity(ANOMALY_NOT_IN_DATABASE).build();

            if(anomaly.getBoolean("isApproved") == false)
                return Response.status(Response.Status.BAD_REQUEST).entity(CAN_NOT_DELETE_ANOMALY).build();

            txn.delete(k);
            txn.commit();

            return Response.ok(g.toJson(ANOMALY_DELETED_SUCCESSFULLY)).build();
        } finally {
            if (txn.isActive()) {
                txn.rollback();
            }
        }

    }

    @POST
    @Path("/listnotapproved")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
    public Response listNotApprovedAnomalies(@HeaderParam(AUTH) String auth) {
        LOG.fine("Attempt to list anomalies");

        TokenData token = TokenUtil.validateToken(LOG, auth);

        if (token == null)
            return Response.status(Response.Status.UNAUTHORIZED).build();

        /*if (!ph.hasAccess(LIST_UNNACTIVATED_USERS.value, token.getRole()))
            return Response.status(Status.FORBIDDEN).build();*/

        Key userKey = datastore.newKeyFactory().setKind(USER.value).newKey(token.getUsername());
        Entity user = datastore.get(userKey);

        if (user == null)
            return Response.status(Response.Status.FORBIDDEN).build();

        if(!user.getString(ROLE.value).equals("admin"))
            return Response.status(Response.Status.BAD_REQUEST).build();

        Query<Entity> query = Query.newEntityQueryBuilder().setKind(DatastoreEntities.ANOMALY.value)
                .setFilter(StructuredQuery.PropertyFilter.eq("isApproved", false)).build();
        return getResponse(query);
    }

    private Response getResponse(Query<Entity> query) {
        QueryResults<Entity> results = datastore.run(query);

        List<AnomalyInfoData> list = new ArrayList<>();

        results.forEachRemaining(t -> {
            list.add(new AnomalyInfoData(t.getKey().getName(), t.getString("username"), t.getString("title"), t.getString("description")));
        });

        return Response.ok(g.toJson(list)).build();
    }

    @POST
    @Path("/listapproved")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
    public Response listApprovedAnomalies() {
        LOG.fine("Attempt to list anomalies");

        Query<Entity> query = Query.newEntityQueryBuilder().setKind(DatastoreEntities.ANOMALY.value)
                .setFilter(StructuredQuery.PropertyFilter.eq("isApproved", true)).build();
        return getResponse(query);

    }

    @POST
    @Path("/approve")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
    public Response approveAnomaly(@HeaderParam(AUTH) String auth, ApproveAnomalyData data) {
        TokenData givenTokenData = TokenUtil.validateToken(LOG, auth);

        if(givenTokenData == null)
            return Response.status(Response.Status.FORBIDDEN).build();

        Key userKey = datastore.newKeyFactory().setKind(DatastoreEntities.USER.value).newKey(givenTokenData.getUsername());
        Key anomalyKey = datastore.newKeyFactory().setKind(DatastoreEntities.ANOMALY.value).newKey(Integer.parseInt(data.getAnomalyId()));

        Transaction txn = datastore.newTransaction();
        try {
            Entity user = txn.get(userKey);
            Entity anomaly = txn.get(anomalyKey);
            if (user == null)
                return Response.status(Response.Status.BAD_REQUEST).entity(USER_NOT_IN_DATABASE).build();

            if (anomaly == null)
                return Response.status(Response.Status.BAD_REQUEST).entity(ANOMALY_NOT_IN_DATABASE).build();



            Entity newAnomaly = Entity.newBuilder(anomalyKey)
                    .set("username", anomaly.getString("username"))
                    .set("title", anomaly.getString("title"))
                    .set("description", anomaly.getString("description"))
                    .set("creation_date", anomaly.getLong("creation_date"))
                    .set("isApproved", true)
                    .build();

            txn.update(newAnomaly);
            txn.commit();

            notification.createNotificationToAll(NOVA_ANOMALIA, ANOMALY_TYPE);
            return Response.ok(g.toJson(NOVA_ANOMALIA)).build();

        } finally {
            if(txn.isActive()) {
                txn.rollback();
            }
        }
    }

    @POST
    @Path("/notApprove")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
    public Response notApproveAnomaly(@HeaderParam(AUTH) String auth, ApproveAnomalyData data) {
        TokenData givenTokenData = TokenUtil.validateToken(LOG, auth);

        if(givenTokenData == null)
            return Response.status(Response.Status.FORBIDDEN).build();

        Key userKey = datastore.newKeyFactory().setKind(DatastoreEntities.USER.value).newKey(givenTokenData.getUsername());
        Key anomalyKey = datastore.newKeyFactory().setKind(DatastoreEntities.ANOMALY.value).newKey(Integer.parseInt(data.getAnomalyId()));

        Transaction txn = datastore.newTransaction();

        try {
            Entity user = txn.get(userKey);
            Entity anomaly = txn.get(anomalyKey);
            if (user == null)
                return Response.status(Response.Status.BAD_REQUEST).entity(USER_NOT_IN_DATABASE).build();

            if (anomaly == null)
                return Response.status(Response.Status.BAD_REQUEST).entity(ANOMALY_NOT_IN_DATABASE).build();

            txn.delete(anomalyKey);
            txn.commit();

            notification.createNotification(ANOMALIA_REJEITADA, "System", anomaly.getString("username"), ANOMALY_TYPE, System.currentTimeMillis());
            return Response.ok(g.toJson(ANOMALY_DELETED_SUCCESSFULLY)).build();

        } finally {
            if(txn.isActive()) {
                txn.rollback();
            }
        }

    }

    private String getNextAnomaly() {
        UUID uuid = UUID.randomUUID();
        return uuid.toString();
    }
}