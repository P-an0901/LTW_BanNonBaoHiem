package helmet.vn.ltw_bannonbaohiem.service;

import helmet.vn.ltw_bannonbaohiem.dao.UserDao;
import helmet.vn.ltw_bannonbaohiem.dao.model.User;

import java.util.List;

public class UserService {
    private UserDao dao = new UserDao();
    public List<User> getAllUser() {
        List<User> users = dao.getAllUsers();
        for(User u : users){
            u.setPassword(null);
        }
        return users;
    }

    public boolean addUser(String username, String password, String name, String email, int role, int active) {
        return dao.addUser(username, password, name, email, role, active);
    }
}
