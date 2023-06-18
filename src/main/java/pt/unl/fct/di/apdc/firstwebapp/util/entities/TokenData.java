package pt.unl.fct.di.apdc.firstwebapp.util.entities;

import java.util.Date;

public class TokenData {

	private String username;
    private boolean isExpired;
	
	public TokenData() {}

    public TokenData(String username, long creationDate, long expirationDate) {
        this.username = username;
        this.isExpired = new Date().getTime() >= expirationDate;
    }

    /**
     * @return the username
     */
    public String getUsername() {
        return username;
    }

    /**
     * @return the isExpired
     */
    public boolean isExpired() {
        return isExpired;
    }

}
