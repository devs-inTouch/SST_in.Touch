package pt.unl.fct.di.apdc.firstwebapp.util.entities.rooms;

public class DeleteRoomData {

    private String name, department;

    public DeleteRoomData() {
    }

    public DeleteRoomData(String name, String department) {
        this.name = name;
        this.department = department;
    }

    public String getName() {
        return name;
    }

    public String getDepartment() {
        return department;
    }
}
