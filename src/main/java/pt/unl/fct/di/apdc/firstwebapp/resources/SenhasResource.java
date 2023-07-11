package pt.unl.fct.di.apdc.firstwebapp.resources;

import com.google.appengine.api.memcache.MemcacheService;
import com.google.appengine.api.memcache.MemcacheServiceException;
import com.google.appengine.api.memcache.MemcacheServiceFactory;
import com.google.cloud.datastore.*;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import pt.unl.fct.di.apdc.firstwebapp.util.DatastoreUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.TokenUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.SenhasData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.TokenData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.post.PostData;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

import static pt.unl.fct.di.apdc.firstwebapp.util.enums.Globals.AUTH;

@Path("/senhas")
public class SenhasResource {
    private final Datastore datastore = DatastoreUtil.getService();
    private static final Logger LOG = Logger.getLogger(SenhasResource.class.getName());

    private final MemcacheService memcache;

    private final Gson g = new Gson();

    private static final String USER_NOT_IN_DATABASE = "User not in database";
    private static final String POST_CREATED_SUCCESSFULLY = "Post created successfully";
    private static final String POST_NOT_IN_DATABASE = "Post not in database";
    private static final String POST_DELETED_SUCCESSFULLY = "Post deleted successfully";
    private static final String USER_NOT_ALLOWED_TO_DELETE_POST = "User not allowed to delete post";


    public SenhasResource() {
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
    public Response createSenha(@HeaderParam(AUTH) String auth, SenhasData data) {

        TokenData givenTokenData = TokenUtil.validateToken(LOG, auth);

        if(givenTokenData == null)
            return Response.status(Response.Status.FORBIDDEN).build();

        Key senhaKey = datastore.newKeyFactory().setKind("Senhas").newKey(givenTokenData.getUsername());
        Transaction txn = datastore.newTransaction();

        try {
            String json = "{\"chave\":\"demo-f367-a195-6008-a19\",\"valor\":1,\"alias\":\"987654321\"}";

            Gson gson = new Gson();
            JsonObject jsonObject = gson.fromJson(json, JsonObject.class);

            // Replace the "alias" value with data.getNumber()
            jsonObject.addProperty("alias", data.getNumero());

            String updatedJson = gson.toJson(jsonObject);

            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create("https://sandbox.eupago.pt/clientes/rest_api/mbway/create"))
                    .header("accept", "application/json")
                    .header("content-type", "application/json")
                    .method("POST", HttpRequest.BodyPublishers.ofString(updatedJson))
                    .build();
            HttpResponse<String> response = HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString());
            if(response.statusCode() == 200) {
                Entity senha = Entity.newBuilder(senhaKey)
                        .set("code", data.getCode())
                        .set("creation_date", System.currentTimeMillis())
                        .set("scanned",false)
                        .build();

                txn.add(senha);
                txn.commit();

                return Response.ok(g.toJson("true")).build();
            } else {
                return Response.status(Response.Status.BAD_REQUEST).build();
            }


        } catch (IOException | InterruptedException e ) {
            throw new RuntimeException(e);
        } finally {
            if (txn.isActive())
                txn.rollback();
        }
    }

    @POST
    @Path("/check")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
    public Response getSenha(@HeaderParam(AUTH) String auth, SenhasData data) {

        TokenData givenTokenData = TokenUtil.validateToken(LOG, auth);

        if(givenTokenData == null)
            return Response.status(Response.Status.FORBIDDEN).build();


        Transaction txn = datastore.newTransaction();

        try {

            Query<Entity> query = Query.newEntityQueryBuilder().setKind("Senhas")
                    .setFilter( StructuredQuery.CompositeFilter.and(
                            StructuredQuery.PropertyFilter.eq("code", data.getCode()),
                            StructuredQuery.PropertyFilter.eq("scanned", false)))
                    .build();

            QueryResults<Entity> senhaQuery = datastore.run(query);

            List<String> list = new ArrayList<>();

            senhaQuery.forEachRemaining(
                t -> {list.add(String.valueOf(t));}
            );

            if(list.isEmpty())
                return Response.ok(g.toJson("false")).build();
            else
                return Response.status(Response.Status.BAD_REQUEST).build();

        } finally {
            if (txn.isActive())
                txn.rollback();
        }
    }

    @POST
    @Path("/getLido")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
    public Response getSenhasLidas(@HeaderParam(AUTH) String auth) {

        TokenData givenTokenData = TokenUtil.validateToken(LOG, auth);

        if(givenTokenData == null)
            return Response.status(Response.Status.FORBIDDEN).build();


        Transaction txn = datastore.newTransaction();

        try {

            Query<Entity> query = Query.newEntityQueryBuilder().setKind("Senhas")
                    .setFilter(StructuredQuery.PropertyFilter.eq("scanned", true))
                    .build();

            QueryResults<Entity> senhaQuery = datastore.run(query);

            List<String> list = new ArrayList<>();

            senhaQuery.forEachRemaining(
                    t -> {list.add(String.valueOf(t));}
            );
            return Response.ok(g.toJson(list.size())).build();

        } finally {
            if (txn.isActive())
                txn.rollback();
        }
    }

    @POST
    @Path("/getResto")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
    public Response getSenhasRestantes(@HeaderParam(AUTH) String auth) {

        TokenData givenTokenData = TokenUtil.validateToken(LOG, auth);

        if(givenTokenData == null)
            return Response.status(Response.Status.FORBIDDEN).build();


        Transaction txn = datastore.newTransaction();

        try {

            Query<Entity> query = Query.newEntityQueryBuilder().setKind("Senhas")
                    .setFilter(StructuredQuery.PropertyFilter.eq("scanned", false))
                    .build();

            QueryResults<Entity> senhaQuery = datastore.run(query);

            List<String> list = new ArrayList<>();

            senhaQuery.forEachRemaining(
                    t -> {list.add(String.valueOf(t));}
            );
            return Response.ok(g.toJson(list.size())).build();

        } finally {
            if (txn.isActive())
                txn.rollback();
        }
    }


    @POST
    @Path("/getCode")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
    public Response getCode(@HeaderParam(AUTH) String auth) {

        TokenData givenTokenData = TokenUtil.validateToken(LOG, auth);

        if(givenTokenData == null)
            return Response.status(Response.Status.FORBIDDEN).build();


        Transaction txn = datastore.newTransaction();
        Key senhaKey = datastore.newKeyFactory().setKind("Senhas").newKey(givenTokenData.getUsername());

        try {

           Entity senha = txn.get(senhaKey);
           if(senha == null)
               return Response.status(Response.Status.BAD_REQUEST).build();
           String code = senha.getString("code");
           return Response.ok(g.toJson(code)).build();

        } finally {
            if (txn.isActive())
                txn.rollback();
        }
    }



}
