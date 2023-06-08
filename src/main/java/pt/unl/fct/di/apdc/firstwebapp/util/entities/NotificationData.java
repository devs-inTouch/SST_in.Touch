package pt.unl.fct.di.apdc.firstwebapp.util.entities;

public class NotificationData {

    public String notificationId;
    public String message;
    public long creationDate;
    public String sender;
    public String receiver;
    public String type;

    public NotificationData() {
    }

    public NotificationData(String notificationId, String message, String sender, String receiver, String type) {
        this.notificationId = notificationId;
        this.message = message;
        this.creationDate = System.currentTimeMillis();
        this.sender = sender;
        this.receiver = receiver;
        this.type = type;
    }

    public NotificationData(String notificationId, String sender, String receiver, String type) {
        this.notificationId = notificationId;
        this.creationDate = System.currentTimeMillis();
        this.sender = sender;
        this.receiver = receiver;
        this.type = type;
    }


}
