package helmet.vn.ltw_bannonbaohiem.controller;

import helmet.vn.ltw_bannonbaohiem.dao.model.User;
import helmet.vn.ltw_bannonbaohiem.service.AuthService;
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
import java.util.Map;
import com.google.gson.Gson;

@WebServlet("/login")
public class LoginController extends HttpServlet {
    private AuthService auth = new AuthService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        User u = auth.checkLogin(username, password);

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

        if (hasError) {
            responseMap.put("loginError", "Đăng nhập không thành công");
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        } else {
            if (u != null) {
                HttpSession session = req.getSession();
                u.setPassword(null);
                session.setAttribute("auth", u);
                responseMap.put("loginSuccess", "Đăng nhập thành công");
            } else {
                responseMap.put("loginError", "Thông tin đăng nhập không đúng.");
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            }
        }

        resp.setContentType("application/json");
        PrintWriter out = resp.getWriter();
        out.print(new Gson().toJson(responseMap));
        out.flush();

    }
}
