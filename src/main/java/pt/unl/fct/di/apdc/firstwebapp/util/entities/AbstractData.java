package pt.unl.fct.di.apdc.firstwebapp.util.entities;

public abstract class AbstractData {
    
    private TokenData token;

    public AbstractData() {

    }

    /**
     * @param token
     */
    public AbstractData(TokenData token) {
        this.token = token;
    }

    /**
     * @return the token
     */
    public TokenData getToken() {
        return token;
    }

}
