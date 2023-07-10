package pt.unl.fct.di.apdc.firstwebapp.resources;

import com.google.cloud.datastore.*;
import com.google.gson.Gson;
import pt.unl.fct.di.apdc.firstwebapp.util.DatastoreUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.TokenUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.TokenData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.events.CreateEventData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.events.DeleteEventData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.events.EventInfoData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.events.SubscribeEventData;
import pt.unl.fct.di.apdc.firstwebapp.util.enums.DatastoreEntities;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.logging.Logger;

import static pt.unl.fct.di.apdc.firstwebapp.util.enums.Globals.AUTH;

@Path("/event")
public class EventResource {

    private static final Logger LOG = Logger.getLogger(EventResource.class.getName());
    private static final String USER_NOT_ALLOWED_TO_CREATE_EVENTS = "User not allowed to create events";
    private static final String EVENT_CREATED = "Event created";
    private static final String USER_NOT_ALLOWED_TO_DELETE_EVENTS = "User not allowed to delete events";
    private static final String EVENT_DOES_NOT_EXIST = "Event does not exist";
    private static final String EVENT_ALREADY_IN_CALENDAR = "Event already in calendar";
    private static final String EVENT_SUBSCRIBED = "Event subscribed";

    private final Datastore datastore = DatastoreUtil.getService();

    private final Gson g = new Gson();

    private final String backgroundColor = "4294918273";


    public EventResource() {
    }

    @POST
    @Path("/create")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
    public Response createEvent(@HeaderParam(AUTH) String auth, CreateEventData data) {
        TokenData givenTokenData = TokenUtil.validateToken(LOG, auth);

        if(givenTokenData == null)
            return Response.status(Response.Status.FORBIDDEN).build();

        Key userKey = datastore.newKeyFactory().setKind(DatastoreEntities.USER.value).newKey(givenTokenData.getUsername());
        Transaction txn = datastore.newTransaction();

        try {
            Entity user = txn.get(userKey);

            if(user == null)
                return Response.status(Response.Status.FORBIDDEN).build();

            if(!user.getString("user_role").equals("admin"))
                return Response.status(Response.Status.BAD_REQUEST).entity(USER_NOT_ALLOWED_TO_CREATE_EVENTS).build();

            int nextEvent = getNextEvent();
            Key eventKey = datastore.newKeyFactory().setKind(DatastoreEntities.EVENT.value).newKey(nextEvent);

            Entity event = Entity.newBuilder(eventKey)
                    .set("title", data.getTitle())
                    .set("description", data.getDescription())
                    .set("date", data.getDate())
                    .set("from", data.getFrom())
                    .set("to", data.getTo())
                    .set("isAllDay", data.getIsAllDay())
                    .set("subscribers", new ArrayList<>())
                    .build();



            txn.add(event);
            txn.commit();

            return Response.ok().entity(g.toJson(EVENT_CREATED)).build();

        }  finally {
            if(txn.isActive())
                txn.rollback();
        }

    }


    @POST
    @Path("/delete")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
    public Response deleteEvent(@HeaderParam(AUTH) String auth, DeleteEventData data) {
        TokenData givenTokenData = TokenUtil.validateToken(LOG, auth);

        if(givenTokenData == null)
            return Response.status(Response.Status.FORBIDDEN).build();

        Key userKey = datastore.newKeyFactory().setKind(DatastoreEntities.USER.value).newKey(givenTokenData.getUsername());
        Transaction txn = datastore.newTransaction();

        try {
            Entity user = txn.get(userKey);

            if(user == null)
                return Response.status(Response.Status.FORBIDDEN).build();

            if(user.getString("user_role").equals("admin"))
                return Response.status(Response.Status.BAD_REQUEST).entity(USER_NOT_ALLOWED_TO_DELETE_EVENTS).build();

            Key eventKey = datastore.newKeyFactory().setKind(DatastoreEntities.EVENT.value).newKey(data.getEventId());
            Entity event = txn.get(eventKey);

            if(event == null)
                return Response.status(Response.Status.BAD_REQUEST).entity(EVENT_DOES_NOT_EXIST).build();

            txn.delete(eventKey);
            txn.commit();

            return Response.ok().build();

        } finally {
            if(txn.isActive())
                txn.rollback();
        }
    }

