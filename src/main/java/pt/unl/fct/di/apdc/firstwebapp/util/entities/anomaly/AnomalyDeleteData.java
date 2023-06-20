package pt.unl.fct.di.apdc.firstwebapp.util.entities.anomaly;

public class AnomalyDeleteData {

    private String creator, anomalyId;

    public AnomalyDeleteData() {
    }

    public AnomalyDeleteData(String creator, String anomalyId) {
        this.creator = creator;
        this.anomalyId = anomalyId;
    }

    public String getCreator() {
        return creator;
    }

    public String getAnomalyId() {
        return anomalyId;
    }
}
