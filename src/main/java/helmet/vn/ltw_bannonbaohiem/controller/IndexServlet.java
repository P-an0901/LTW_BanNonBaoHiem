package helmet.vn.ltw_bannonbaohiem.controller;

import helmet.vn.ltw_bannonbaohiem.dao.ProductDao;
import helmet.vn.ltw_bannonbaohiem.dao.ProductSizeDao;
import helmet.vn.ltw_bannonbaohiem.dao.model.Brand;
import helmet.vn.ltw_bannonbaohiem.dao.model.Product;
import helmet.vn.ltw_bannonbaohiem.dao.model.ProductSize;
import helmet.vn.ltw_bannonbaohiem.dao.model.ProductVariant;
import helmet.vn.ltw_bannonbaohiem.service.BrandService;
import helmet.vn.ltw_bannonbaohiem.service.ProductService;
import helmet.vn.ltw_bannonbaohiem.service.ProductVariantService;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet (name = "/", value ="")
public class IndexServlet extends HttpServlet {
    //    private static CategoryService categoryService = new CategoryService();
    private ProductService productService = new ProductService();
    private ProductSizeDao proSizeD = new ProductSizeDao();
    private ProductVariantService productVariantService = new ProductVariantService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("activePage", "home");
        List<Product> products = productService.getAllPro();

        List<ProductVariant> limitedProducts = productVariantService.getLimitedNewProductVariants(5);
        req.setAttribute("proVariants", limitedProducts);
        System.out.println(limitedProducts);
        req.setAttribute("products", products);
        RequestDispatcher dispatcher = req.getRequestDispatcher("/index.jsp");
        dispatcher.forward(req, resp);
    }
}
