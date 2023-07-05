package pt.unl.fct.di.apdc.firstwebapp.util.entities.calendar;

public class CalendarData {

    private  String username, title, description, from, to;
    private int backgroundColor;
    private boolean allDay, isPublic;

    public CalendarData() {
    }

    public CalendarData(String username, String tittle, String description, String from, String to, int backgroundColor, boolean allDay, boolean isPublic) {
        this.username = username;
        this.title = tittle;
        this.description = description;
        this.from = from;
        this.to = to;
        this.backgroundColor = backgroundColor;
        this.allDay = allDay;
        this.isPublic = isPublic;
    }

    public String getUsername() {
        return username;
    }

    public String getTitle() {
        return title;
    }

    public String getDescription() {
        return description;
    }

    public String getFrom() {
        return from;
    }

    public String getTo() {
        return to;
    }

    public int getBackgroundColor() {
        return backgroundColor;
    }

    public boolean getAllDay() {
        return allDay;
    }

    public boolean getIsPublic() {
        return isPublic;
    }

}
