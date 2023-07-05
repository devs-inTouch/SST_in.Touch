package pt.unl.fct.di.apdc.firstwebapp.util.entities.events;

public class EventInfoData {

    private String eventId, title, description, date, hour;

    public EventInfoData() {
    }

    public EventInfoData(String eventId, String title, String description, String date, String hour) {
        this.eventId = eventId;
        this.title = title;
        this.description = description;
        this.date = date;
        this.hour = hour;
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

    public String getHour() {
        return hour;
    }
}
