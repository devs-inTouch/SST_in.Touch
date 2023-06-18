package pt.unl.fct.di.apdc.firstwebapp.util.entities.anomaly;

public class AnomalyDeleteData {

    public String username, creator, anomalyId;

    public AnomalyDeleteData() {
    }

    public AnomalyDeleteData(String username,String creator, String anomalyId) {
        this.username = username;
        this.creator = creator;
        this.anomalyId = anomalyId;
    }
}
