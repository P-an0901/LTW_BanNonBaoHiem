package helmet.vn.ltw_bannonbaohiem.controller.cart;

import helmet.vn.ltw_bannonbaohiem.dao.cart.Cart;
import helmet.vn.ltw_bannonbaohiem.dao.model.ProductVariant;
import helmet.vn.ltw_bannonbaohiem.service.ProductVariantService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/add-cart")
public class AddCart extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int productId = Integer.parseInt(req.getParameter("productId"));
        int sizeId = Integer.parseInt(req.getParameter("sizeId"));
        int quantity = Integer.parseInt(req.getParameter("quantity"));
        System.out.println(req.getParameter("price"));
        double price = Double.parseDouble(req.getParameter("price"));
        System.out.println(sizeId);

        ProductVariantService productVariantService = new ProductVariantService();
        ProductVariant productVariant = productVariantService.getProVariant(productId);

        HttpSession session = req.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
        }
        cart.add(productVariant, sizeId, quantity, price);
        session.setAttribute("cart", cart);
        String referer = req.getHeader("Referer");
        resp.sendRedirect(referer);
    }
}
