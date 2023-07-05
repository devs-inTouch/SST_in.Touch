package pt.unl.fct.di.apdc.firstwebapp.resources;

import com.google.cloud.datastore.*;
import pt.unl.fct.di.apdc.firstwebapp.util.DatastoreUtil;
import com.google.gson.Gson;
import pt.unl.fct.di.apdc.firstwebapp.util.TokenUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.TokenData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.calendar.CalendarData;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.logging.Logger;

import static pt.unl.fct.di.apdc.firstwebapp.util.enums.Globals.AUTH;

@Path("/calendar")
public class CalendarResource {
    private static final Logger LOG = Logger.getLogger(CalendarResource.class.getName());
    public static final String CALENDA_EVENT_CREATED_SUCESSFULLY = "Evento criado com sucesso";
    private final Datastore datastore = DatastoreUtil.getService();

    private final Gson g = new Gson();

    public CalendarResource() {
    }


    @POST
    @Path("/create")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response createCalendar(@HeaderParam(AUTH) String auth, CalendarData data) {
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
            int calendarId = getNextCalendarId();
            Key calendarKey = datastore.newKeyFactory().setKind("Calendar").newKey(calendarId);
            Entity calendar = Entity.newBuilder(calendarKey)
                    .set("id", calendarId)
                    .set("owner", givenTokenData.getUsername())
                    .set("title", data.getTitle())
                    .set("description", data.getDescription())
                    .set("from", data.getFrom())
                    .set("to", data.getTo())
                    .set("backgroundColor", data.getBackgroundColor())
                    .set("allDay", data.getAllDay())
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

    private int getNextCalendarId() {
        AtomicInteger max = new AtomicInteger(0);
        Query<Entity> query = Query.newEntityQueryBuilder()
                .setKind("Calendar").build();

        QueryResults<Entity> calendarQuery = datastore.run(query);

        calendarQuery.forEachRemaining(calendar -> {
            int id = Integer.parseInt(calendar.getKey().getId().toString());
            if(id > max.get())
                max.set(id);
        });
        return max.incrementAndGet();
    }




}