    @POST
    @Path("/listevents")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
    public Response ListEvents() {
        Query<Entity> query = Query.newEntityQueryBuilder()
                .setKind(DatastoreEntities.EVENT.value).build();

        QueryResults<Entity> eventQuery = datastore.run(query);

        List<EventInfoData> list = new ArrayList<>();

        eventQuery.forEachRemaining(t -> {
            list.add(new EventInfoData(t.getKey().getId().toString(), t.getString("title"), t.getString("description"), t.getString("date"), t.getString("from"), t.getString("to"),t.getBoolean("isAllDay"), Collections.singletonList(t.getString("subscribers"))));
        });

        return Response.ok(g.toJson(list)).build();
    }

    @POST
    @Path("/subscribeevent")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
    public Response subscribeEvent(@HeaderParam(AUTH) String auth, SubscribeEventData data) {
        TokenData givenTokenData = TokenUtil.validateToken(LOG, auth);

        if(givenTokenData == null)
            return Response.status(Response.Status.FORBIDDEN).build();

        Key userKey = datastore.newKeyFactory().setKind(DatastoreEntities.USER.value).newKey(givenTokenData.getUsername());
        Transaction txn = datastore.newTransaction();

        try {
            Entity user = txn.get(userKey);

            if(user == null)
                return Response.status(Response.Status.FORBIDDEN).build();


            Key eventKey = datastore.newKeyFactory().setKind(DatastoreEntities.EVENT.value).newKey(Integer.parseInt(data.getEventId()));
            Entity event = txn.get(eventKey);

            if(event == null)
                return Response.status(Response.Status.BAD_REQUEST).entity(EVENT_DOES_NOT_EXIST).build();

            List<Value<String>> list = event.getList("subscribers");
            List<Value<String>> newList = new ArrayList<>(list);
            newList.add(StringValue.of(givenTokenData.getUsername()));

            Entity updatedEvent = Entity.newBuilder(eventKey)
                    .set("title", event.getString("title"))
                    .set("description", event.getString("description"))
                    .set("date", event.getString("date"))
                    .set("from", event.getString("from"))
                    .set("to", event.getString("to"))
                    .set("isAllDay", event.getBoolean("isAllDay"))
                    .set("subscribers", newList)
                    .build();

            Key calendarKey = datastore.newKeyFactory().setKind("Calendar").newKey(data.getCalendarId());
            Entity calendar = txn.get(calendarKey);
            if (calendar != null)
                return Response.status(Response.Status.BAD_REQUEST).entity(EVENT_ALREADY_IN_CALENDAR).build();


            Entity updatedCalendar = Entity.newBuilder(calendarKey)
                    .set("username", givenTokenData.getUsername())
                    .set("title", event.getString("title"))
                    .set("description", event.getString("description"))
                    .set("from", event.getString("from"))
                    .set("to", event.getString("to"))
                    .set("backgroundColor", backgroundColor)
                    .set("isAllDay", event.getBoolean("isAllDay"))
                    .set("isPublic", true)
                    .set("id", data.getEventId())
                    .build();


            txn.update(updatedEvent);
            txn.add(updatedCalendar);
            txn.commit();

            return Response.ok().entity(g.toJson(EVENT_SUBSCRIBED)).build();

        } finally {
            if(txn.isActive())
                txn.rollback();
        }
    }



    private int getNextEvent() {
        AtomicInteger max = new AtomicInteger(0);

        Query<Entity> query = Query.newEntityQueryBuilder()
                .setKind(DatastoreEntities.EVENT.value).build();

        QueryResults<Entity> eventQuery = datastore.run(query);

        eventQuery.forEachRemaining(t -> {
            int val = Integer.parseInt(t.getKey().getId().toString());
            if (max.get() < val)
                max.set(val);
        });

        return max.incrementAndGet();
    }
}
