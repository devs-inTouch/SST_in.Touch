package pt.unl.fct.di.apdc.firstwebapp.util.entities.changePassword;

public class RecoverPasswordData {

        public String email, code;
        public RecoverPasswordData() {
        }

        public RecoverPasswordData(String email, String code) {
            this.email = email;
            this.code = code;
        }

        public String getEmail() {
            return email;
        }

        public String getCode() {
            return code;
        }
}
