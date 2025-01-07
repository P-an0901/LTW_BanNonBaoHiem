package helmet.vn.ltw_bannonbaohiem.controller;

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
import java.util.ArrayList;
import java.util.List;

@WebServlet("/account")
public class AccountController extends HttpServlet {
    private OrderService orserService = new OrderService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User u = (User) session.getAttribute("auth");
        List<Order> currentOrders = new ArrayList<>();
        List<Order> orderHistory = new ArrayList<>();
        List<Order> cancelOrders = new ArrayList<>();
        for (Order order : orserService.getAllList()) {
            if ("Đã giao".equals(order.getStatus())) {
                orderHistory.add(order);
            } else if("Đã hủy".equals(order.getStatus())){
                cancelOrders.add(order);
            }else{
                currentOrders.add(order);
            }
        }
        if (u == null) {
            resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
            resp.sendRedirect(req.getContextPath() + "/");
        }else {
            req.setAttribute("currentOrders", currentOrders);
            req.setAttribute("orderHistory", orderHistory);
            RequestDispatcher dispatcher = req.getRequestDispatcher("/taikhoan.jsp");
            dispatcher.forward(req, resp);
        }
    }
}
