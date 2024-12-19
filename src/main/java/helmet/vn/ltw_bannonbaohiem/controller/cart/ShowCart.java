package helmet.vn.ltw_bannonbaohiem.controller.cart;

import helmet.vn.ltw_bannonbaohiem.dao.cart.Cart;
import helmet.vn.ltw_bannonbaohiem.dao.cart.CartProduct;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/cart")
public class ShowCart extends HttpServlet {
    private Cart carts = new Cart();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();

        Cart cart = (Cart) session.getAttribute("cart");

        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        List<CartProduct> list = cart.show();

        req.setAttribute("cartItems", list);
        System.out.println(list);
        RequestDispatcher dispatcher = req.getRequestDispatcher("/giohang.jsp");
        dispatcher.forward(req, resp);
    }
}
