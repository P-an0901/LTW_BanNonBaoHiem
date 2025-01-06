package helmet.vn.ltw_bannonbaohiem.controller;

import helmet.vn.ltw_bannonbaohiem.dao.cart.Cart;
import helmet.vn.ltw_bannonbaohiem.dao.model.Order;
import helmet.vn.ltw_bannonbaohiem.dao.model.PaymentMethod;
import helmet.vn.ltw_bannonbaohiem.dao.model.User;
import helmet.vn.ltw_bannonbaohiem.service.OrderService;
import helmet.vn.ltw_bannonbaohiem.service.PaymentMethodService;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/thanh-toan")
public class Checkout extends HttpServlet {
    private OrderService orderService = new OrderService();
    private PaymentMethodService payService = new PaymentMethodService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<PaymentMethod> payList = payService.getListPaymentMethod();
        HttpSession session = req.getSession();
        User u = (User) session.getAttribute("auth");
        Cart cart = (Cart) session.getAttribute("cart");

        req.setAttribute("payList", payList);
        RequestDispatcher dispatcher = req.getRequestDispatcher("/checkout.jsp");
        dispatcher.forward(req, resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User u = (User) session.getAttribute("auth");
        Cart cart = (Cart) session.getAttribute("cart");
        String recipientName = req.getParameter("recipientName");
        String address = req.getParameter("address");
        String methodPayment = req.getParameter("paymentMethodId");
        String phone = req.getParameter("phone");
        String note = req.getParameter("note");

        boolean order = orderService.add(u.getId(), cart, recipientName, address, Integer.parseInt(methodPayment), phone);
        if (order == true) {
            session.removeAttribute("cart");
            resp.sendRedirect(req.getContextPath() + "/account");
        } else {
            resp.sendRedirect(req.getContextPath() + "/thanh-toan");
        }

    }
}
