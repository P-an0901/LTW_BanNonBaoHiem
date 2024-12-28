package helmet.vn.ltw_bannonbaohiem.dao;

import helmet.vn.ltw_bannonbaohiem.dao.db.JdbiConnect;
import helmet.vn.ltw_bannonbaohiem.dao.model.User;
import org.jdbi.v3.core.Jdbi;

public class UserDao {
    private Jdbi jdbi;

    public UserDao() {
        this.jdbi = JdbiConnect.get();
    }
    public User findUser(String username){
        String sql = "SELECT * FROM users WHERE username = :username";
        return jdbi.withHandle(handle ->{
            return  handle.createQuery(sql)
                    .bind("username", username)
                    .mapToBean(User.class)
                    .findFirst().orElse(null);
        });

    }
}
