package helmet.vn.ltw_bannonbaohiem.controller;

import helmet.vn.ltw_bannonbaohiem.dao.model.ProductVariant;
import helmet.vn.ltw_bannonbaohiem.service.ProductVariantService;
import helmet.vn.ltw_bannonbaohiem.service.PromotionService;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "khuyenmai", value ="/khuyenmai")
public class PromotionServlet extends HttpServlet{
    private ProductVariantService productVariantService = new ProductVariantService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("activePage", "khuyenmai");
        int page = parsePageParam(req.getParameter("page"));
        int pageSize = 20;
        int offset = (page - 1) * pageSize;
        List<ProductVariant> listVariantSale = productVariantService.getProVariantSalesWithPagination(offset, pageSize);

        int totalVariants = productVariantService.getTotalVariantSaleCount();

        int totalPages = calculateTotalPages(totalVariants, pageSize);

        req.setAttribute("totalPages", totalPages);
        req.setAttribute("currentPage", page);
        req.setAttribute("listVariantSale", listVariantSale);
        RequestDispatcher dispatcher = req.getRequestDispatcher("/khuyenmai.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }
    private int parsePageParam(String pageParam) {
        return pageParam == null || pageParam.isEmpty() ? 1 : Integer.parseInt(pageParam);
    }
    private int calculateTotalPages(int totalVariants, int pageSize) {
        return (int) Math.ceil((double) totalVariants / pageSize);
    }
}
