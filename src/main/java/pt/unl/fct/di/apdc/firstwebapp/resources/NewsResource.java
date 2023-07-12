package pt.unl.fct.di.apdc.firstwebapp.resources;

import com.google.cloud.datastore.*;
import com.google.gson.Gson;
import pt.unl.fct.di.apdc.firstwebapp.util.DatastoreUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.TokenUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.clientObjects.TokenData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.news.NewsData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.news.NewsDeleteData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.news.NewsInfoData;
import pt.unl.fct.di.apdc.firstwebapp.util.enums.DatastoreEntities;
import pt.unl.fct.di.apdc.firstwebapp.util.enums.UserRole;


import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.logging.Logger;



import static pt.unl.fct.di.apdc.firstwebapp.util.enums.Globals.AUTH;

@Path("/news")
public class NewsResource {

    private static final String USER_NOT_IN_DATABASE = "User not in database";
    private static final Logger LOG = Logger.getLogger(NewsResource.class.getName());
    private static final String USER_NOT_ALLOWED_TO_CREATE_NEWS = "User not allowed to create news";
    private static final String NEWS_CREATED = "News created";
    private static final String USER_NOT_ALLOWED_TO_DELETE_NEWS = "User not allowed to delete news";

    private static final String USER_NOT_ALLOWED_TO_CREATE_NUCLEO = "User not allowed to create nucleo";
    private static final String NEWS_NOT_IN_DATABASE = "News not in database";
    private static final String NEWS_DELETED = "News deleted";

    private final Datastore datastore = DatastoreUtil.getService();

    private final Gson g = new Gson();

    public NewsResource() {

    }

    @POST
    @Path("/create")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
    public Response createNews(@HeaderParam(AUTH) String auth, NewsData data) {

        TokenData givenTokenData = TokenUtil.validateToken(LOG, auth);

        if(givenTokenData == null)
            return Response.status(Response.Status.FORBIDDEN).build();

        Key userKey = datastore.newKeyFactory().setKind(DatastoreEntities.USER.value).newKey(givenTokenData.getUsername());
        Transaction txn = datastore.newTransaction();

        try {
            Entity user = txn.get(userKey);

            if(user == null)
                return Response.status(Response.Status.BAD_REQUEST).entity(USER_NOT_IN_DATABASE).build();

            if(!UserRole.isStaff(user.getString("user_role"))){
                return Response.status(Response.Status.FORBIDDEN).entity(USER_NOT_ALLOWED_TO_CREATE_NUCLEO).build();
            }

            int newsId = getNextNews();
            Key newsKey = datastore.newKeyFactory().setKind(DatastoreEntities.NEWS.value).newKey(newsId);
            Entity news = Entity.newBuilder(newsKey)
                    .set("title", data.getTitle())
                    .set("description", data.getDescription())
                    .set("mediaUrl", data.getMediaUrl())
                    .set("creation_date", System.currentTimeMillis())
                    .build();

            txn.add(news);
            txn.commit();

            return Response.ok().entity(g.toJson(NEWS_CREATED)).build();

    } finally {
            if(txn.isActive())
                txn.rollback();
        }
    }

    @POST
    @Path("/delete")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
    public Response deleteNews(@HeaderParam(AUTH) String auth, NewsDeleteData data) {
        TokenData givenTokenData = TokenUtil.validateToken(LOG, auth);

        if(givenTokenData == null)
            return Response.status(Response.Status.FORBIDDEN).build();

        Key userKey = datastore.newKeyFactory().setKind(DatastoreEntities.USER.value).newKey(givenTokenData.getUsername());
        Transaction txn = datastore.newTransaction();

        try {
            Entity user = txn.get(userKey);

            if(user == null)
                return Response.status(Response.Status.BAD_REQUEST).entity(USER_NOT_IN_DATABASE).build();

            if(!UserRole.isStaff(user.getString("user_role"))){
                return Response.status(Response.Status.FORBIDDEN).entity(USER_NOT_ALLOWED_TO_CREATE_NUCLEO).build();
            }

            Key newsKey = datastore.newKeyFactory().setKind(DatastoreEntities.NEWS.value).newKey(data.getNewsId());
            Entity news = txn.get(newsKey);

            if(news == null)
                return Response.status(Response.Status.BAD_REQUEST).entity(NEWS_NOT_IN_DATABASE).build();

            txn.delete(newsKey);
            txn.commit();

            return Response.ok().entity(g.toJson(NEWS_DELETED)).build();

        } finally {
            if(txn.isActive())
                txn.rollback();
        }

    }

    @POST
    @Path("/list")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
    public Response listNews() {

            Query<Entity> query = Query.newEntityQueryBuilder()
                    .setKind(DatastoreEntities.NEWS.value).setOrderBy(StructuredQuery.OrderBy.desc("creation_date")).build();

            QueryResults<Entity> newsQuery = datastore.run(query);

            List<NewsInfoData> newsList = new ArrayList<>();

            newsQuery.forEachRemaining(t -> {
                newsList.add(new NewsInfoData(t.getKey().getName(), t.getString("title"), t.getString("description"), t.getString("mediaUrl"), t.getLong("creation_date")));
            });

            return Response.ok().entity(g.toJson(newsList)).build();
    }


    private int getNextNews() {
        AtomicInteger max = new AtomicInteger(0);

        Query<Entity> query = Query.newEntityQueryBuilder()
                .setKind(DatastoreEntities.NEWS.value).build();

        QueryResults<Entity> newsQuery = datastore.run(query);

        newsQuery.forEachRemaining(t -> {
            int val = Integer.parseInt(t.getKey().getId().toString());
            if (max.get() < val)
                max.set(val);
        });

        return max.incrementAndGet();
    }
}
