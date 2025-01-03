package helmet.vn.ltw_bannonbaohiem.controller;

import helmet.vn.ltw_bannonbaohiem.dao.ProductSizeDao;
import helmet.vn.ltw_bannonbaohiem.dao.model.Product;
import helmet.vn.ltw_bannonbaohiem.dao.model.ProductSize;
import helmet.vn.ltw_bannonbaohiem.dao.model.ProductVariant;
import helmet.vn.ltw_bannonbaohiem.dao.model.Sizes;
import helmet.vn.ltw_bannonbaohiem.service.ProductService;
import helmet.vn.ltw_bannonbaohiem.service.ProductVariantService;
import helmet.vn.ltw_bannonbaohiem.service.SizeService;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "danhmuc", value ="/danhmuc")
public class DanhmucServlet extends HttpServlet {
    //    private static CategoryService categoryService = new CategoryService();
    private ProductService productService = new ProductService();
    private ProductSizeDao proSizeD = new ProductSizeDao();
    private ProductVariantService productVariantService = new ProductVariantService();
    private SizeService sizeService = new SizeService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("activePage", "danhmuc");
        String categoryId = req.getParameter("category");
        String pageParam = req.getParameter("page");
        int page = pageParam == null ? 1 : Integer.parseInt(pageParam);
        int pageSize = 4;
        int offset = (page - 1) * pageSize;
        System.out.println(offset);
        int totalVariants = 0;
        List<Product> products = new ArrayList<>();
        List<ProductVariant> proVariants = new ArrayList<>();
        if (categoryId != null) {
            if(categoryId.equalsIgnoreCase("all")) categoryId = "-1";
            proVariants = productVariantService.getProVariantsByCategoryIdWithPagination(Integer.parseInt(categoryId), offset, pageSize);
            totalVariants = productVariantService.getTotalVariantCount(Integer.parseInt(categoryId));
        }
        int totalPages = (int) Math.ceil((double) totalVariants  / pageSize);

        System.out.println(totalPages);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("currentPage", page);
        List<Sizes> sizes = sizeService.getAllSize();
        req.setAttribute("sizes", sizes);
        req.setAttribute("proVariants", proVariants);
        System.out.println(proVariants);
        req.setAttribute("products", products);
        RequestDispatcher dispatcher = req.getRequestDispatcher("/danhmuc.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }
}

