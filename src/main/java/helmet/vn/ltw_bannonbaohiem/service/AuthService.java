package helmet.vn.ltw_bannonbaohiem.service;

import helmet.vn.ltw_bannonbaohiem.dao.UserDao;
import helmet.vn.ltw_bannonbaohiem.dao.model.User;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.List;

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
    public String hashPassword(String password) {
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


    public boolean checkExist(String username) {
        List<User> users = udao.getAllUsers();
        for(User u : users){
            if(u.getUsername().equalsIgnoreCase(username))
            return true;
        }
        return false;
    }
    public boolean updateInfo(int uid, String fullName, String email, String phone, String birthday, String address, String image){
        return udao.updateInfo(uid, fullName, email, phone, birthday, address, image);
    }
}
