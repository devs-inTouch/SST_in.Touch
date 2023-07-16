package pt.unl.fct.di.apdc.firstwebapp.util.entities.clientObjects.listing;

public class ListInfoData {
    
    private String cursor;


    public ListInfoData() {}

    public ListInfoData(String cursor) {
        this.cursor = cursor;
    }

    /**
     * @return the cursor
     */
    public String getCursor() {
        return cursor;
    }

}
