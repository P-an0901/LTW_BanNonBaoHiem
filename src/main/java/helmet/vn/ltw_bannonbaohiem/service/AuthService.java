package helmet.vn.ltw_bannonbaohiem.service;

import helmet.vn.ltw_bannonbaohiem.dao.UserDao;
import helmet.vn.ltw_bannonbaohiem.dao.model.User;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class AuthService {
    private UserDao udao = new UserDao();
    public User checkLogin(String username, String pass){
        User u = udao.findUser(username);
        if(u==null) return null;
        String hashedPassword = hashPassword(pass);
        if (hashedPassword.equals(u.getPassword())) {
            return u;
        }
        return null;
    }

    public boolean register(String username, String password, String name, String email) {
        String hashedPassword = hashPassword(password);
        return udao.register(username, hashedPassword, name, email);
    }
    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashedBytes = md.digest(password.getBytes());

            StringBuilder sb = new StringBuilder();
            for (byte b : hashedBytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Lỗi mã hóa: " + e.getMessage());
        }
    }
}
