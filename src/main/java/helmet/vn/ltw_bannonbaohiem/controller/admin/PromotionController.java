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
        super.doPost(req, resp);
    }
}
