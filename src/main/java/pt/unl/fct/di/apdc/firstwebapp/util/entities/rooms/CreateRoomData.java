package pt.unl.fct.di.apdc.firstwebapp.util.entities.rooms;

public class CreateRoomData {

    private String name, department, space, date, hour;
    //private boolean isAvailable;

    public CreateRoomData() {
    }

    public CreateRoomData(String name, String department, String space, String date, String hour) {
        this.name = name;
        this.department = department;
        this.space = space;
        this.date = date;
        this.hour = hour;
    }

    public String getName() {
        return name;
    }

    public String getDepartment() {
        return department;
    }

    public String getSpace() {
        return space;
    }

    public String getDate() {
        return date;
    }

    public String getHour() {
        return hour;
    }

    /*public boolean getIsAvailable() {
        return isAvailable;
    }*/


}
