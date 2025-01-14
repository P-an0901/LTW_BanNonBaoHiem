package helmet.vn.ltw_bannonbaohiem.controller.admin;

import helmet.vn.ltw_bannonbaohiem.dao.model.Order;
import helmet.vn.ltw_bannonbaohiem.dao.model.Promotion;
import helmet.vn.ltw_bannonbaohiem.dao.model.User;
import helmet.vn.ltw_bannonbaohiem.service.PromotionService;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@WebServlet("/admin/promotion")
public class PromotionController extends HttpServlet {
    private PromotionService promotionService = new PromotionService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User u = (User) session.getAttribute("auth");

        if (u == null || u.getRole() < 1) {
            resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }
        req.setAttribute("activeTab", "promotion");
        List<Promotion> promotions = promotionService.listPromotions();
        System.out.println(promotions);
        req.setAttribute("promotions", promotions);
        RequestDispatcher dispatcher = req.getRequestDispatcher("/admin.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if(action != null && !action.isEmpty()){
            switch(action){
                case "addPromotion":
                    addPromotion(req, resp);
                    break;
                case "editPromotion":
                    break;
                default:

            }
        }

    }

    private void addPromotion(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String name = req.getParameter("name");
        String description = req.getParameter("description");
        double discountPercentage = Double.parseDouble(req.getParameter("discountPercentage"));
        String startDateStr = req.getParameter("startDate");
        String endDateStr = req.getParameter("endDate");
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");

        LocalDateTime startDate = LocalDateTime.parse(startDateStr, formatter);
        LocalDateTime endDate = LocalDateTime.parse(endDateStr, formatter);
        boolean bo = promotionService.addPromotion(name, description, discountPercentage, startDate, endDate);
        if(bo){
            resp.sendRedirect(req.getContextPath() + "/admin/promotion");
        }else{
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Lỗi");
        }
    }
}
