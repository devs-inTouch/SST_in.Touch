package pt.unl.fct.di.apdc.firstwebapp.resources.authentication;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import com.google.common.collect.ImmutableMap;

import static pt.unl.fct.di.apdc.firstwebapp.util.enums.TokenAttributes.*;

import io.jsonwebtoken.Jwts;

public class AuthToken {

	private static final long TTL = 1000*2*60; //2min in milliseconds

	private static final int N_CLAIMS = 4;
	
	private String username;
	private String id;
	private Date creationTime;
	private Date expirationTime;

    private String encodedToken;
	

	public AuthToken() {}
	
	public AuthToken(String username) {
		
		this.username = username;
		this.id = UUID.randomUUID().toString();
		this.creationTime = new Date();
		this.expirationTime = new Date(this.creationTime.getTime() + TTL);

		Map<String, Object> claims = new HashMap<>(N_CLAIMS);
		claims.put(USERNAME.value, this.username);
		claims.put(ID.value, this.id);
		claims.put(CREATION_TIME.value, this.creationTime);
		claims.put(EXPIRATION_TIME.value, expirationTime);

		ImmutableMap<String, Object> iClaims = ImmutableMap.copyOf(claims);


		this.encodedToken = Jwts.builder()
                        .setClaims(iClaims)
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
	 * @return the id
	 */
	public String getId() {
		return id;
	}

	/**
	 * @return the creationDate
	 */
	public long getCreationTime() {
		return creationTime.getTime();
	}

	/**
	 * @return the expirationDate
	 */
	public long getExpirationTime() {
		return expirationTime.getTime();
	}

	/**
	 * @return the encodedToken
	 */
	public String getEncodedToken() {
		return encodedToken;
	}

}
