package pt.unl.fct.di.apdc.firstwebapp.util.enums;

import io.jsonwebtoken.SignatureAlgorithm;

public class Globals {

    public static final String AUTH = "Authorization";
	
	public static final String SIGNATURE_ALGORYTHM = SignatureAlgorithm.HS256.getJcaName();

    public static final int N_ENDPOINTS = 100; //TODO update this

    public static final int N_ROLES = 5; //TODO update this
}
