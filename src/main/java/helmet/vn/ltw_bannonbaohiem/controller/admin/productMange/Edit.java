package helmet.vn.ltw_bannonbaohiem.controller.admin.productMange;

import helmet.vn.ltw_bannonbaohiem.service.BrandService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;

@WebServlet("/edit-tab-product")
@MultipartConfig
public class Edit extends HttpServlet {
    private BrandService brandService = new BrandService();
    private static final String UPLOAD_DIR = "images";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("activeTab", "product");
        String activeSubTab = req.getParameter("subTab");

        String action = req.getParameter("action");
        System.out.println(action);
        if (action == null) {
            System.out.println("action is null");
        }else {
            switch (action) {
                case "editBrand":
                    handleEditBrand(req, resp);
                    break;
                case "editProduct":
                    handleEditProduct(req, resp);
                    break;
                case "editSize":
                    handleEditSize(req, resp);
                    break;
                case "editCate":
                    handleEditCate(req, resp);
                    break;
                case "editProductVariant":
                    handleEditProductVariant(req, resp);
                    break;
                case "editProductVariantSize":
                    handleEditProductVariantSize(req, resp);
                    break;
                default:
                    resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action parameter");
            }
        }

    }

    private void handleEditProductVariantSize(HttpServletRequest req, HttpServletResponse resp) {
    }

    private void handleEditProductVariant(HttpServletRequest req, HttpServletResponse resp) {

    }

    private void handleEditCate(HttpServletRequest req, HttpServletResponse resp) {

    }

    private void handleEditSize(HttpServletRequest req, HttpServletResponse resp) {

    }

    private void handleEditProduct(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {

    }

    private void handleEditBrand(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String id = req.getParameter("brandId");
        String brandName = req.getParameter("brandName");
        Part filePart = req.getPart("brandImage");
        System.out.println(id);
        String fileName = extractFileName(filePart);
        String uploadPath = getServletContext().getRealPath("/") + File.separator + UPLOAD_DIR;

        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        String filePath = uploadPath + File.separator + fileName;
        filePart.write(filePath);
        System.out.println("Ảnh đã được lưu tại: " + filePath);

        String imagePath = UPLOAD_DIR + "/" + fileName;
        System.out.println(brandName);
        if (id != null && !id.isEmpty() && brandName != null && !brandName.isEmpty()) {
            brandService.updateBrand(Integer.parseInt(id), brandName, imagePath);
            System.out.println(brandName);
            String referer = req.getHeader("Referer");
            resp.sendRedirect(referer);

        } else {
            req.setAttribute("error", "Thông tin không hợp lệ!");
            req.getRequestDispatcher("/admin/product").forward(req, resp);
        }
    }
    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        for (String content : contentDisp.split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf("=") + 2, content.length() - 1);
            }
        }
        return null;
    }
}
