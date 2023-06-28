package pt.unl.fct.di.apdc.firstwebapp.util.entities.rooms;

public class DeleteRoomData {

    private String roomId, name, departement;

    public DeleteRoomData() {
    }

    public DeleteRoomData(String roomId, String name, String departement) {
        this.roomId = roomId;
        this.name = name;
        this.departement = departement;
    }

    public String getRoomId() {
        return roomId;
    }

    public String getName() {
        return name;
    }

    public String getDepartement() {
        return departement;
    }
}
