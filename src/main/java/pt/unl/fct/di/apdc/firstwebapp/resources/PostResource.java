package pt.unl.fct.di.apdc.firstwebapp.resources;

import com.google.cloud.datastore.*;
import com.google.gson.Gson;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.PostData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.PostInformationData;

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

@Path("/post")
public class PostResource {

    private static final Logger LOG = Logger.getLogger(LoginResource.class.getName());

    private final Datastore datastore = DatastoreOptions.getDefaultInstance().getService();

    private final Gson g = new Gson();

    public PostResource() {
    }

    @POST
    @Path("/create")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
    public Response createPost(PostData data) {
        LOG.fine("Attempt to create post: " + data.username);

        //TODO token verification

        Key userKey = datastore.newKeyFactory().setKind("User").newKey(data.username);
        Transaction txn = datastore.newTransaction();

        try {
            Entity user = txn.get(userKey);
            if (user == null)
                return Response.status(Response.Status.BAD_REQUEST).entity("User not in database").build();

            String postIdentification = data.username + getNextPost(data.username);
            Key k = datastore.newKeyFactory().setKind("Post").newKey(postIdentification);
            Entity post = Entity.newBuilder(k)
                    .set("username", data.username)
                    .set("description", data.description)
                    .set("mediaUrl", data.mediaUrl)
                    .set("ups", data.ups)
                    .set("downs", data.downs)
                    .set("creation_date", System.currentTimeMillis())
                    .build();
            txn.add(post);
            txn.commit();

            return Response.ok(g.toJson("Post created successfully")).build();
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

        Query<Entity> query = Query.newEntityQueryBuilder().setKind("Post")
                .setOrderBy(StructuredQuery.OrderBy.desc("creation_date")).build();
        QueryResults<Entity> postQuery = datastore.run(query);

        List<PostInformationData> list = new ArrayList<>();

        postQuery.forEachRemaining(t -> {
            list.add(new PostInformationData(t.getKey().getName(), t.getString("username"), t.getString("description"),
                    t.getString("mediaUrl"), (int) t.getLong("ups"), (int) t.getLong("downs"), t.getLong("creation_date")));
        });

        return Response.ok(g.toJson(list)).build();
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
