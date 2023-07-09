package pt.unl.fct.di.apdc.firstwebapp.util.entities.events;

import pt.unl.fct.di.apdc.firstwebapp.util.entities.UserData;

import java.util.List;

public class SubscribeEventData {

    private String eventId, calendarId;

    public SubscribeEventData() {
    }

    public SubscribeEventData(String eventId, String calendarId) {
        this.eventId = eventId;
        this.calendarId = calendarId;
    }

    public String getEventId() {
        return eventId;
    }

    public String getCalendarId() {
        return calendarId;
    }

}
