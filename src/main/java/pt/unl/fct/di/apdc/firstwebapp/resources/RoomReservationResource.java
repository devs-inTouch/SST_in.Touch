package pt.unl.fct.di.apdc.firstwebapp.resources;

import com.google.cloud.datastore.*;
import com.google.gson.Gson;
import pt.unl.fct.di.apdc.firstwebapp.util.DatastoreUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.TokenUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.TokenData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.rooms.BookRoomData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.rooms.CreateRoomData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.rooms.DeleteRoomData;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

import static pt.unl.fct.di.apdc.firstwebapp.util.enums.Globals.AUTH;

@Path("/reservation")
public class RoomReservationResource {

    private static final Logger LOG = Logger.getLogger(RoomReservationResource.class.getName());

    private final Datastore datastore = DatastoreUtil.getService();

    private final Gson g = new Gson();

    public RoomReservationResource() {
    }

    @POST
    @Path("/add")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
    public Response addRoom(@HeaderParam(AUTH) String auth, CreateRoomData data) {
        TokenData givenTokenData = TokenUtil.validateToken(LOG, auth);

        if(givenTokenData == null)
            return Response.status(Response.Status.FORBIDDEN).build();

        Key userKey = datastore.newKeyFactory().setKind("User").newKey(givenTokenData.getUsername());
        Transaction txn = datastore.newTransaction();
        try{
            Entity user = txn.get(userKey);
            if(user == null)
                return Response.status(Response.Status.BAD_REQUEST).entity("User not in database").build();

            Key k = datastore.newKeyFactory().setKind("Room").newKey(data.getName() +"-" + data.getDepartment());

            Entity hasRoom = txn.get(k);
            if(hasRoom != null)
                return Response.status(Response.Status.BAD_REQUEST).entity("Room already in database").build();

            Entity room = Entity.newBuilder(k)
                    .set("name", data.getName())
                    .set("department", data.getDepartment())
                    .set("space", data.getSpace())
                    .set("date", data.getDate())
                    .set("hour", data.getHour())
                    .set("available", true)
                    .build();

            txn.add(room);
            txn.commit();

            return Response.ok(g.toJson("Room added successfully")).build();

        } finally {
            if(txn.isActive())
                txn.rollback();
        }
    }

    @POST
    @Path("/delete")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
    public Response deleteRoom(@HeaderParam(AUTH) String auth, DeleteRoomData data) {
        TokenData givenTokenData = TokenUtil.validateToken(LOG, auth);

        if(givenTokenData == null)
            return Response.status(Response.Status.FORBIDDEN).build();

        Key userKey = datastore.newKeyFactory().setKind("User").newKey(givenTokenData.getUsername());

        Transaction txn = datastore.newTransaction();
        try {
            Entity user = txn.get(userKey);
            if(user == null)
                return Response.status(Response.Status.BAD_REQUEST).entity("User not in database").build();

            Key k = datastore.newKeyFactory().setKind("Room").newKey(data.getName());
            Entity room = txn.get(k);
            if(room == null)
                return Response.status(Response.Status.BAD_REQUEST).entity("Room not in database").build();

            if(!room.getString("department").equals(data.getDepartment()))
                return Response.status(Response.Status.BAD_REQUEST).entity("Room not in department").build();

            txn.delete(k);
            txn.commit();

            return Response.ok(g.toJson("Room deleted successfully")).build();

        } finally {
            if(txn.isActive())
                txn.rollback();
        }
    }

    @POST
    @Path("/getrooms")
    public Response getAvailableRooms() {
        Query<Entity> query = Query.newEntityQueryBuilder()
                .setKind("Room")
                .setFilter(StructuredQuery.PropertyFilter.eq("available", true))
                .build();
        QueryResults<Entity> results = datastore.run(query);

        List<CreateRoomData> list = new ArrayList<>();

        results.forEachRemaining(room -> {
            list.add(new CreateRoomData(room.getString("name"), room.getString("department"), room.getString("space"), room.getString("date"), room.getString("hour")));
        });

        return Response.ok(g.toJson(list)).build();

    }

    /*public Response bookRoom(BookRoomData data) {

    }*/
}
