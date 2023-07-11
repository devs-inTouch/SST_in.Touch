package pt.unl.fct.di.apdc.firstwebapp.util.entities.anomaly;

public class AnomalyInfoData {

    private String id, username, type, description;

    public AnomalyInfoData() {
    }


    public AnomalyInfoData(String id, String sub, String title, String description) {
        this.id = id;
        this.username = sub;
        this.type = title;
        this.description = description;
    }

    public String getId() {
        return id;
    }

    public String getUsername() {
        return username;
    }

    public String getType() {
        return type;
    }

    public String getDescription() {
        return description;
    }
}
