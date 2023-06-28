package pt.unl.fct.di.apdc.firstwebapp.util.entities;

public class OperationData {
    
    private String operationID;

    public OperationData() {}

    public OperationData(String operationID) {
        this.operationID = operationID;
    }

    /**
     * @return the operationID
     */
    public String getOperationID() {
        return operationID;
    }
    
}
