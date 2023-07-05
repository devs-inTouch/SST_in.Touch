package pt.unl.fct.di.apdc.firstwebapp.util.entities.calendar;

public class CalendarInfoData {
    private int id;
    private String username, title, description, from, to, backgroundColor;
    private boolean isAllDay, isPublic;

    public CalendarInfoData() {
    }

   public CalendarInfoData(int id, String username, String title, String description,
                            String from, String to, String backgroundColor,
                            boolean isAllDay, boolean isPublic) {
        this.id = id;
        this.username = username;
        this.title = title;
        this.description = description;
        this.from = from;
        this.to = to;
        this.backgroundColor = backgroundColor;
        this.isAllDay = isAllDay;
        this.isPublic = isPublic;
    }


    public int getId() {
        return id;
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

    public String getBackgroundColor() {
        return backgroundColor;
    }

    public boolean getIsAllDay() {
        return isAllDay;
    }

    public boolean getIsPublic() {
        return isPublic;
    }
}
