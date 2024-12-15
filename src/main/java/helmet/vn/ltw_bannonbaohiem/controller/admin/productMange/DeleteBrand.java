package helmet.vn.ltw_bannonbaohiem.controller.admin.productMange;

import helmet.vn.ltw_bannonbaohiem.service.BrandService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/deleteBrand")
public class DeleteBrand extends HttpServlet {
    private BrandService brandService = new BrandService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("activeTab", "product");
        String id = req.getParameter("id");
        System.out.println(id);
        if(id != null && !id.isEmpty()){
            boolean isDeleted = brandService.deleteBrand(Integer.parseInt(id));
            if (isDeleted) {
                resp.sendRedirect(req.getContextPath() + "/admin/product");
            } else {
                req.setAttribute("error", "Không thể xóa thương hiệu!");
                req.getRequestDispatcher("/admin/product").forward(req, resp);
            }
        }

    }
}
