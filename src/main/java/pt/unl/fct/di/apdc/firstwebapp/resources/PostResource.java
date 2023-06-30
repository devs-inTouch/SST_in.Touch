package pt.unl.fct.di.apdc.firstwebapp.resources;

//import com.google.appengine.api.memcache.stdimpl.GCacheFactory;
import com.google.appengine.api.memcache.Expiration;
import com.google.appengine.api.memcache.MemcacheService;
import com.google.appengine.api.memcache.MemcacheServiceException;
import com.google.appengine.api.memcache.MemcacheServiceFactory;
import com.google.cloud.datastore.*;
import com.google.gson.Gson;
import pt.unl.fct.di.apdc.firstwebapp.util.DatastoreUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.TokenUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.TokenData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.post.PostData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.post.PostDeleteData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.post.PostIdData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.post.PostInformationData;


/*import javax.cache.Cache;
import javax.cache.CacheException;
import javax.cache.CacheFactory;
import javax.cache.CacheManager;*/

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.logging.Logger;

import static pt.unl.fct.di.apdc.firstwebapp.util.enums.Globals.AUTH;

@Path("/post")
public class PostResource {

    private static final int DURATION_OF_CACHE = 2;
    private static final Logger LOG = Logger.getLogger(PostResource.class.getName());
    private static final String USER_NOT_IN_DATABASE = "User not in database";
    private static final String POST_CREATED_SUCCESSFULLY = "Post created successfully";
    private static final String POST_NOT_IN_DATABASE = "Post not in database";
    private static final String POST_DELETED_SUCCESSFULLY = "Post deleted successfully";
    private static final String USER_NOT_ALLOWED_TO_DELETE_POST = "User not allowed to delete post";

    private static final String ADDED_UP = "Added up to post";
    private static final String LIST_POSTS = "listPosts";

    private final Datastore datastore = DatastoreUtil.getService();

    private final MemcacheService memcache;

    private final Gson g = new Gson();


    public PostResource() {
        try {
            memcache = MemcacheServiceFactory.getMemcacheService();
        } catch(MemcacheServiceException e) {
            throw new RuntimeException(e);
        }
    }

    @POST
    @Path("/create")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
    public Response createPost(@HeaderParam(AUTH) String auth, PostData data) {

        TokenData givenTokenData = TokenUtil.validateToken(LOG, auth);

        if(givenTokenData == null)
            return Response.status(Response.Status.FORBIDDEN).build();

        Key userKey = datastore.newKeyFactory().setKind("User").newKey(givenTokenData.getUsername());
        Transaction txn = datastore.newTransaction();

        try {
            Entity user = txn.get(userKey);
            if (user == null)
                return Response.status(Response.Status.BAD_REQUEST).entity(USER_NOT_IN_DATABASE).build();

            String postIdentification = givenTokenData.getUsername() + getNextPost(givenTokenData.getUsername());
            Key k = datastore.newKeyFactory().setKind("Post").newKey(postIdentification);
            Entity post = Entity.newBuilder(k)
                    .set("username", givenTokenData.getUsername())
                    .set("description", data.getDescription())
                    .set("mediaUrl", data.getMediaUrl())
                    .set("ups", new ArrayList<>())
                    .set("downs", new ArrayList<>())
                    .set("creation_date", System.currentTimeMillis())
                    .build();
            txn.add(post);
            txn.commit();
            memcache.delete((LIST_POSTS).hashCode());

            return Response.ok(g.toJson(POST_CREATED_SUCCESSFULLY)).build();
        } finally {
            if (txn.isActive())
                txn.rollback();
        }
    }

    @POST
    @Path("/list")
    @Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
    public Response listPosts() {
        LOG.fine("Attempt to list posts");

        int hashCode = LIST_POSTS.hashCode();
        if(memcache.contains(hashCode)) {
            LOG.fine("Cache hit");
            return Response.ok(memcache.get(hashCode)).build();
        }

        Query<Entity> query = Query.newEntityQueryBuilder().setKind("Post")
                .setOrderBy(StructuredQuery.OrderBy.desc("creation_date")).build();
        QueryResults<Entity> postQuery = datastore.run(query);

        List<PostInformationData> list = new ArrayList<>();

        postQuery.forEachRemaining(t -> {
            list.add(new PostInformationData(t.getKey().getName(), t.getString("username"), t.getString("description"),
                    t.getString("mediaUrl"), (int) t.getLong("ups"), (int) t.getLong("downs"), t.getLong("creation_date")));
        });

        String finalList = g.toJson(list);
        LOG.fine(String.valueOf(list.size()));
        memcache.put(hashCode, finalList, Expiration.byDeltaSeconds(DURATION_OF_CACHE * 60 * 60));


        return Response.ok(g.toJson(list)).build();
    }
    @POST
    @Path("/addup")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response addUp(@HeaderParam(AUTH) String auth, PostIdData postIde) {
        TokenData receivedToken = TokenUtil.validateToken(LOG, auth);

        if(receivedToken == null) {
            return Response.status(Response.Status.FORBIDDEN).build();
        }
        String username = receivedToken.getUsername();
        Key userKey = datastore.newKeyFactory().setKind("User").newKey(username);
        Key postKey = datastore.newKeyFactory().setKind("Post").newKey(postIde.getPostId());

        Transaction txn = datastore.newTransaction();

        try {
            Entity post = txn.get(postKey);
            Entity user = txn.get(userKey);

            if (user == null || post == null)
                return Response.status(Response.Status.BAD_REQUEST).entity(USER_NOT_IN_DATABASE).build();

            // Caso ainda nao tenha dado nem up nem down
            if(!post.getList("ups").contains(username) && !post.getList("downs").contains(username)) {
                List<Value<String>> arrayProperty = post.getList("ups");
                List<Value<String>> updatedArrayProperty = new ArrayList<>(arrayProperty);
                updatedArrayProperty.add(StringValue.newBuilder(username).build());

                post = Entity.newBuilder(post).set("ups", updatedArrayProperty).build();

                txn.update(post);


                return Response.ok(g.toJson(ADDED_UP)).build();
            } else if(!post.getList("ups").contains(username) && post.getList("downs").contains(username)) {
                post.getList("downs").remove(StringValue.of(username));
                post.getList("ups").add(StringValue.of(username));
                return Response.ok(g.toJson(ADDED_UP)).build();
            } else {
                return Response.status(Response.Status.BAD_REQUEST).entity(USER_NOT_ALLOWED_TO_DELETE_POST).build();
            }

        } finally {
            if (txn.isActive())
                txn.rollback();
        }
    }

