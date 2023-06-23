package pt.unl.fct.di.apdc.firstwebapp.util.entities;

import java.util.Date;

public class TokenData {

	private String username;
    private String id;
    private long creationTime;
    private long expirationTime;

    private boolean isExpired;
	
	public TokenData() {}

    public TokenData(String username, String id, long creationTime, long expirationTime) {
        this.username = username;
        this.id = id;
        this.creationTime = creationTime;
        this.expirationTime = expirationTime;
    }

    /**
     * @return the username
     */
    public String getUsername() {
        return username;
    }

    /**
     * @return the id
     */
    public String getId() {
        return id;
    }

    /**
     * @return the iat
     */
    public long getCreationTime() {
        return creationTime;
    }

    /**
     * @return the exp
     */
    public long getExpirationTime() {
        return expirationTime;
    }

    /**
     * @return the isExpired
     */
    public boolean isExpired() {

        long now = new Date().getTime();

        isExpired = now >= expirationTime;

        return isExpired;
    }

}
