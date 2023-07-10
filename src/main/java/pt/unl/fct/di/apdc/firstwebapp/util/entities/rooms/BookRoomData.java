package pt.unl.fct.di.apdc.firstwebapp.util.entities.rooms;

public class BookRoomData {

    private String name, department, date, hour, username;
    private int numberStudents;
    private boolean available;


    public BookRoomData() {
    }

    public BookRoomData(String username, String name, String department, int numberStudents, String date, String hour) {
        this.username = username;
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

    public boolean getAvailable() {return available;}

    public int getNumberStudents() {
        return numberStudents;
    }

    public String getDate() {
        return date;
    }

    public String getHour() {
        return hour;
    }

    public String getUsername() {
    	return username;
    }

    public void setUsername(String username) {
    	this.username = username;
    }

}
