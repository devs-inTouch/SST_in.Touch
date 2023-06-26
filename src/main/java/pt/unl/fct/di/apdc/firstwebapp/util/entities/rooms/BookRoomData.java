package pt.unl.fct.di.apdc.firstwebapp.util.entities.rooms;

public class BookRoomData {

    private String name, department, date, hour;
    private int numberStudents;
    private boolean available;

    public BookRoomData() {
    }

    public BookRoomData(String name, String department, int numberStudents, String date, String hour) {
        this.name = name;
        this.department = department;
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

    public boolean getAvailable() {
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
