package helmet.vn.ltw_bannonbaohiem.controller.admin.productMange;

import helmet.vn.ltw_bannonbaohiem.service.BrandService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/editBrand")
public class EditBrand extends HttpServlet {
    private BrandService brandService = new BrandService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("activeTab", "product");
        String id = req.getParameter("brandId");
        String brandName = req.getParameter("brandName");
        String brandImage = req.getParameter("brandImage");
        System.out.println(id);

        if (id != null && !id.isEmpty() && brandName != null && !brandName.isEmpty()) {
                brandService.updateBrand(Integer.parseInt(id), brandName, brandImage);
            System.out.println(brandName);
                resp.sendRedirect(req.getContextPath() + "/admin/product");

        } else {
            req.setAttribute("error", "Thông tin không hợp lệ!");
            req.getRequestDispatcher("/admin/product").forward(req, resp);
        }
    }
}
