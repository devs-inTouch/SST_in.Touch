package pt.unl.fct.di.apdc.firstwebapp.resources;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import com.google.cloud.Timestamp;
import com.google.cloud.datastore.Entity;
import com.google.gson.Gson;

import org.apache.commons.codec.digest.DigestUtils;

import com.google.cloud.datastore.Datastore;
import com.google.cloud.datastore.DatastoreOptions;
import com.google.cloud.datastore.Key;
import pt.unl.fct.di.apdc.firstwebapp.util.RegisterData;

import java.util.logging.Logger;

@Path("/register")
public class RegisterResource {

	/**
	 * Logger Object
	 */
	private static final String STATE = "Inactive";
	private static final String ROLE = "USER";
	private final Datastore datastore = DatastoreOptions.getDefaultInstance().getService();
	private final Gson g = new Gson();
	public RegisterResource() {}

	@POST
	@Path("")
	@Consumes(MediaType.APPLICATION_JSON)
	public Response doRegister(RegisterData data){

		if (data.hasMandatoryInputs())
			return Response.status(Status.BAD_REQUEST).entity("Mandatory fields are empty").build();

		if(!data.validPwd() || !data.validEmail())
			return Response.status(Status.BAD_REQUEST).entity("Invalid Inputs").build();

		Key userKey = datastore.newKeyFactory().setKind("User").newKey(data.username);
		Entity user = datastore.get(userKey);
		if(user != null)
			return Response.status(Status.BAD_REQUEST).entity("User already exist").build();
		user = Entity.newBuilder(userKey)
				.set("state", STATE)
				.set("role", ROLE)
				.set("user_creation_time", System.currentTimeMillis())
				.set("email", data.email)
				.set("name", data.name)
				.set("password", DigestUtils.sha512Hex(data.pwd))
				.set("profile", data.profile)
				.set("cellPhone", data.cellPhone)
				.set("fixPhone", data.fixPhone)
				.set("occupation", data.occupation)
				.set("workplace", data.workplace)
				.set("address 1", data.address1)
				.set("address 2", data.address2)
				.set("city", data.city)
				.set("outCode", data.outCode)
				.set("inCode", data.inCode)
				.set("NIF", data.NIF)
				.build();
		datastore.put(user);

		return Response.status(Status.OK).build();

	}
}
