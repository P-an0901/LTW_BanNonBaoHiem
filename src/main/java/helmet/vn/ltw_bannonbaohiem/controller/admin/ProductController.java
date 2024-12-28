package helmet.vn.ltw_bannonbaohiem.controller.admin;

import helmet.vn.ltw_bannonbaohiem.dao.model.*;
import helmet.vn.ltw_bannonbaohiem.service.*;
//import helmet.vn.ltw_bannonbaohiem.service.CategoryService;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/product")
public class ProductController extends HttpServlet {
    private BrandService brandService = new BrandService();
    private CategoryService categoryService = new CategoryService();
    private ProductService productService = new ProductService();
    private ProductVariantService productVariantService = new ProductVariantService();
    private SizeService sizeService = new SizeService();


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User u = (User) session.getAttribute("auth");

        if (u == null || u.getRole() < 1) {
            resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }
        req.setAttribute("activeTab", "product");
        String activeSubTab = req.getParameter("subTab");
        System.out.println(activeSubTab);
        if (activeSubTab == null) {
            activeSubTab = "product-list";
        }
        session.setAttribute("activeSubTab", activeSubTab);
        req.setAttribute("activeSubTab", session.getAttribute("activeSubTab"));
        List<Brand> brands = brandService.getAllBrands();
        List<Product> products = productService.getAllPro();
        List<Category> categories = categoryService.getAllCate();
        List<ProductVariant> proVariants = productVariantService.getAllVariantsForAdmin();
        List<Sizes> sizes = sizeService.getAllSize();
        List<ProductSize> productSizes = productVariantService.getListProSize();
        System.out.println(productSizes);

        req.setAttribute("sizes", sizes);
        req.setAttribute("productSizes", productSizes);
        req.setAttribute("proVariants", proVariants);
        req.setAttribute("categories", categories);
        req.setAttribute("brands", brands);
        req.setAttribute("products", products);
        System.out.println("ssss");
        RequestDispatcher dispatcher = req.getRequestDispatcher("/admin.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }

}