    @POST
    @Path("/adddown")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response addDown(@HeaderParam(AUTH) String auth, PostIdData postIde) {
        TokenData receivedToken = TokenUtil.validateToken(LOG, auth);

        if(receivedToken == null) {
            return Response.status(Response.Status.FORBIDDEN).build();
        }
        String username = receivedToken.getUsername();
        Key userKey = datastore.newKeyFactory().setKind("User").newKey(username);
        Key postKey = datastore.newKeyFactory().setKind("Post").newKey(postIde.getPostId());

        Transaction txn = datastore.newTransaction();

        try {
            Entity post = txn.get(postKey);
            Entity user = txn.get(userKey);

            if (user == null || post == null)
                return Response.status(Response.Status.BAD_REQUEST).entity(USER_NOT_IN_DATABASE).build();

            // Caso ainda nao tenha dado nem up nem down
            if(!post.getList("ups").contains(username) && !post.getList("downs").contains(username)) {
                post.getList("downs").add(StringValue.of(username));
                return Response.ok(g.toJson(ADDED_UP)).build();
            } else if(post.getList("ups").contains(username) && !post.getList("downs").contains(username)) {
                post.getList("ups").remove(StringValue.of(username));
                post.getList("downs").add(StringValue.of(username));
                return Response.ok(g.toJson(ADDED_UP)).build();
            } else {
                return Response.status(Response.Status.BAD_REQUEST).entity(USER_NOT_ALLOWED_TO_DELETE_POST).build();
            }

        } finally {
            if (txn.isActive())
                txn.rollback();
        }
    }

    @POST
    @Path("/delete")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response deletePost(@HeaderParam(AUTH) String auth, PostDeleteData data) {

        TokenData givenTokenData = TokenUtil.validateToken(LOG, auth);

        if(givenTokenData == null)
            return Response.status(Response.Status.FORBIDDEN).build();

        Key userKey = datastore.newKeyFactory().setKind("User").newKey(givenTokenData.getUsername());
        Key creatorKey = datastore.newKeyFactory().setKind("User").newKey(data.getUserCreator());

        Transaction txn = datastore.newTransaction();
        try {
            Entity user = txn.get(userKey);
            Entity creator = txn.get(creatorKey);
            if (user == null || creator == null)
                return Response.status(Response.Status.BAD_REQUEST).entity(USER_NOT_IN_DATABASE).build();

            if(givenTokenData.getUsername().equals(data.getUserCreator())) {
                Key postKey = datastore.newKeyFactory().setKind("Post").newKey(data.getPostIdentifier());
                Entity post = txn.get(postKey);
                if(post == null)
                    return Response.status(Response.Status.BAD_REQUEST).entity(POST_NOT_IN_DATABASE).build();

                txn.delete(postKey);
                txn.commit();
                memcache.delete((LIST_POSTS).hashCode());

                return Response.ok(g.toJson(POST_DELETED_SUCCESSFULLY)).build();
            } else {
                return Response.status(Response.Status.BAD_REQUEST).entity(USER_NOT_ALLOWED_TO_DELETE_POST).build();
            }

        } finally {
            if (txn.isActive())
                txn.rollback();
        }
    }



    private int getNextPost(String username) {
        AtomicInteger max = new AtomicInteger(0);

        Query<Entity> query = Query.newEntityQueryBuilder()
                .setKind("Post").setFilter(StructuredQuery.PropertyFilter.eq("username", username)).build();

        QueryResults<Entity> postQuery = datastore.run(query);

        postQuery.forEachRemaining(t -> {
            int val = Integer.parseInt(t.getKey().getName().replace(username, ""));
            if (max.get() < val)
                max.set(val);
        });

        return max.incrementAndGet();
    }
}
