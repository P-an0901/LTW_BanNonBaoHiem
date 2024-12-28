package helmet.vn.ltw_bannonbaohiem.service;

import helmet.vn.ltw_bannonbaohiem.dao.UserDao;
import helmet.vn.ltw_bannonbaohiem.dao.model.User;

public class AuthService {
    public User checkLogin(String username, String pass){
        UserDao udao = new UserDao();
        User u = udao.findUser(username);
        if(u==null) return null;
        if(pass.equals(u.getPassword())){
            return u;
        }
        return null;
    }
}
