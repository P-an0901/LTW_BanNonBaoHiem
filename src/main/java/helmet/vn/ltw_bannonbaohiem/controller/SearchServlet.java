package helmet.vn.ltw_bannonbaohiem.controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import helmet.vn.ltw_bannonbaohiem.controller.admin.LocalDateTimeAdapter;
import helmet.vn.ltw_bannonbaohiem.dao.model.ProductVariant;
import helmet.vn.ltw_bannonbaohiem.service.ProductVariantService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.logging.Handler;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {
    private ProductVariantService productVariantService = new ProductVariantService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String query = req.getParameter("q");
        List<ProductVariant> searchResult = productVariantService.searchVariant(query);
        Gson gson = new GsonBuilder()
                .registerTypeAdapter(LocalDateTime.class, new LocalDateTimeAdapter())
                .create();
//        req.setAttribute("searchResult", searchResult);
//        req.setAttribute("query", query);
//
//        req.getRequestDispatcher("/search-result.jsp").forward(req, resp);
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        gson.toJson(searchResult, resp.getWriter());
    }
}
