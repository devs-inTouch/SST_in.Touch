package pt.unl.fct.di.apdc.firstwebapp.util.entities.events;

public class CreateEventData {

    private String title, description, date, hour;

    public CreateEventData() {
    }

    public CreateEventData(String title, String description, String date, String hour) {
        this.title = title;
        this.description = description;
        this.date = date;
        this.hour = hour;
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
