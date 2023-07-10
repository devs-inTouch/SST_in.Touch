package pt.unl.fct.di.apdc.firstwebapp.util.entities.rooms;

public class DeleteRoomData {

    private String roomId, name, department;

    public DeleteRoomData() {
    }

    public DeleteRoomData(String roomId, String name, String department) {
        this.roomId = roomId;
        this.name = name;
        this.department = department;
    }

    public String getRoomId() {
        return roomId;
    }

    public String getName() {
        return name;
    }

    public String getDepartment() {
        return department;
    }
}
