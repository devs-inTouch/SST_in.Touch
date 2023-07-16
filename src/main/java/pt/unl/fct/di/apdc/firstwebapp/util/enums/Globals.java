package pt.unl.fct.di.apdc.firstwebapp.util.enums;

import io.jsonwebtoken.SignatureAlgorithm;

public class Globals {

    public static final String DEFAULT_FORMAT = ";charset=utf-8";

    public static final String AUTH = "Authorization";
	
	public static final String SIGNATURE_ALGORYTHM = SignatureAlgorithm.HS256.getJcaName();

    public static final int N_ENDPOINTS = Operation.values().length;

    public static final int N_ROLES = UserRole.values().length;

    public static final String COUNT = "count";

    public static final String ACCESS_FORMAT = "%s-%s";

    public static final String PERMISSION_FORMAT = "%s-%s-%s";

    public static final String ENTITY_KEY = "__key__";
}
