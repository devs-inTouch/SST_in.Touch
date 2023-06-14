package pt.unl.fct.di.apdc.firstwebapp.util.entities.notification;

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

    public NotificationData(String message, String sender, String receiver, String type) {
        this.message = message;
        this.sender = sender;
        this.receiver = receiver;
        this.type = type;
        this.creationDate = System.currentTimeMillis();
    }


    public void setCreationDate(long creation_date) {
        this.creationDate = creation_date;
    }
}
