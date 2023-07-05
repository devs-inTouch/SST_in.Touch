package pt.unl.fct.di.apdc.firstwebapp.resources;

import com.google.cloud.datastore.*;
import com.google.gson.Gson;
import pt.unl.fct.di.apdc.firstwebapp.util.DatastoreUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.TokenUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.TokenData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.rooms.BookRoomData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.rooms.CreateRoomData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.rooms.RoomsPerHourData;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.logging.Logger;

import static pt.unl.fct.di.apdc.firstwebapp.util.enums.Globals.AUTH;

@Path("/reservation")
public class RoomReservationResource {

    private static final Logger LOG = Logger.getLogger(RoomReservationResource.class.getName());

    private final Datastore datastore = DatastoreUtil.getService();

    private final Gson g = new Gson();

    private final NotificationsResource notification;

    public RoomReservationResource() {
        notification = new NotificationsResource();
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

            Key k = datastore.newKeyFactory().setKind("Room").newKey(data.getName() + data.getDepartment() + data.getDate() + data.getHour());

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
    public Response deleteRoom(@HeaderParam(AUTH) String auth, CreateRoomData data) {
        TokenData givenTokenData = TokenUtil.validateToken(LOG, auth);

        if(givenTokenData == null)
            return Response.status(Response.Status.FORBIDDEN).build();

        Key userKey = datastore.newKeyFactory().setKind("User").newKey(givenTokenData.getUsername());

        Transaction txn = datastore.newTransaction();
        try {
            Entity user = txn.get(userKey);
            if(user == null)
                return Response.status(Response.Status.BAD_REQUEST).entity("User not in database").build();

            Key k = datastore.newKeyFactory().setKind("Room").newKey(data.getName() + data.getDepartment() + data.getDate() + data.getHour());
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
            list.add(new CreateRoomData(room.getString("name"), room.getString("department"), (int) room.getLong("space"), room.getString("date"), room.getString("hour")));
        });

        return Response.ok(g.toJson(list)).build();

    }

    @POST
    @Path("/getroomdate")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
    public Response getAvailableRoomsPerHour(RoomsPerHourData data) {
        Query<Entity> query = Query.newEntityQueryBuilder()
                .setKind("Room")
                .setFilter(StructuredQuery.CompositeFilter.and(
                        StructuredQuery.PropertyFilter.eq("date", data.getDate()),
                        StructuredQuery.PropertyFilter.eq("hour", data.getHour()),
                        StructuredQuery.PropertyFilter.eq("available", true)))
                .build();
        QueryResults<Entity> results = datastore.run(query);

        List<CreateRoomData> list = new ArrayList<>();

        results.forEachRemaining(room -> {
            list.add(new CreateRoomData(room.getString("name"), room.getString("department"), (int) room.getLong("space"), room.getString("date"), room.getString("hour")));
        });

        return Response.ok(g.toJson(list)).build();
    }


    @POST
    @Path("/book")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
    public Response bookRoom(@HeaderParam(AUTH) String auth, BookRoomData data) {
        TokenData givenTokenData = TokenUtil.validateToken(LOG, auth);

        if(givenTokenData == null)
            return Response.status(Response.Status.FORBIDDEN).build();

        Key userKey = datastore.newKeyFactory().setKind("User").newKey(givenTokenData.getUsername());
        Key roomKey = datastore.newKeyFactory().setKind("Room").newKey(data.getName() + data.getDepartment() + data.getDate() + data.getHour());

        Transaction txn = datastore.newTransaction();
        try {
            Entity user = txn.get(userKey);
            if(user == null)
                return Response.status(Response.Status.BAD_REQUEST).entity("User not in database").build();

            Entity room = txn.get(roomKey);
            if(room == null)
                return Response.status(Response.Status.BAD_REQUEST).entity("Room not in database").build();

            if(data.getAvailable())
                return Response.status(Response.Status.BAD_REQUEST).entity("Room not available").build();

            if(data.getNumberStudents() > Integer.parseInt(String.valueOf(room.getLong("space"))))
                return Response.status(Response.Status.BAD_REQUEST).entity("Number of students bigger than the space of the room").build();

            Key bookingKey = datastore.newKeyFactory().setKind("Booking")
                    .addAncestor(PathElement.of("User", givenTokenData.getUsername()))
                    .newKey(givenTokenData.getUsername() + "-" + room.getString("name") + "-" + room.getString("department") + "-" + room.getString("date") + "-" + room.getString("hour"));

            data.setUsername(givenTokenData.getUsername());

            Entity booking = Entity.newBuilder(bookingKey)
                    .set("username", data.getUsername())
                    .set("room", data.getName())
                    .set("department", data.getDepartment())
                    .set("numberStudents", data.getNumberStudents())
                    .set("date", data.getDate())
                    .set("hour", data.getHour())
                    .set("available", false)
                    .build();

            notification.createNotification("Reserva efetuada","System", givenTokenData.getUsername(), "Aviso", System.currentTimeMillis());
            txn.add(booking);
            txn.commit();

            return Response.ok(g.toJson("Room booked successfully")).build();

        } finally {
            if(txn.isActive())
                txn.rollback();
        }
    }

    @POST
    @Path("/listallbookings")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
    public Response listAllUnavailableBookings() {

        Query<Entity> query = Query.newEntityQueryBuilder().setKind("Booking")
                .setFilter(StructuredQuery.PropertyFilter.eq("available", false))
                .build();
        QueryResults<Entity> results = datastore.run(query);

        List<BookRoomData> list = new ArrayList<>();

        results.forEachRemaining(booking -> {
            list.add(new BookRoomData(booking.getString("username"), booking.getString("room"), booking.getString("department"), (int) booking.getLong("numberStudents"), booking.getString("date"), booking.getString("hour")));
        });

        return Response.ok(g.toJson(list)).build();
    }

