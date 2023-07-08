package pt.unl.fct.di.apdc.firstwebapp.util.entities;

public class RecoverPasswordData {

        public String email;
        public RecoverPasswordData() {
        }

        public RecoverPasswordData(String email, String token, String password, String confirmation) {
            this.email = email;
        }

        public String getEmail() {
            return email;
        }
}
