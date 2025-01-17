package helmet.vn.ltw_bannonbaohiem.controller;

import helmet.vn.ltw_bannonbaohiem.dao.model.*;
import helmet.vn.ltw_bannonbaohiem.service.*;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/detail")
public class DetailServlet extends HttpServlet {
    private ProductService productService = new ProductService();
    private ProductVariantService productVariantService = new ProductVariantService();
    private SizeService sizeService = new SizeService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("activePage", "danhmuc");
        String pvIdstr = req.getParameter("pvId");
        System.out.println(pvIdstr);

        if(pvIdstr != null){
            int pvId = Integer.parseInt(pvIdstr);
            ProductVariant productVariant = productVariantService.getProVariant(pvId);
            productVariantService.checkSale(productVariant);
            int pid = productVariant.getProductId();
//            System.out.println(productVariant);
            Product product = productService.getProById(productVariant.getProductId());
            ProductTechnicalDetail technical = productService.getProductTeach(pid);
            System.out.println(technical);
            List<ProductSize> sizes = productVariantService.getListSizeById(pvId);
            List<ProductVariant> lstProVariant = productVariantService.getListProVarByProId(pid);
            List<ProductImages> listImages = productVariantService.listImages(pvId);
            lstProVariant.removeIf(variant -> variant.getId() == pvId);
            System.out.println(lstProVariant+ "bbbbb");
            req.setAttribute("lstProVariant", lstProVariant);
            req.setAttribute("listImages", listImages);
            req.setAttribute("technical", technical);
            req.setAttribute("sizes", sizes);
            req.setAttribute("product", product);
            req.setAttribute("productVariant", productVariant);
            RequestDispatcher dispatcher = req.getRequestDispatcher("/detail.jsp");
            dispatcher.forward(req, resp);
        }
    }
}
