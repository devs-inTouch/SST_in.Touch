package pt.unl.fct.di.apdc.firstwebapp.util.entities.nucleos;

public class DeleteNucleoData {

    private String nucleoId;

    public DeleteNucleoData() {
    }

    public DeleteNucleoData(String nucleoId) {
        this.nucleoId = nucleoId;
    }

    public String getNucleoId() {
        return nucleoId;
    }
}
