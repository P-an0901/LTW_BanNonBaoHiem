package helmet.vn.ltw_bannonbaohiem.controller.cart;

import helmet.vn.ltw_bannonbaohiem.dao.ProductSizeDao;
import helmet.vn.ltw_bannonbaohiem.dao.cart.Cart;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/delete-cart")
public class DeleteCart extends HttpServlet{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int cid = Integer.parseInt(req.getParameter("cid"));
        int size = Integer.parseInt(req.getParameter("size"));
        System.out.println(size);
        HttpSession session = req.getSession(true);
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart != null) {
            cart.delete(cid, size);
            System.out.println(cart);
            session.setAttribute("cart", cart);
        }
        resp.sendRedirect(req.getContextPath() + "/cart");
    }
}
