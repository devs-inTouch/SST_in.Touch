package pt.unl.fct.di.apdc.firstwebapp.resources;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.google.appengine.api.memcache.MemcacheService;
import com.google.appengine.api.memcache.MemcacheServiceFactory;

@WebServlet(name = "TesteServlet", value = "/teste")
public class TesteServlet extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        MemcacheService memcacheService = MemcacheServiceFactory.getMemcacheService();
        memcacheService.put("teste", "teste");
        String value = (String) memcacheService.get("teste");
        response.getWriter().println(value);
    }
}
