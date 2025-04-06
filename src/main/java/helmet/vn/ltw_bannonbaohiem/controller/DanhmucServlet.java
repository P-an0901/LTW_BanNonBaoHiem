package helmet.vn.ltw_bannonbaohiem.controller;

import helmet.vn.ltw_bannonbaohiem.controller.Filter.DanhMucFilter;
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
    private ProductVariantService productVariantService = new ProductVariantService();
    private SizeService sizeService = new SizeService();
    private DanhMucFilter danhMucFilter = new DanhMucFilter();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("activePage", "danhmuc");

        int categoryId = parseCategoryId(req.getParameter("category"));
        int brand = parseBrand(req.getParameter("brand"));
        String price = parsePrice(req.getParameter("price"));
        String filterType = parseFilterType(req.getParameter("filter_type"));
        String[] sizes = req.getParameterValues("sizes") == null ? new String[0] : req.getParameterValues("sizes");
        String[] colors = req.getParameterValues("colors") == null ? new String[0] : req.getParameterValues("colors");

        int page = parsePageParam(req.getParameter("page"));
        int pageSize = 20;
        int offset = (page - 1) * pageSize;

        List<ProductVariant> proVariants = productVariantService.getProVariantsWithPagination(
                categoryId, brand, colors, price, sizes, filterType, offset, pageSize
        );
        int totalVariants = productVariantService.getTotalVariantCount(categoryId, brand, colors,
                price, sizes, filterType);

        int totalPages = calculateTotalPages(totalVariants, pageSize);

        req.setAttribute("totalPages", totalPages);
        req.setAttribute("currentPage", page);
        req.setAttribute("proVariants", proVariants);
        req.setAttribute("sizes", sizeService.getAllSize());
        req.setAttribute("colorMap", danhMucFilter.getColorMap());
        req.setAttribute("priceMap", danhMucFilter.getPriceMap());
        req.setAttribute("filterMap", danhMucFilter.getFilterMap());

        RequestDispatcher dispatcher = req.getRequestDispatcher("/danhmuc.jsp");
        dispatcher.forward(req, resp);
    }
    private int parsePageParam(String pageParam) {
        return pageParam == null || pageParam.isEmpty() ? 1 : Integer.parseInt(pageParam);
    }

    private int parseCategoryId(String categoryId) {
        return (categoryId == null || categoryId.isEmpty() || categoryId.equals("all")) ? -1 : Integer.parseInt(categoryId);
    }

    private int parseBrand(String brand) {
        return (brand == null || brand.isEmpty() || brand.equals("all")) ? -1 : Integer.parseInt(brand);
    }

    private String parsePrice(String price) {
        return (price == null || price.isEmpty() || price.equals("all")) ? "all" : price;
    }

    private String parseFilterType(String filterType) {
        return (filterType == null || filterType.isEmpty() || filterType.equals("all")) ? "all" : filterType;
    }
    private int calculateTotalPages(int totalVariants, int pageSize) {
        return (int) Math.ceil((double) totalVariants / pageSize);
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }
}

