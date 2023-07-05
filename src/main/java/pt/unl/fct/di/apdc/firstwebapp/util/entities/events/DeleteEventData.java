package pt.unl.fct.di.apdc.firstwebapp.util.entities.events;

public class DeleteEventData {

    private String eventId;

    public DeleteEventData() {
    }

    public DeleteEventData(String eventId) {
        this.eventId = eventId;
    }

    public String getEventId() {
        return eventId;
    }
}