    @POST
    @Path("/cancelbooking")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
    public Response cancelBooking(@HeaderParam(AUTH) String auth, BookRoomData data) {
        TokenData givenTokenData = TokenUtil.validateToken(LOG, auth);

        if(givenTokenData == null)
            return Response.status(Response.Status.FORBIDDEN).build();

        Key userKey = datastore.newKeyFactory().setKind("User").newKey(givenTokenData.getUsername());
        Transaction txn = datastore.newTransaction();
        try {
            Entity user = txn.get(userKey);
            if(user == null)
                return Response.status(Response.Status.BAD_REQUEST).entity("User not in database").build();

            if(givenTokenData.getUsername().equals(data.getUsername()))
                return Response.status(Response.Status.BAD_REQUEST).entity("User not allowed to cancel booking").build();

            Key bookingKey = datastore.newKeyFactory().setKind("Booking")
                    .addAncestor(PathElement.of("User", givenTokenData.getUsername()))
                    .newKey(givenTokenData.getUsername() + "-" + data.getName() + "-" + data.getDepartment() + "-" + data.getDate() + "-" + data.getHour());

            Entity booking = txn.get(bookingKey);
            if(booking == null)
                return Response.status(Response.Status.BAD_REQUEST).entity("Booking not in database").build();

            txn.delete(bookingKey);
            txn.commit();

            return Response.ok(g.toJson("Booking canceled successfully")).build();

        } finally {
            if(txn.isActive())
                txn.rollback();
        }
    }

    @POST
    @Path("/listuserbookings")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
    public Response listUserAvailableBookings(@HeaderParam(AUTH) String auth) {
        TokenData givenTokenData = TokenUtil.validateToken(LOG, auth);

        if(givenTokenData == null)
            return Response.status(Response.Status.FORBIDDEN).build();

        Query<Entity> query = Query.newEntityQueryBuilder().setKind("Booking")
                .setFilter(StructuredQuery.CompositeFilter.and(
                        StructuredQuery.PropertyFilter.eq("username", givenTokenData.getUsername()),
                        StructuredQuery.PropertyFilter.eq("available", true))).build();
        QueryResults<Entity> results = datastore.run(query);

        List<BookRoomData> list = new ArrayList<>();

        results.forEachRemaining(booking -> {
            list.add(new BookRoomData(booking.getString("username"), booking.getString("room"), booking.getString("department"), (int) booking.getLong("numberStudents"), booking.getString("date"), booking.getString("hour")));
        });

        return Response.ok(g.toJson(list)).build();
    }

    @POST
    @Path("/approve")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
    public Response approveBooking(@HeaderParam(AUTH) String auth, BookRoomData data) {
        TokenData givenTokenData = TokenUtil.validateToken(LOG, auth);

        if(givenTokenData == null)
            return Response.status(Response.Status.FORBIDDEN).build();

        Key userKey = datastore.newKeyFactory().setKind("User").newKey(givenTokenData.getUsername());
        Transaction txn = datastore.newTransaction();
        try {
            Entity user = txn.get(userKey);
            if (user == null)
                return Response.status(Response.Status.BAD_REQUEST).entity("User not in database").build();

            /*if (givenTokenData.getUsername().equals(data.getUsername()))
                return Response.status(Response.Status.BAD_REQUEST).entity("User not allowed to approve booking").build();*/

            Key bookingKey = datastore.newKeyFactory().setKind("Booking")
                    .addAncestor(PathElement.of("User", data.getUsername()))
                    .newKey(data.getUsername()+ "-" + data.getName() + "-" + data.getDepartment() + "-" + data.getDate() + "-" + data.getHour());

            Entity booking = txn.get(bookingKey);
            if (booking == null)
                return Response.status(Response.Status.BAD_REQUEST).entity("Booking not in database").build();

            Key roomKey = datastore.newKeyFactory().setKind("Room")
                    .newKey(data.getName() + data.getDepartment() + data.getDate() + data.getHour());

            Entity room = txn.get(roomKey);
            if (room == null)
                return Response.status(Response.Status.BAD_REQUEST).entity("Room not in database").build();


            Entity booking2 = Entity.newBuilder(bookingKey)
                    .set("username", booking.getString("username"))
                    .set("room", booking.getString("room"))
                    .set("department", booking.getString("department"))
                    .set("numberStudents", (int) booking.getLong("numberStudents"))
                    .set("date", booking.getString("date"))
                    .set("hour", booking.getString("hour"))
                    .set("available", true)
                    .build();

            Entity room2 = Entity.newBuilder(roomKey)
                    .set("name", room.getString("name"))
                    .set("department", room.getString("department"))
                    .set("space", (int) room.getLong("space"))
                    .set("date", room.getString("date"))
                    .set("hour", room.getString("hour"))
                    .set("available", false)
                    .build();

            txn.update(booking2);
            txn.update(room2);

            notification.createNotification("A sua reserva foi confirmada", "System", booking.getString("username"), "Aviso", System.currentTimeMillis());

            txn.commit();

            return Response.ok(g.toJson("Booking approved successfully")).build();

        } finally {
            if (txn.isActive())
                txn.rollback();
        }

    }


    private int getNextRoom(String name) {
        AtomicInteger max = new AtomicInteger(0);

        Query<Entity> query = Query.newEntityQueryBuilder()
                .setKind("Room").setFilter(StructuredQuery.PropertyFilter.eq("name", name)).build();

        QueryResults<Entity> roomQuery = datastore.run(query);

        roomQuery.forEachRemaining(t -> {
            int val = Integer.parseInt(t.getKey().getName().replace(name, ""));
            if (max.get() < val)
                max.set(val);
        });

        return max.incrementAndGet();
    }
}
