package pt.unl.fct.di.apdc.firstwebapp.util.entities.rooms;

public class RoomsPerHourData {

    private String date, hour;

    public RoomsPerHourData() {
    }

    public RoomsPerHourData(String date, String hour) {
        this.date = date;
        this.hour = hour;
    }

    public String getDate() {
        return date;
    }

    public String getHour() {
        return hour;
    }
}
