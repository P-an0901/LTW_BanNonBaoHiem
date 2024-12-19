package helmet.vn.ltw_bannonbaohiem.controller.cart;

import helmet.vn.ltw_bannonbaohiem.dao.cart.Cart;
import helmet.vn.ltw_bannonbaohiem.dao.model.ProductSize;
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
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int productId = Integer.parseInt(req.getParameter("productId"));
        int sizeId = Integer.parseInt(req.getParameter("sizeId"));
        int quantity = Integer.parseInt(req.getParameter("quantity"));
        System.out.println(sizeId);

        ProductVariantService productVariantService = new ProductVariantService();
        ProductVariant productVariant = productVariantService.getProVariant(productId);

        HttpSession session = req.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        String message = null;
        boolean success = cart.add(productVariant, sizeId, quantity);

        if (!success) {
            if (productVariant.getListPSize().stream().noneMatch(size -> size.getId() == sizeId)) {
                message = "Không tìm thấy kích thước sản phẩm!";
            } else {
                ProductSize selectedSize = productVariant.getListPSize().stream()
                        .filter(size -> size.getId() == sizeId)
                        .findFirst()
                        .orElse(null);
                if (selectedSize != null && selectedSize.getStock() < quantity) {
                    message = "Không đủ hàng trong kho cho kích thước này!";
                }
            }
        } else {
            message = "Sản phẩm đã được thêm vào giỏ hàng thành công!";
        }
        System.out.println(message);
        req.setAttribute("message", message);
        resp.sendRedirect(req.getContextPath() + "/detail?pvId=" + productId);
    }
}
