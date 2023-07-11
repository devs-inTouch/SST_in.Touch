package pt.unl.fct.di.apdc.firstwebapp.util.entities;

public class SenhasData {

    private String code, numero;

    public SenhasData() {}



    public SenhasData(String code, String numero) {
        this.code=code;
        this.numero = numero;
    }

    public String getCode() {
        return code;
    }

    public String getNumero() {
        return numero;
    }
}
