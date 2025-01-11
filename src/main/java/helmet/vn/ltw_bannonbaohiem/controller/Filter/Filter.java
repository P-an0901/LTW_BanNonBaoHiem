package helmet.vn.ltw_bannonbaohiem.controller.Filter;

import helmet.vn.ltw_bannonbaohiem.dao.model.Brand;
import helmet.vn.ltw_bannonbaohiem.dao.model.Category;
import helmet.vn.ltw_bannonbaohiem.service.BrandService;
import helmet.vn.ltw_bannonbaohiem.service.CategoryService;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebFilter("/*")
public class Filter implements jakarta.servlet.Filter {
    private BrandService brandService = new BrandService();
    private CategoryService cateService = new CategoryService();

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }
    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) servletRequest;
        HttpServletResponse resp = (HttpServletResponse) servletResponse;

        List<Brand> brands = brandService.getAllBrands();
        List<Category> categories = cateService.getAllCate();
        req.setAttribute("categories", categories);
        req.setAttribute("brands", brands);

        filterChain.doFilter(req, resp);
    }

    @Override
    public void destroy() {
    }
}

