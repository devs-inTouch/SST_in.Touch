package pt.unl.fct.di.apdc.firstwebapp.util.entities.events;

import java.util.List;

public class EventInfoData {

    private String eventId, title, description, date, from, to;
    private List<String> list;
    private boolean isAllDay;

    public EventInfoData() {
    }

    public EventInfoData(String eventId, String title, String description, String date, String from, String to,Boolean isAllDay, List<String> list) {
        this.eventId = eventId;
        this.title = title;
        this.description = description;
        this.date = date;
        this.from = from;
        this.to = to;
        this.isAllDay = isAllDay;
        this.list = list;
    }

    public String getEventId() {
        return eventId;
    }

    public String getTitle() {
        return title;
    }

    public String getDescription() {
        return description;
    }

    public String getDate() {
        return date;
    }

    public String getFrom() {
        return from;
    }

    public String getTo() {
        return to;
    }

    public List<String> getList() {
        return list;
    }

    public boolean getIsAllDay() {
        return isAllDay;
    }
}
