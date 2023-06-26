package pt.unl.fct.di.apdc.firstwebapp.util.entities.rooms;

public class BookRoomData {

    private String name, department, available, date, hour;
    private int numberStudents;

    public BookRoomData() {
    }

    public BookRoomData(String name, String department, String available,int numberStudents, String date, String hour) {
        this.name = name;
        this.department = department;
        this.available = available;
        this.numberStudents = numberStudents;
        this.date = date;
        this.hour = hour;
    }

    public String getName() {
        return name;
    }

    public String getDepartment() {
        return department;
    }

    public String getAvailable() {
        return available;
    }

    public int getNumberStudents() {
        return numberStudents;
    }

    public String getDate() {
        return date;
    }

    public String getHour() {
        return hour;
    }
}
