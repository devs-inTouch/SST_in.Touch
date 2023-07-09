package pt.unl.fct.di.apdc.firstwebapp.util.entities.clientObjects;

public class StatsData {

    private long onlineUsers;
    private long postsDone;
    private long unhandledReports;
    private long unactivatedAccounts;
    private long unhandledReservations;
    private long unhandledAnomalies;
    

    public StatsData() {}

    public StatsData(long onlineUsers, long postsDone, long unhandledReports, long unactivatedAccounts,
            long unhandledReservations, long unhandledAnomalies) {
        this.onlineUsers = onlineUsers;
        this.postsDone = postsDone;
        this.unhandledReports = unhandledReports;
        this.unactivatedAccounts = unactivatedAccounts;
        this.unhandledReservations = unhandledReservations;
        this.unhandledAnomalies = unhandledAnomalies;
    }

    /**
     * @return the onlineUsers
     */
    public long getOnlineUsers() {
        return onlineUsers;
    }

    /**
     * @return the postsDone
     */
    public long getPostsDone() {
        return postsDone;
    }

    /**
     * @return the unhandledReports
     */
    public long getUnhandledReports() {
        return unhandledReports;
    }

    /**
     * @return the unactivatedAccounts
     */
    public long getUnactivatedAccounts() {
        return unactivatedAccounts;
    }

    /**
     * @return the unhandledReservations
     */
    public long getUnhandledReservations() {
        return unhandledReservations;
    }

    /**
     * @return the unhandledAnomalies
     */
    public long getUnhandledAnomalies() {
        return unhandledAnomalies;
    }
    
}
