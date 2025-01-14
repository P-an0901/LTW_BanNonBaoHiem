package helmet.vn.ltw_bannonbaohiem.controller;

import helmet.vn.ltw_bannonbaohiem.dao.model.Order;
import helmet.vn.ltw_bannonbaohiem.dao.model.User;
import helmet.vn.ltw_bannonbaohiem.service.AuthService;
import helmet.vn.ltw_bannonbaohiem.service.OrderService;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/account")
@MultipartConfig
public class AccountController extends HttpServlet {
    private OrderService orserService = new OrderService();
    private AuthService au = new AuthService();
    private static final String UPLOAD_DIR = "images";
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User u = (User) session.getAttribute("auth");

        if (u == null) {
            resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
            resp.sendRedirect(req.getContextPath() + "/");
        }else {
            List<Order> currentOrders = new ArrayList<>();
            List<Order> orderHistory = new ArrayList<>();
            List<Order> cancelOrders = new ArrayList<>();
            for (Order order : orserService.getAllList()) {
                if (order.getUser().getId() == u.getId()) {
                    if ("Đã giao".equals(order.getStatus())) {
                        orderHistory.add(order);
                    } else if ("Đã hủy".equals(order.getStatus())) {
                        cancelOrders.add(order);
                    } else {
                        currentOrders.add(order);
                    }
                }
            }
            req.setAttribute("currentOrders", currentOrders);
            req.setAttribute("orderHistory", orderHistory);
            RequestDispatcher dispatcher = req.getRequestDispatcher("/taikhoan.jsp");
            dispatcher.forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            System.out.println("action is null");
        }else {
            switch(action) {
                case "updateInfoUser":
                    updateInfoUser(req, resp);
                    break;
                case "updateOrder":
                    break;
                case "changePassword":
                    break;
                default:
                    resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action parameter");
            }
        }
    }

    private void updateInfoUser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User u = (User) session.getAttribute("auth");
        String fullName = req.getParameter("fullName");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");
        String birthday = req.getParameter("birthday");
        String imagePath = null;
        Part filePart = req.getPart("image");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = extractFileName(filePart);
            String uploadPath = getServletContext().getRealPath("/") + File.separator + UPLOAD_DIR;

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            String filePath = uploadPath + File.separator + fileName;
            filePart.write(filePath);
            System.out.println("Ảnh đã được lưu tại: " + filePath);

            imagePath = UPLOAD_DIR + "/" + fileName;
        }
        if ( u != null && fullName != null && !fullName.isEmpty()) {
            boolean bo = au.updateInfo(u.getId(), fullName, email, phone, birthday, address, imagePath);
            if (bo) {
                u.setFullName(fullName);
                u.setEmail(email);
                u.setPhone(phone);
                u.setAddress(address);
                u.setBirthday(LocalDate.parse(birthday));
                if (imagePath != null) {
                    u.setImage(imagePath);
                }
                session.setAttribute("auth", u);
            }
            String referer = req.getHeader("Referer");
            resp.sendRedirect(referer);
        } else {
            req.setAttribute("error", "Thông tin không hợp lệ!");
            req.getRequestDispatcher("/account").forward(req, resp);
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
