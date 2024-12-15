package helmet.vn.ltw_bannonbaohiem.controller.admin;

import helmet.vn.ltw_bannonbaohiem.dao.model.Brand;
import helmet.vn.ltw_bannonbaohiem.dao.model.Product;
import helmet.vn.ltw_bannonbaohiem.service.BrandService;
//import helmet.vn.ltw_bannonbaohiem.service.CategoryService;
import helmet.vn.ltw_bannonbaohiem.service.ProductService;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/product")
public class ProductController extends HttpServlet {
    private BrandService brandService = new BrandService();
//    private static CategoryService categoryService = new CategoryService();
    private ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("activeTab", "product");
        List<Brand> brands = brandService.getAllBrands();
        List<Product> products = productService.getAllPro();
        req.setAttribute("brands", brands);
        req.setAttribute("products", products);
        System.out.println("bbbbb");
        RequestDispatcher dispatcher = req.getRequestDispatcher("/admin.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("activeTab", "product");
        String brandName = req.getParameter("brandName");
        String brandImage = req.getParameter("brandImage");
        System.out.println(brandName);

        // Validate the input
        if (brandName != null && !brandName.isEmpty()) {
            brandService.addBrand(brandName, brandImage);
            resp.sendRedirect(req.getContextPath() + "/admin/product");

        } else {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Tên thương hiệu không hợp lệ");
        }
    }

}
