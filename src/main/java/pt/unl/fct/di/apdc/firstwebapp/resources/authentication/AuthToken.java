package pt.unl.fct.di.apdc.firstwebapp.resources.authentication;

import java.util.UUID;

import com.google.cloud.Timestamp;

public class AuthToken {
	
	public static final long TTL = 60*60*2; //2h in seconds
	
	private String username;
	private String tokenID;
	private long creationDate;
	private long expirationDate;
	

	public AuthToken() {}
	
	public AuthToken(String username, String verification) {
		
		this.username = username;
		this.tokenID = UUID.randomUUID().toString();
		this.creationDate = Timestamp.now().getSeconds();
		this.expirationDate = this.creationDate + TTL;
		
	}

	public String getUsername() {
		return username;
	}

	public String getTokenID() {
		return tokenID;
	}

	/**
	 * @return the creationDate
	 */
	public long getCreationDate() {
		return creationDate;
	}

	/**
	 * @return the expirationDate
	 */
	public long getExpirationDate() {
		return expirationDate;
	}

}
