package helmet.vn.ltw_bannonbaohiem.controller.admin.productMange;

import helmet.vn.ltw_bannonbaohiem.dao.model.Brand;
import helmet.vn.ltw_bannonbaohiem.dao.model.Category;
import helmet.vn.ltw_bannonbaohiem.service.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;

@WebServlet("/add-tab-product")
@MultipartConfig
public class Add extends HttpServlet {
    BrandService brandService = new BrandService();
    SizeService sizeService = new SizeService();
    CategoryService cateService = new CategoryService();
    ProductService productService = new ProductService();
    ProductVariantService productVariantService = new ProductVariantService();
    private static final String UPLOAD_DIR = "images";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("activeTab", "product");
        String action = req.getParameter("action");
        System.out.println(action);
        switch (action) {
            case "addBrand":
                handleAddBrand(req, resp);
                break;
            case "addProduct":
                handleAddProduct(req, resp);
                break;
            case "addSize":
                handleAddSize(req, resp);
                break;
            case "addCate":
                handleAddCate(req, resp);
                break;
            case "addProductVariant":
                handleAddProductVariant(req, resp);
                break;
            case "addProductVariantSize":
                handleAddProductVariantSize(req, resp);
                break;
            default:
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action parameter");
        }
    }

    private void handleAddProductVariantSize(HttpServletRequest req, HttpServletResponse resp) throws IOException{
        String variant = req.getParameter("variantId");
        String size = req.getParameter("sizeId");
        int stock = Integer.parseInt(req.getParameter("stock"));
        if(variant != null && size != null && stock >= 0){
            boolean bo = productVariantService.addNewSize(Integer.parseInt(variant), Integer.parseInt(size), stock);
            if(bo){
                resp.sendRedirect(req.getContextPath() + "/admin/product");
            }else{
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Lỗi");
            }
        }

    }

    private void handleAddProductVariant(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("bbbddbb");
        int productId = Integer.parseInt(req.getParameter("product_id"));
        String name = req.getParameter("name");
        String color = req.getParameter("color");
        double price = Double.parseDouble(req.getParameter("price"));
        int active = Integer.parseInt(req.getParameter("is_active"));

        Part filePart = req.getPart("image");
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

        if (name != null && !name.isEmpty()) {
            productVariantService.addProductVariant(name, color, productId, price, imagePath, active);
            System.out.println("hahaha");
            resp.sendRedirect(req.getContextPath() + "/admin/product");

        } else {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Lỗi");
        }

    }

    private void handleAddCate(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        String name = req.getParameter("categoryName");
        Part filePart = req.getPart("cateImage");
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
        if(!name.equals(null) && !name.isEmpty()){
            cateService.addCate(name, imagePath);
            String referer = req.getHeader("Referer");
            resp.sendRedirect(referer);

        } else {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Lỗi");
        }
    }

    private void handleAddSize(HttpServletRequest req, HttpServletResponse resp) throws IOException{
        String name = req.getParameter("nameSize");
        if(name != null){
            boolean bo = sizeService.add(name);
            if(bo){
                String referer = req.getHeader("Referer");
                resp.sendRedirect(referer);
            }

        } else {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Lỗi");
        }
        
    }

    private void handleAddProduct(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        System.out.println("bbbddbb");
        String name = req.getParameter("productName");
        String description = req.getParameter("productDescription");
        int brandId = Integer.parseInt(req.getParameter("brand"));
        int cateId = Integer.parseInt(req.getParameter("category"));

        if(!name.equals(null) && !name.isEmpty()){
            productService.addProduct(name, description, brandId, cateId);
            String referer = req.getHeader("Referer");
            resp.sendRedirect(referer);

        } else {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Lỗi");
        }

    }

    private void handleAddBrand(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String brandName = req.getParameter("brandName");
        System.out.println("bbbbb");
        Part filePart = req.getPart("brandImage");
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

        if (brandName != null && !brandName.isEmpty()) {
            brandService.addBrand(brandName, imagePath);

            String referer = req.getHeader("Referer");
            resp.sendRedirect(referer);

        } else {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Tên thương hiệu không hợp lệ");
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
