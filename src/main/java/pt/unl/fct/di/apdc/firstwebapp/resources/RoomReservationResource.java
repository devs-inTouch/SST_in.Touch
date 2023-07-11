package pt.unl.fct.di.apdc.firstwebapp.resources;

import com.google.cloud.datastore.*;
import com.google.gson.Gson;
import pt.unl.fct.di.apdc.firstwebapp.util.DatastoreUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.TokenUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.clientObjects.TokenData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.rooms.BookRoomData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.rooms.CreateRoomData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.rooms.RoomsPerHourData;
import pt.unl.fct.di.apdc.firstwebapp.util.enums.DatastoreEntities;

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
    private static final String USER_NOT_IN_DATABASE = "User not in database";
    private static final String ROOM_ALREADY_IN_DATABASE = "Room already in database";
    private static final String ROOM_ADDED_SUCCESSFULLY = "Room added successfully";
    private static final String ROOM_NOT_IN_DATABASE = "Room not in database";
    private static final String ROOM_NOT_IN_DEPARTMENT = "Room not in department";
    private static final String ROOM_DELETED_SUCCESSFULLY = "Room deleted successfully";
    private static final String ROOM_NOT_AVAILABLE = "Room not available";
    private static final String SPACE_OF_THE_ROOM = "Number of students bigger than the space of the room";
    private static final String ROOM_BOOKED_SUCCESSFULLY = "Room booked successfully";
    private static final String RESERVA_EFETUADA = "Reserva efetuada";
    private static final String USER_NOT_ALLOWED_TO_CANCEL_BOOKING = "User not allowed to cancel booking";
    private static final String BOOKING_NOT_IN_DATABASE = "Booking not in database";
    private static final String BOOKING_CANCELED_SUCCESSFULLY = "Booking canceled successfully";
    private static final String A_SUA_RESERVA_FOI_CONFIRMADA = "A sua reserva foi confirmada";
    private static final String BOOKING_APPROVED_SUCCESSFULLY = "Booking approved successfully";
    private static final String A_SUA_RESERVA_FOI_REJEITADA = "A sua reserva foi rejeitada";
    private static final String BOOKING_NOT_APPROVED_SUCCESSFULLY = "Booking not approved successfully";

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

        Key userKey = datastore.newKeyFactory().setKind(DatastoreEntities.USER.value).newKey(givenTokenData.getUsername());
        Transaction txn = datastore.newTransaction();
        try{
            Entity user = txn.get(userKey);
            if(user == null)
                return Response.status(Response.Status.BAD_REQUEST).entity(USER_NOT_IN_DATABASE).build();

            Key k = datastore.newKeyFactory().setKind(DatastoreEntities.ROOM.value).newKey(data.getName() + data.getDepartment() + data.getDate() + data.getHour());

            Entity hasRoom = txn.get(k);
            if(hasRoom != null)
                return Response.status(Response.Status.BAD_REQUEST).entity(ROOM_ALREADY_IN_DATABASE).build();

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

            return Response.ok(g.toJson(ROOM_ADDED_SUCCESSFULLY)).build();

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

        Key userKey = datastore.newKeyFactory().setKind(DatastoreEntities.USER.value).newKey(givenTokenData.getUsername());

        Transaction txn = datastore.newTransaction();
        try {
            Entity user = txn.get(userKey);
            if(user == null)
                return Response.status(Response.Status.BAD_REQUEST).entity(USER_NOT_IN_DATABASE).build();

            Key k = datastore.newKeyFactory().setKind(DatastoreEntities.ROOM.value).newKey(data.getName() + data.getDepartment() + data.getDate() + data.getHour());
            Entity room = txn.get(k);
            if(room == null)
                return Response.status(Response.Status.BAD_REQUEST).entity(ROOM_NOT_IN_DATABASE).build();

            if(!room.getString("department").equals(data.getDepartment()))
                return Response.status(Response.Status.BAD_REQUEST).entity(ROOM_NOT_IN_DEPARTMENT).build();

            txn.delete(k);
            txn.commit();

            return Response.ok(g.toJson(ROOM_DELETED_SUCCESSFULLY)).build();

        } finally {
            if(txn.isActive())
                txn.rollback();
        }
    }

    @POST
    @Path("/getrooms")
    public Response getAvailableRooms() {
        Query<Entity> query = Query.newEntityQueryBuilder()
                .setKind(DatastoreEntities.ROOM.value)
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
                .setKind(DatastoreEntities.ROOM.value)
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

        Key userKey = datastore.newKeyFactory().setKind(DatastoreEntities.USER.value).newKey(givenTokenData.getUsername());
        Key roomKey = datastore.newKeyFactory().setKind(DatastoreEntities.ROOM.value).newKey(data.getName() + data.getDepartment() + data.getDate() + data.getHour());

        Transaction txn = datastore.newTransaction();
        try {
            Entity user = txn.get(userKey);
            if(user == null)
                return Response.status(Response.Status.BAD_REQUEST).entity(USER_NOT_IN_DATABASE).build();

            Entity room = txn.get(roomKey);
            if(room == null)
                return Response.status(Response.Status.BAD_REQUEST).entity(ROOM_NOT_IN_DATABASE).build();

            if(data.getAvailable())
                return Response.status(Response.Status.BAD_REQUEST).entity(ROOM_NOT_AVAILABLE).build();

            if(data.getNumberStudents() > Integer.parseInt(String.valueOf(room.getLong("space"))))
                return Response.status(Response.Status.BAD_REQUEST).entity(SPACE_OF_THE_ROOM).build();

            Key bookingKey = datastore.newKeyFactory().setKind(DatastoreEntities.BOOKING.value)
                    .addAncestor(PathElement.of(DatastoreEntities.USER.value, givenTokenData.getUsername()))
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

            notification.createNotification(RESERVA_EFETUADA,"System", givenTokenData.getUsername(), "Aviso", System.currentTimeMillis());
            txn.add(booking);
            txn.commit();

            return Response.ok(g.toJson(ROOM_BOOKED_SUCCESSFULLY)).build();

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

        Query<Entity> query = Query.newEntityQueryBuilder().setKind(DatastoreEntities.BOOKING.value)
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

        Key userKey = datastore.newKeyFactory().setKind(DatastoreEntities.USER.value).newKey(givenTokenData.getUsername());
        Transaction txn = datastore.newTransaction();
        try {
            Entity user = txn.get(userKey);
            if(user == null)
                return Response.status(Response.Status.BAD_REQUEST).entity(USER_NOT_IN_DATABASE).build();

            if(givenTokenData.getUsername().equals(data.getUsername()))
                return Response.status(Response.Status.BAD_REQUEST).entity(USER_NOT_ALLOWED_TO_CANCEL_BOOKING).build();

            Key bookingKey = datastore.newKeyFactory().setKind(DatastoreEntities.BOOKING.value)
                    .addAncestor(PathElement.of(DatastoreEntities.USER.value, givenTokenData.getUsername()))
                    .newKey(givenTokenData.getUsername() + "-" + data.getName() + "-" + data.getDepartment() + "-" + data.getDate() + "-" + data.getHour());

            Entity booking = txn.get(bookingKey);
            if(booking == null)
                return Response.status(Response.Status.BAD_REQUEST).entity(BOOKING_NOT_IN_DATABASE).build();

            txn.delete(bookingKey);
            txn.commit();

            return Response.ok(g.toJson(BOOKING_CANCELED_SUCCESSFULLY)).build();

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

        Query<Entity> query = Query.newEntityQueryBuilder().setKind(DatastoreEntities.BOOKING.value)
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

        Key userKey = datastore.newKeyFactory().setKind(DatastoreEntities.USER.value).newKey(givenTokenData.getUsername());
        Transaction txn = datastore.newTransaction();
        try {
            Entity user = txn.get(userKey);
            if (user == null)
                return Response.status(Response.Status.BAD_REQUEST).entity(USER_NOT_IN_DATABASE).build();


            Key bookingKey = datastore.newKeyFactory().setKind(DatastoreEntities.BOOKING.value)
                    .addAncestor(PathElement.of(DatastoreEntities.USER.value, data.getUsername()))
                    .newKey(data.getUsername()+ "-" + data.getName() + "-" + data.getDepartment() + "-" + data.getDate() + "-" + data.getHour());

            Entity booking = txn.get(bookingKey);
            if (booking == null)
                return Response.status(Response.Status.BAD_REQUEST).entity(BOOKING_NOT_IN_DATABASE).build();

            Key roomKey = datastore.newKeyFactory().setKind(DatastoreEntities.ROOM.value)
                    .newKey(data.getName() + data.getDepartment() + data.getDate() + data.getHour());

            Entity room = txn.get(roomKey);
            if (room == null)
                return Response.status(Response.Status.BAD_REQUEST).entity(ROOM_NOT_IN_DATABASE).build();


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

            notification.createNotification(A_SUA_RESERVA_FOI_CONFIRMADA, "System", booking.getString("username"), "Aviso", System.currentTimeMillis());

            txn.commit();

            return Response.ok(g.toJson(BOOKING_APPROVED_SUCCESSFULLY)).build();

        } finally {
            if (txn.isActive())
                txn.rollback();
        }

    }

    @POST
    @Path("/notapprove")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
    public Response notApproveBooking(@HeaderParam(AUTH) String auth, BookRoomData data) {
        TokenData givenTokenData = TokenUtil.validateToken(LOG, auth);

        if(givenTokenData == null)
            return Response.status(Response.Status.FORBIDDEN).build();

        Key userKey = datastore.newKeyFactory().setKind(DatastoreEntities.USER.value).newKey(givenTokenData.getUsername());
        Transaction txn = datastore.newTransaction();

        try {
            Entity user = txn.get(userKey);
            if (user == null)
                return Response.status(Response.Status.BAD_REQUEST).entity(USER_NOT_IN_DATABASE).build();

            Key bookingKey = datastore.newKeyFactory().setKind(DatastoreEntities.BOOKING.value)
                    .addAncestor(PathElement.of(DatastoreEntities.USER.value, data.getUsername()))
                    .newKey(data.getUsername()+ "-" + data.getName() + "-" + data.getDepartment() + "-" + data.getDate() + "-" + data.getHour());

            Entity booking = txn.get(bookingKey);
            if (booking == null)
                return Response.status(Response.Status.BAD_REQUEST).entity(BOOKING_NOT_IN_DATABASE).build();

            txn.delete(bookingKey);
            txn.commit();

            notification.createNotification(A_SUA_RESERVA_FOI_REJEITADA, "System", booking.getString("username"), "Aviso", System.currentTimeMillis());

            return Response.ok(g.toJson(BOOKING_NOT_APPROVED_SUCCESSFULLY)).build();

        } finally {
            if(txn.isActive())
                txn.rollback();
        }
    }


    private int getNextRoom(String name) {
        AtomicInteger max = new AtomicInteger(0);

        Query<Entity> query = Query.newEntityQueryBuilder()
                .setKind(DatastoreEntities.ROOM.value).setFilter(StructuredQuery.PropertyFilter.eq("name", name)).build();

        QueryResults<Entity> roomQuery = datastore.run(query);

        roomQuery.forEachRemaining(t -> {
            int val = Integer.parseInt(t.getKey().getName().replace(name, ""));
            if (max.get() < val)
                max.set(val);
        });

        return max.incrementAndGet();
    }
}
