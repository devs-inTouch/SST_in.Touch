package pt.unl.fct.di.apdc.firstwebapp.resources;

import com.google.cloud.datastore.*;
import com.google.gson.Gson;
import pt.unl.fct.di.apdc.firstwebapp.util.DatastoreUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.TokenUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.TokenData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.nucleos.CreateNucleoData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.nucleos.DeleteNucleoData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.nucleos.NucleoInfoData;
import pt.unl.fct.di.apdc.firstwebapp.util.enums.DatastoreEntities;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.logging.Logger;

import static pt.unl.fct.di.apdc.firstwebapp.util.enums.Globals.AUTH;

@Path("/nucleo")
public class NucleoResource {

    private static final Logger LOG = Logger.getLogger(NucleoResource.class.getName());
    private static final String USER_NOT_IN_DATABASE = "User not in database";
    private static final String USER_NOT_ALLOWED_TO_CREATE_NUCLEO = "User not allowed to create nucleo";
    private static final String NUCLEO_CREATED = "Nucleo created";
    private static final String USER_NOT_ALLOWED_TO_DELETE_NUCLEO = "User not allowed to delete nucleo";
    private static final String NUCLEO_NOT_IN_DATABASE = "Nucleo not in database";
    private static final String NUCLEO_DELETED = "Nucleo deleted";
    private final Datastore datastore = DatastoreUtil.getService();

    private final Gson g = new Gson();

    public NucleoResource() {
    }

    @POST
    @Path("/create")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
    public Response createNucleo(@HeaderParam(AUTH) String auth, CreateNucleoData data) {
        TokenData givenTokenData = TokenUtil.validateToken(LOG, auth);

        if(givenTokenData == null)
            return Response.status(Response.Status.FORBIDDEN).build();

        Key userKey = datastore.newKeyFactory().setKind(DatastoreEntities.USER.value).newKey(givenTokenData.getUsername());

        Transaction txn = datastore.newTransaction();

        try {
            Entity user = txn.get(userKey);
            if(user == null) {
                return Response.status(Response.Status.FORBIDDEN).entity(USER_NOT_IN_DATABASE).build();
            }

            if(!user.getString("user_role").equals("admin")) {
                return Response.status(Response.Status.FORBIDDEN).entity(USER_NOT_ALLOWED_TO_CREATE_NUCLEO).build();
            }

            int nucleoId = getNextNucleo();
            Key nucleoKey = datastore.newKeyFactory().setKind(DatastoreEntities.NUCLEO.value).newKey(nucleoId);
            Entity nucleo = Entity.newBuilder(nucleoKey)
                    .set("title", data.getTitle())
                    .set("description", data.getDescription())
                    .set("faceUrl", data.getFaceUrl())
                    .set("instaUrl", data.getInstaUrl())
                    .set("twitterUrl", data.getTwitterUrl())
                    .build();

            txn.add(nucleo);
            txn.commit();

            return Response.ok(g.toJson(NUCLEO_CREATED)).build();

        } finally {
            if(txn.isActive())
                txn.rollback();
        }

    }

    @POST
    @Path("/delete")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
    public Response deleteNucleo(@HeaderParam(AUTH) String auth, DeleteNucleoData data) {
        TokenData givenTokenData = TokenUtil.validateToken(LOG, auth);

        if(givenTokenData == null)
            return Response.status(Response.Status.FORBIDDEN).build();

        Key userKey = datastore.newKeyFactory().setKind(DatastoreEntities.USER.value).newKey(givenTokenData.getUsername());
        Transaction txn = datastore.newTransaction();

        try {
            Entity user = txn.get(userKey);
            if(user == null) {
                return Response.status(Response.Status.BAD_REQUEST).entity(USER_NOT_IN_DATABASE).build();
            }

            if(!user.getString("user_role").equals("admin")) {
                return Response.status(Response.Status.BAD_REQUEST).entity(USER_NOT_ALLOWED_TO_DELETE_NUCLEO).build();
            }

            Key nucleoKey = datastore.newKeyFactory().setKind(DatastoreEntities.NUCLEO.value).newKey(Integer.parseInt(data.getNucleoId()));
            Entity nucleo = txn.get(nucleoKey);

            if(nucleo == null) {
                return Response.status(Response.Status.BAD_REQUEST).entity(NUCLEO_NOT_IN_DATABASE).build();
            }

            txn.delete(nucleoKey);
            txn.commit();

            return Response.ok(g.toJson(NUCLEO_DELETED)).build();

        } finally {
            if(txn.isActive())
                txn.rollback();
        }

    }

    @POST
    @Path("/list")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
    public Response listNucleos() {
        Query<Entity> query = Query.newEntityQueryBuilder()
                .setKind(DatastoreEntities.NUCLEO.value).build();

        QueryResults<Entity> nucleoQuery = datastore.run(query);

        List<NucleoInfoData> list = new ArrayList<>();

        nucleoQuery.forEachRemaining(t -> {
            list.add(new NucleoInfoData(t.getKey().getName(), t.getString("title"), t.getString("description"), t.getString("faceUrl"), t.getString("instaUrl"), t.getString("twitterUrl")));
        });

        return Response.ok(g.toJson(list)).build();

    }

    private int getNextNucleo() {
        AtomicInteger max = new AtomicInteger(0);

        Query<Entity> query = Query.newEntityQueryBuilder()
                .setKind(DatastoreEntities.NUCLEO.value).build();

        QueryResults<Entity> nucleoQuery = datastore.run(query);

        nucleoQuery.forEachRemaining(t -> {
            int val = Integer.parseInt(t.getKey().getId().toString());
            if (max.get() < val)
                max.set(val);
        });

        return max.incrementAndGet();
    }
}
