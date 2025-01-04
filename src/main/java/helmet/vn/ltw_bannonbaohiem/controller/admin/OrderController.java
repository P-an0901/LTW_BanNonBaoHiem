package helmet.vn.ltw_bannonbaohiem.controller.admin;

import helmet.vn.ltw_bannonbaohiem.dao.model.Order;
import helmet.vn.ltw_bannonbaohiem.dao.model.User;
import helmet.vn.ltw_bannonbaohiem.service.OrderService;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/order")
public class OrderController extends HttpServlet {
    private OrderService orderService = new OrderService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User u = (User) session.getAttribute("auth");

        if (u == null || u.getRole() < 1) {
            resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }
        req.setAttribute("activeTab", "order");
        List<Order> orders = orderService.getAllList();
        req.setAttribute("orders", orders);
        RequestDispatcher dispatcher = req.getRequestDispatcher("/admin.jsp");
        dispatcher.forward(req, resp);
    }
}
