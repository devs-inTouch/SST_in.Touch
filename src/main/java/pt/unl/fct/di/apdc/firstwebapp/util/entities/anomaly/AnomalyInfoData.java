package pt.unl.fct.di.apdc.firstwebapp.util.entities.anomaly;

import pt.unl.fct.di.apdc.firstwebapp.util.entities.TokenData;

public class AnomalyInfoData {

    private String username, type, description;

    public AnomalyInfoData() {
    }


    public AnomalyInfoData(String sub, String title, String description) {
        this.username = sub;
        this.type = title;
        this.description = description;
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
