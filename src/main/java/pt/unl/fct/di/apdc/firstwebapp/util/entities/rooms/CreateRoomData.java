package pt.unl.fct.di.apdc.firstwebapp.util.entities.rooms;

public class CreateRoomData {

    private String name, department, date, hour;
    private int space;

    public CreateRoomData() {
    }

    public CreateRoomData(String name, String department, int space, String date, String hour) {
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

    public int getSpace() {
        return space;
    }

    public String getDate() {
        return date;
    }

    public String getHour() {
        return hour;
    }

}
