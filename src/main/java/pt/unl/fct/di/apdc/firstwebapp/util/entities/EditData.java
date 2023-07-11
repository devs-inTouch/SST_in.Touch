package pt.unl.fct.di.apdc.firstwebapp.util.entities;

public class EditData {

    private String password, description;

    public EditData() {

    }
    public EditData( String password, String description) {

        this.password = password;
        this.description=description;

    }

    public String getPassword() {
        return password;
    }

    public String getDescription() {
        return description;
    }



}
