package pt.unl.fct.di.apdc.firstwebapp.util.entities.anomaly;

public class AnomalyData {

    public String username;
    public String title;
        public String description;

    public AnomalyData() {
    }

    public AnomalyData(String username, String title, String description) {
        this.username = username;
        this.title = title;
        this.description = description;
    }
}
