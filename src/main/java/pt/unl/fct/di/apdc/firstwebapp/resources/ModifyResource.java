package pt.unl.fct.di.apdc.firstwebapp.resources;

import static pt.unl.fct.di.apdc.firstwebapp.util.enums.Globals.AUTH;

import java.util.logging.Logger;

import javax.ws.rs.Consumes;
import javax.ws.rs.HeaderParam;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import com.google.cloud.datastore.*;

import com.google.gson.Gson;
import org.apache.commons.codec.digest.DigestUtils;
import pt.unl.fct.di.apdc.firstwebapp.util.TokenUtil;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.AttributeChangeData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.changePassword.ChangePasswordData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.changePassword.PasswordCodeData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.changePassword.RecoverPasswordData;
import pt.unl.fct.di.apdc.firstwebapp.util.entities.TokenData;
import pt.unl.fct.di.apdc.firstwebapp.util.enums.DatastoreEntities;
import pt.unl.fct.di.apdc.firstwebapp.util.enums.UserAttributes;

@Path("/modify")
public class ModifyResource {

    private final Datastore datastore = DatastoreOptions.getDefaultInstance().getService();
	private static final Logger LOG = Logger.getLogger(ModifyResource.class.getName());

    private final KeyFactory userKeyFactory = datastore.newKeyFactory().setKind(DatastoreEntities.USER.value);
    private final Gson g = new Gson();

    private static final String KIND = "User";

    public ModifyResource() {}


    @POST
    @Path("generatePassCode")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response recoverPassword(RecoverPasswordData data){
        Query<Entity> query = Query.newEntityQueryBuilder()
                .setKind(KIND)
                .setFilter(StructuredQuery.PropertyFilter.eq("user_email", data.getEmail()))
                .build();
        QueryResults<Entity> result = datastore.run(query);
        Transaction txn = datastore.newTransaction();
        try{
            if(result.hasNext()) {
                Entity user = result.next();
                String id = user.getKey().getName();
                user = Entity.newBuilder(user)
                        .set("code_password", data.getCode())
                        .build();
                txn.update(user);
                txn.commit();
                return Response.status(Status.OK).entity(g.toJson(id)).build();
            }
            return Response.status(Status.NOT_FOUND).entity("utilizador não esta registado na base de dados").build();
        }finally{
            if(txn.isActive())
                txn.rollback();
        }
    }

    @POST
    @Path("checkPassCode")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response changePassWord(PasswordCodeData data) {

        Key userKey = userKeyFactory.newKey(data.getUserId());
        Entity user = datastore.get(userKey);

        if(user == null)
            return Response.status(Status.NOT_FOUND).entity("utilizador não esta registado na base de dados").build();

        String userCode = user.getString("code_password");


        if(!userCode.equals(data.getCode()))
            return Response.status(Status.FORBIDDEN).entity("Código de recuperação errado").build();

        return Response.status(Status.OK).entity(g.toJson(data.getUserId())).build();

    }

    @POST
    @Path("changePassword")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response changePassWord(ChangePasswordData data) {

        Key userKey = userKeyFactory.newKey(data.getUserId());
        Entity user = datastore.get(userKey);

        if (user == null)
            return Response.status(Status.NOT_FOUND).entity("utilizador não esta registado na base de dados").build();
        Transaction txn = datastore.newTransaction();
        try{
            user = Entity.newBuilder(user)
                    .set("user_password", DigestUtils.sha512Hex(data.getNewPassword()))
                    .remove("code_password")
                    .build();
            txn.update(user);
            txn.commit();
            return Response.status(Status.OK).entity("Password alterada com sucesso").build();
        }catch (Exception e){
            return Response.status(Status.INTERNAL_SERVER_ERROR).entity("Erro ao alterar a password").build();
        }finally {
            if(txn.isActive())
                txn.rollback();
        }
    }

    @POST
    @Path("/")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response modifyUser(@HeaderParam(AUTH) String auth, AttributeChangeData data){

        TokenData givenTokenData = TokenUtil.validateToken(LOG, auth);

        if(givenTokenData == null)
            return Response.status(Status.FORBIDDEN).build();


        Key managerKey = datastore.newKeyFactory().setKind("User").newKey(givenTokenData.getUsername());
        Entity manager = datastore.get(managerKey);

        Key targetKey = datastore.newKeyFactory().setKind("User").newKey(data.getTargetUsername());
        Entity target = datastore.get(targetKey);

        if(target == null)
            return Response.status(Status.FORBIDDEN).entity("User not in database").build();

        String managerRole = manager.getString(UserAttributes.ROLE.value);
        String targetRole = target.getString(UserAttributes.ROLE.value);

    //    switch (userRole){
    //         case SU:
    //             if(userModRole.equals(SU))
    //                 return Response.status(Status.FORBIDDEN).entity("Not enough permissions!").build();
    //             modifyAllUser(data, targetKey, target);
    //             return Response.status(Status.OK).entity("User updated").build();
    //         case GS:
    //             if (userModRole.equals(SU) || userModRole.equals(GS))
    //                 return Response.status(Status.FORBIDDEN).entity("Not enough permissions!").build();
    //             modifyAllUser(data, targetKey, target);
    //             return Response.status(Status.OK).entity("User updated").build();
    //         case GBO:
    //             if(!userModRole.equals(USER))
    //                 return Response.status(Status.FORBIDDEN).entity("Not enough permissions!").build();
    //             modifyAllUser(data, targetKey, target);
    //             return Response.status(Status.OK).entity("User updated").build();
    //         case USER:
    //             if(!data.username.equals(data.modUsername))
    //                 return Response.status(Status.FORBIDDEN).entity("Not enough permissions!").build();
    //             modifyUser(data, targetKey, target);
    //             return Response.status(Status.OK).entity("User updated").build();
    //     }
        return Response.status(Status.OK).entity("NAO CHEGA AQUII").build();

    }

/*
    private void modifyUser(ModifyData data, Key kUserMod, Entity userMod){
        Entity newUser = Entity.newBuilder(kUserMod)
                .set("state", userMod.getString("state"))
                .set("role", userMod.getString("role"))
                .set("user_creation_time", userMod.getLong("user_creation_time"))
                .set("email", userMod.getString("email"))
                .set("name", userMod.getString("name"))
                .set("password", DigestUtils.sha512Hex(data.password))
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
        datastore.put(newUser);
    }

    private void modifyAllUser(ModifyData data, Key kUserMod, Entity userMod) {
        Entity newUser = Entity.newBuilder(kUserMod)
                .set("state", data.state)
                .set("role", data.role)
                .set("user_creation_time", userMod.getLong("user_creation_time"))
                .set("email", data.email)
                .set("name", data.name)
                .set("password", DigestUtils.sha512Hex(data.password))
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
        datastore.put(newUser);
    }
*/

}
