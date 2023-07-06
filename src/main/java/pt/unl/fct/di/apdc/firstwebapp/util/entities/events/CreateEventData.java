package pt.unl.fct.di.apdc.firstwebapp.util.entities.events;

import java.util.List;

public class CreateEventData {

    private String title, description, date, from, to;
    private List<String> list;

    public CreateEventData() {
    }

    public CreateEventData(String title, String description, String date, String from, String to) {
        this.title = title;
        this.description = description;
        this.date = date;
        this.from = from;
        this.to = to;
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
}
