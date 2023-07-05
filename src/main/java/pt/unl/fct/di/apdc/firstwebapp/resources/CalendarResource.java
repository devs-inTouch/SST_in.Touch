package pt.unl.fct.di.apdc.firstwebapp.resources;

import com.google.cloud.datastore.*;
import pt.unl.fct.di.apdc.firstwebapp.util.DatastoreUtil;
import com.google.gson.Gson;
import pt.unl.fct.di.apdc.firstwebapp.util.TokenUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.TokenData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.calendar.CalendarData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.calendar.CalendarDeleteData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.calendar.CalendarInfoData;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.logging.Logger;

import static pt.unl.fct.di.apdc.firstwebapp.util.enums.Globals.AUTH;

@Path("/calendar")
public class CalendarResource {
    private static final Logger LOG = Logger.getLogger(CalendarResource.class.getName());
    public static final String CALENDA_EVENT_CREATED_SUCESSFULLY = "Evento criado com sucesso";
    public static final String CALENDAR_EVENT_DELETED = "Evento eliminado";
    private final Datastore datastore = DatastoreUtil.getService();

    private final Gson g = new Gson();

    public CalendarResource() {
    }


    @POST
    @Path("/create")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response createCalendarEvent(@HeaderParam(AUTH) String auth, CalendarData data) {
        TokenData givenTokenData = TokenUtil.validateToken(LOG, auth);

        if(givenTokenData == null)
            return Response.status(Response.Status.FORBIDDEN).build();

        Key userKey = datastore.newKeyFactory().setKind("User").newKey(givenTokenData.getUsername());

        Transaction txn = datastore.newTransaction();
        try {
            Entity user = txn.get(userKey);
            if(user == null) {
                txn.rollback();
                return Response.status(Response.Status.FORBIDDEN).build();
            }
            String calendarId = data.getId();
            Key calendarKey = datastore.newKeyFactory().setKind("Calendar").newKey(calendarId);
            Entity calendar = Entity.newBuilder(calendarKey)
                    .set("username", givenTokenData.getUsername())
                    .set("title", data.getTitle())
                    .set("description", data.getDescription())
                    .set("from", data.getFrom())
                    .set("to", data.getTo())
                    .set("backgroundColor", data.getBackgroundColor())
                    .set("isAllDay", data.getIsAllDay())
                    .set("isPublic", data.getIsPublic())
                    .build();
            txn.add(calendar);
            txn.commit();
            return Response.ok(g.toJson(CALENDA_EVENT_CREATED_SUCESSFULLY)).build();
        }finally {
            if (txn.isActive()) {
                txn.rollback();
            }

        }
    }

    @POST
    @Path("/delete")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response deleteCalendarEvent(@HeaderParam(AUTH) String auth, CalendarDeleteData data) {
        TokenData givenTokenData = TokenUtil.validateToken(LOG, auth);

        if(givenTokenData == null)
            return Response.status(Response.Status.FORBIDDEN).build();

        Key userKey = datastore.newKeyFactory().setKind("User").newKey(givenTokenData.getUsername());
        Transaction txn = datastore.newTransaction();
        try {
            Entity user = txn.get(userKey);
            if(user == null) {
                txn.rollback();
                return Response.status(Response.Status.FORBIDDEN).build();
            }
            Key calendarKey = datastore.newKeyFactory().setKind("Calendar").newKey(Integer.parseInt(data.getCalendarId()));
            Entity calendar = txn.get(calendarKey);
            if(calendar == null)
                return Response.status(Response.Status.FORBIDDEN).build();
            txn.delete(calendarKey);
            txn.commit();
            return Response.ok(g.toJson(CALENDAR_EVENT_DELETED)).build();
        }finally {
                if (txn.isActive()) {
                    txn.rollback();
                }
            }

        }

    @POST
    @Path("/list")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response listUserCalendar(@HeaderParam(AUTH) String auth) {
        TokenData givenTokenData = TokenUtil.validateToken(LOG, auth);

        if(givenTokenData == null)
            return Response.status(Response.Status.FORBIDDEN).build();

        Key userKey = datastore.newKeyFactory().setKind("User").newKey(givenTokenData.getUsername());
        Transaction txn = datastore.newTransaction();
            Entity user = txn.get(userKey);
            if(user == null) {
                txn.rollback();
                return Response.status(Response.Status.FORBIDDEN).build();
            }
            Query<Entity> query = Query.newEntityQueryBuilder()
                    .setKind("Calendar")
                    .setFilter(StructuredQuery.PropertyFilter.eq("username", givenTokenData.getUsername()))
                    .build();
            QueryResults<Entity> calendarQuery = datastore.run(query);
            List<CalendarInfoData> calendarList = new ArrayList<>();
            calendarQuery.forEachRemaining(calendar -> {
                CalendarInfoData calendarData = new CalendarInfoData(
                        calendar.getKey().getId().intValue(),
                        calendar.getString("username"),
                        calendar.getString("title"),
                        calendar.getString("description"),
                        calendar.getString("from"),
                        calendar.getString("to"),
                        calendar.getString("backgroundColor"),
                        calendar.getBoolean("isAllDay"),
                        calendar.getBoolean("isPublic")
                );
                calendarList.add(calendarData);
            });


            return Response.ok(g.toJson(calendarList)).build();

    }


}
