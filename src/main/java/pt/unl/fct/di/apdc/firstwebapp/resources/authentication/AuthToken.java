package pt.unl.fct.di.apdc.firstwebapp.resources.authentication;

import java.util.Date;

import io.jsonwebtoken.Jwts;

public class AuthToken {

	private static final long TTL = 60*60*2; //2h in seconds
	
	private String username;
	private Date creationDate;
	private Date expirationDate;

    private String encodedToken;
	

	public AuthToken() {}
	
	public AuthToken(String username) {
		
		this.username = username;
		this.creationDate = new Date();
		this.expirationDate = new Date(this.creationDate.getTime() + TTL);

		this.encodedToken = Jwts.builder()
                        .setSubject(username)
                        .setIssuedAt(creationDate)
                        .setExpiration(expirationDate)
                        .signWith(SecretManager.getInstance().getSignature())
                        .compact();
	}

	/**
	 * @return the username
	 */
	public String getUsername() {
		return username;
	}

	/**
	 * @return the creationDate
	 */
	public long getCreationDate() {
		return creationDate.getTime();
	}

	/**
	 * @return the expirationDate
	 */
	public long getExpirationDate() {
		return expirationDate.getTime();
	}

	/**
	 * @return the encodedToken
	 */
	public String getEncodedToken() {
		return encodedToken;
	}

}
