package pt.unl.fct.di.apdc.firstwebapp.util.entities.anomaly;

public class AnomalyData {

    private String title;
    private String description;

    public AnomalyData() {
    }

    public AnomalyData(String title, String description) {
        this.title = title;
        this.description = description;
    }


    public String getTitle() {
        return title;
    }

    public String getDescription() {
        return description;
    }
}
