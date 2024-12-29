package helmet.vn.ltw_bannonbaohiem.controller;

import com.google.gson.Gson;
import helmet.vn.ltw_bannonbaohiem.dao.model.User;
import helmet.vn.ltw_bannonbaohiem.service.AuthService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/register")
public class RegisterController extends HttpServlet {
    private AuthService auth = new AuthService();
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String confirmPass = req.getParameter("confirmPassword");
        String name = req.getParameter("fullName");
        System.out.println(name);
        String email = req.getParameter("email");

        Map<String, String> responseMap = new HashMap<>();
        boolean hasError = false;

        if (username == null || username.trim().isEmpty()) {
            responseMap.put("username", "Tên đăng nhập không được để trống.");
            hasError = true;
        }

        if (password == null || password.trim().isEmpty()) {
            responseMap.put("password", "Mật khẩu không được để trống.");
            hasError = true;
        }
        if (name == null || name.trim().isEmpty()) {
            responseMap.put("name", "Tên đầy đủ không được để trống.");
            hasError = true;
        }

        if (confirmPass == null || confirmPass.trim().isEmpty()) {
            responseMap.put("confirmPass", "Vui lòng nhập lại mật khẩu.");
            hasError = true;
        } else if (!confirmPass.equals(password)) {
            responseMap.put("confirmPass", "Mật khẩu không khớp.");
            hasError = true;
        }
        if (hasError) {
            responseMap.put("loginError", "Đăng nhập không thành công");
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        } else {
            boolean isRegister = auth.register(username, password, name, email);
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
