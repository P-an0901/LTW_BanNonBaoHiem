package helmet.vn.ltw_bannonbaohiem.controller;

import helmet.vn.ltw_bannonbaohiem.controller.admin.ProductController;
import helmet.vn.ltw_bannonbaohiem.dao.model.Brand;
import helmet.vn.ltw_bannonbaohiem.dao.model.User;
import helmet.vn.ltw_bannonbaohiem.service.BrandService;
import helmet.vn.ltw_bannonbaohiem.service.OrderService;
import helmet.vn.ltw_bannonbaohiem.service.ProductVariantService;
import helmet.vn.ltw_bannonbaohiem.service.UserService;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "admin", value = "/admin/*")
public class AdminServlet extends HttpServlet {
    private OrderService orderService = new OrderService();
    private UserService userService = new UserService();
    private ProductVariantService productVariantService = new ProductVariantService();
    private void processRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User u = (User) session.getAttribute("auth");

        if (u == null || u.getRole() < 1) {
            resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }
        String tab = req.getPathInfo();
        if (tab == null || tab.equals("/")) {
            tab = "/home";
        }
        req.setAttribute("activeTab", tab.substring(1));
        RequestDispatcher dispatcher = req.getRequestDispatcher("/admin.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int countUser = userService.countCustomer();
        int countOrder = orderService.countOrder();
        double revenueMonth = orderService.revenueMonth();
        int countVariantSell = orderService.countVariantSell();
        req.setAttribute("countUser", countUser);
        req.setAttribute("countOrder", countOrder);
        req.setAttribute("revenueMonth", revenueMonth);
        req.setAttribute("countVariantSell", countVariantSell);
        processRequest(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        processRequest(req, resp);
    }
}
