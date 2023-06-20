package pt.unl.fct.di.apdc.firstwebapp.util.entities.clientObjects;

public class ClientTokenData {
    
    private String token;

    public ClientTokenData() {}

    public ClientTokenData(String encodedToken) {
        this.token = encodedToken;
    }

    public String getToken() {
        return this.token;
    }

}
