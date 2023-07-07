package pt.unl.fct.di.apdc.firstwebapp.util.entities.anomaly;

public class ApproveAnomalyData {

    private String anomalyId;

    public ApproveAnomalyData() {
    }

    public ApproveAnomalyData(String anomalyId) {
        this.anomalyId = anomalyId;
    }

    public String getAnomalyId() {
        return anomalyId;
    }
}
