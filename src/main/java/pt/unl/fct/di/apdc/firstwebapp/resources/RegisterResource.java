package pt.unl.fct.di.apdc.firstwebapp.resources;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import com.google.cloud.Timestamp;
import com.google.cloud.datastore.*;
import com.google.gson.Gson;

import org.apache.commons.codec.digest.DigestUtils;

import pt.unl.fct.di.apdc.firstwebapp.util.RegisterData;

import java.util.logging.Logger;

@Path("/register")
public class RegisterResource {

	/**
	 * Logger Object
	 */
	private static final String STATE = "Inactive";
	private static final String ROLE = "Aluno";
	private static final String MANDATORY_FIELDS = "Tem de preencher os campos obrigatórios";
	private static final String INVALID_INPUTS = "Inputs inválidos";
	private static final String USER_ALREADY_EXISTS = "Utilizador já criado";

	private final Datastore datastore = DatastoreOptions.getDefaultInstance().getService();
	private final Gson g = new Gson();
	public RegisterResource() {}

	@POST
	@Path("")
	@Consumes(MediaType.APPLICATION_JSON)
	public Response doRegister(RegisterData data){
		//ATENCION: If added a new field here, remember to added in ProfileResource
		if (data.hasMandatoryInputs())
			return Response.status(Status.BAD_REQUEST).entity(MANDATORY_FIELDS).build();

		if(!data.validPwd() || !data.validEmail())
			return Response.status(Status.BAD_REQUEST).entity(INVALID_INPUTS).build();

		Key userKey = datastore.newKeyFactory().setKind("User").newKey(data.usernameClip);

		Transaction txn = datastore.newTransaction();
		try {
			Entity user = txn.get(userKey);
			if(user != null)
				return Response.status(Status.BAD_REQUEST).entity(USER_ALREADY_EXISTS).build();
			user = Entity.newBuilder(userKey)
					.set("state", STATE)
					.set("role", ROLE)
					.set("user_creation_time", System.currentTimeMillis())
					.set("email", data.email)
					.set("name", data.name)
					.set("password", DigestUtils.sha512Hex(data.pwd))
					.set("department", data.department)
					.set("Email verification", "no")
					.build();

			txn.add(user);
			txn.commit();
			return Response.status(Status.OK).entity("Utilizador registado").build();

		} finally {
			if (txn.isActive()) {
				txn.rollback();
			}
		}

	}
}
