package pt.unl.fct.di.apdc.firstwebapp.util.entities;

import java.util.Date;

public class TokenData {

	private String sub;
    private long iat;
    private long exp;

    private boolean isExpired;
	
	public TokenData() {}

    public TokenData(String sub, long iat, long exp) {
        this.sub = sub;
        this.iat = iat;
        this.exp = exp;
        
        this.isExpired = new Date().getTime() >= exp;
    }

    /**
     * @return the username
     */
    public String getSub() {
        return sub;
    }

    /**
     * @return the iat
     */
    public long getIat() {
        return iat;
    }

    /**
     * @return the exp
     */
    public long getExp() {
        return exp;
    }

    /**
     * @return the isExpired
     */
    public boolean isExpired() {
        return isExpired;
    }

}
