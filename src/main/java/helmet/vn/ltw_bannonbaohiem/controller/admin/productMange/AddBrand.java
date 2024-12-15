package helmet.vn.ltw_bannonbaohiem.controller.admin.productMange;

import helmet.vn.ltw_bannonbaohiem.dao.model.Brand;
import helmet.vn.ltw_bannonbaohiem.service.BrandService;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/addBrand")
public class AddBrand extends HttpServlet {
    BrandService brandService = new BrandService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("activeTab", "product");
        String brandName = req.getParameter("brandName");
        String brandImage = req.getParameter("brandImage");
        System.out.println(brandName);

        if (brandName != null && !brandName.isEmpty()) {
            brandService.addBrand(brandName, brandImage);

//            List<Brand> brands = brandService.getAllBrands();
//            ServletContext context = getServletContext();
//            context.setAttribute("brands", brands);

            resp.sendRedirect(req.getContextPath() + "/admin/product");

        } else {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Tên thương hiệu không hợp lệ");
        }
    }
}
