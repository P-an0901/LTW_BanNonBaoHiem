package helmet.vn.ltw_bannonbaohiem.controller.Filter;

import helmet.vn.ltw_bannonbaohiem.dao.cart.Cart;
import helmet.vn.ltw_bannonbaohiem.dao.cart.CartProduct;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebFilter("/*")
public class CartFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) servletRequest;
        HttpServletResponse resp = (HttpServletResponse) servletResponse;

        HttpSession session = req.getSession();

        Cart cart = (Cart) session.getAttribute("cart");

        if (cart == null) {
            cart = new Cart();
            req.getSession().setAttribute("cart", cart);
        }

        List<CartProduct> cartItems = cart.show();
        session.setAttribute("cartItems", cartItems);
        System.out.println(cartItems);

        filterChain.doFilter(req, resp);
    }
    @Override
    public void destroy() {

    }
}
