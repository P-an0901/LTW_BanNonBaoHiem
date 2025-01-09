package helmet.vn.ltw_bannonbaohiem.controller.admin.productMange;

import helmet.vn.ltw_bannonbaohiem.dao.ProductDao;
import helmet.vn.ltw_bannonbaohiem.service.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/delete-tab-product")
public class Delete extends HttpServlet {
    private BrandService brandService = new BrandService();
    private CategoryService cateService = new CategoryService();
    private ProductVariantService productVariantService = new ProductVariantService();
    private SizeService sizeService = new SizeService();
    private ProductService productService = new ProductService();
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("activeTab", "product");
        String action = req.getParameter("action");
        System.out.println(action);
        switch (action) {
            case "deleteBrand":
                handleDeleteBrand(req, resp);
                break;
            case "deleteProduct":
                handleDeleteProduct(req, resp);
                break;
            case "deleteSize":
                handleDeleteSize(req, resp);
                break;
            case "deleteCate":
                handleDeleteCate(req, resp);
                break;
            case "deleteProductVariant":
                handleDeleteProductVariant(req, resp);
                break;
            case "deleteProductVariantSize":
                handleDeleteProductVariantSize(req, resp);
                break;
            default:
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action parameter");
        }

    }

    private void handleDeleteProductVariantSize(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String id = req.getParameter("id");
        System.out.println(id);
        if(id != null && !id.isEmpty()){
            boolean isDeleted = productVariantService.deleteProSize(id);
            if (isDeleted) {
                String referer = req.getHeader("Referer");
                resp.sendRedirect(referer);
            } else {
                req.setAttribute("error", "Không thể xóa!");
                req.getRequestDispatcher("/admin/product").forward(req, resp);
            }
        }

    }

    private void handleDeleteProductVariant(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String id = req.getParameter("id");
        System.out.println(id);
        if(id != null && !id.isEmpty()){
            boolean isDeleted = productVariantService.deleteVariant(id);
            if (isDeleted) {
                String referer = req.getHeader("Referer");
                resp.sendRedirect(referer);
            } else {
                req.setAttribute("error", "Không thể xóa!");
                req.getRequestDispatcher("/admin/product").forward(req, resp);
            }
        }
    }

    private void handleDeleteCate(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException{
        String id = req.getParameter("id");
        System.out.println(id);
        if(id != null && !id.isEmpty()){
            boolean isDeleted = cateService.deleteCate(Integer.parseInt(id));
            if (isDeleted) {
                String referer = req.getHeader("Referer");
                resp.sendRedirect(referer);
            } else {
                req.setAttribute("error", "Không thể xóa danh mục!");
                req.getRequestDispatcher("/admin/product").forward(req, resp);
            }
        }
    }

    private void handleDeleteSize(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String id = req.getParameter("id");
        System.out.println(id);
        if(id != null && !id.isEmpty()){
            boolean isDeleted = productVariantService.deleteProSize(id);
            if (isDeleted) {
                String referer = req.getHeader("Referer");
                resp.sendRedirect(referer);
            } else {
                req.setAttribute("error", "Không thể xóa!");
                req.getRequestDispatcher("/admin/product").forward(req, resp);
            }
        }
        
    }

    private void handleDeleteProduct(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String id = req.getParameter("id");
        System.out.println(id);
        if(id != null && !id.isEmpty()){
            boolean isDeleted = productService.deleteProduct(id);
            if (isDeleted) {
                String referer = req.getHeader("Referer");
                resp.sendRedirect(referer);
            } else {
                req.setAttribute("error", "Không thể xóa!");
                req.getRequestDispatcher("/admin/product").forward(req, resp);
            }
        }
    }

    private void handleDeleteBrand(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String id = req.getParameter("id");
        System.out.println(id);
        if(id != null && !id.isEmpty()){
            boolean isDeleted = brandService.deleteBrand(Integer.parseInt(id));
            if (isDeleted) {
                String referer = req.getHeader("Referer");
                resp.sendRedirect(referer);
            } else {
                req.setAttribute("error", "Không thể xóa thương hiệu!");
                req.getRequestDispatcher("/admin/product").forward(req, resp);
            }
        }
    }
}
