package helmet.vn.ltw_bannonbaohiem.controller.admin.productMange;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import helmet.vn.ltw_bannonbaohiem.controller.admin.LocalDateTimeAdapter;
import helmet.vn.ltw_bannonbaohiem.dao.model.*;
import helmet.vn.ltw_bannonbaohiem.service.BrandService;
import helmet.vn.ltw_bannonbaohiem.service.CategoryService;
import helmet.vn.ltw_bannonbaohiem.service.ProductService;
import helmet.vn.ltw_bannonbaohiem.service.ProductVariantService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;

@WebServlet("/show-tab-product")
@MultipartConfig
public class Show extends HttpServlet {
    private BrandService brandService = new BrandService();
    private CategoryService cateService = new CategoryService();
    private ProductService proService = new ProductService();
    private ProductVariantService productVariantService = new ProductVariantService();
    private Gson gson;
    private PrintWriter out;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("activeTab", "product");
        String action = req.getParameter("action");
        if (action == null) {
            System.out.println("action is null");
        }else {
            switch (action) {
                case "findBrand":
                    findBrand(req, resp);
                    break;
                case "findProduct":
                    findProduct(req, resp);
                    break;
                case "findSize":
                    findSize(req, resp);
                    break;
                case "findCate":
                    findCate(req, resp);
                    break;
                case "findProductVariant":
                    findProductVariant(req, resp);
                    break;
                case "findProductVariantSize":
                    findVariantSize(req, resp);
                    break;
                case "showProductTech":
                    showProductTech(req, resp);
                default:
                    resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action parameter");
            }
        }
    }

    private void showProductTech(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int proId = Integer.parseInt(req.getParameter("productId"));
        System.out.println(proId);
        ProductTechnicalDetail proTech = proService.getProductTeach(proId);
        System.out.println(proTech);
        resp.setContentType("application/json");
        PrintWriter out = resp.getWriter();
        gson = new Gson();
        out.print(gson.toJson(proTech));
        out.flush();
        out.close();
    }

    private void findCate(HttpServletRequest req, HttpServletResponse resp) {
    }

    private void findProductVariant(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int pvId = Integer.parseInt(req.getParameter("variantId"));
        ProductVariant pv = productVariantService.getProVariant(pvId);
        System.out.println(pv);
        resp.setContentType("application/json");
        out = resp.getWriter();
        gson = new GsonBuilder()
                .registerTypeAdapter(LocalDateTime.class, new LocalDateTimeAdapter())
                .create();

        out.print(gson.toJson(pv));
        out.flush();
        out.close();
    }

    private void findSize(HttpServletRequest req, HttpServletResponse resp) {
    }

    private void findProduct(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int pid = Integer.parseInt(req.getParameter("productId"));
        Product product = proService.getProById(pid);
        System.out.println(product);

        resp.setContentType("application/json");
        out = resp.getWriter();
        gson = new GsonBuilder()
                .registerTypeAdapter(LocalDateTime.class, new LocalDateTimeAdapter())
                .create();

        out.print(gson.toJson(product));
        out.flush();
        out.close();
    }

    private void findBrand(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int id = Integer.parseInt(req.getParameter("brandId"));
        Brand brand = brandService.getBrandById(id);
        System.out.println(brand);
        resp.setContentType("application/json");
        PrintWriter out = resp.getWriter();
        gson = new Gson();
        out.print(gson.toJson(brand));
        out.flush();
        out.close();
    }

    private void findVariantSize(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int proSizeId = Integer.parseInt(req.getParameter("proSizeId"));
        ProductSize ps = productVariantService.getById(proSizeId);
        System.out.println(ps);
        resp.setContentType("application/json");
        out = resp.getWriter();
        gson = new GsonBuilder()
                .registerTypeAdapter(LocalDateTime.class, new LocalDateTimeAdapter())
                .create();

        out.print(gson.toJson(ps));
        out.flush();
        out.close();
    }
}
