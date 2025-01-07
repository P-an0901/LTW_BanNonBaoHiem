package helmet.vn.ltw_bannonbaohiem.controller.admin;

import com.google.gson.Gson;
import helmet.vn.ltw_bannonbaohiem.dao.UserDao;
import helmet.vn.ltw_bannonbaohiem.dao.model.User;
import helmet.vn.ltw_bannonbaohiem.service.AuthService;
import helmet.vn.ltw_bannonbaohiem.service.UserService;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/admin/user")
public class UserController extends HttpServlet {
    private UserService userService = new UserService();
    private AuthService auth = new AuthService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User u = (User) session.getAttribute("auth");

        if (u == null || u.getRole() < 1) {
            resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }
        req.setAttribute("activeTab", "user");
        List<User> users = userService.getAllUser();
        req.setAttribute("users", users);
        RequestDispatcher dispatcher = req.getRequestDispatcher("/admin.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        req.setAttribute("activeTab", "user");
        switch(action){
            case "add":
                handleAddUser(req, resp);
                break;
            case "edit":
                handleEditUser(req, resp);
                break;
            case "find":
                handleFindUser(req, resp);
                break;
            case "delete":
                handleDeleteUser(req, resp);
                break;
            default:
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action parameter");
        }
    }

    private void handleFindUser(HttpServletRequest req, HttpServletResponse resp) {
    }

    private void handleEditUser(HttpServletRequest req, HttpServletResponse resp) {
        
    }

    private void handleDeleteUser(HttpServletRequest req, HttpServletResponse resp) {

    }

    private void handleAddUser(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String confirmPass = req.getParameter("confirmPassword");
        String name = req.getParameter("fullName");
        System.out.println(name);
        String email = req.getParameter("email");
        String role = req.getParameter("role");
        String active = req.getParameter("active");
        Map<String, String> responseMap = new HashMap<>();
        boolean hasError = false;

        if (auth.checkExist(username)) {
            responseMap.put("username", "Tên đăng nhập đã tồn tại.");
            hasError = true;
        }
        if (!confirmPass.equals(password)) {
            responseMap.put("confirmPass", "Mật khẩu không khớp.");
            hasError = true;
        }
        if (hasError) {
            responseMap.put("registerError", "Đăng Ký không thành công");
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        } else {
            String hashPassword = auth.hashPassword(password);
            boolean isRegister = userService.addUser(username, hashPassword, name, email,
                    Integer.parseInt(role), Integer.parseInt(active));
            if (isRegister) {
                responseMap.put("registerSuccess", "Đăng ký thành công");
            } else {
                responseMap.put("registerError", "Đăng ký thử bại.");
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            }
        }

        resp.setContentType("application/json");
        PrintWriter out = resp.getWriter();
        out.print(new Gson().toJson(responseMap));
        out.flush();
    }
}
