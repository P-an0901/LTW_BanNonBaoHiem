package helmet.vn.ltw_bannonbaohiem.dao;

import helmet.vn.ltw_bannonbaohiem.dao.db.JdbiConnect;
import helmet.vn.ltw_bannonbaohiem.dao.model.User;
import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.core.statement.Update;

import java.util.List;

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

    public boolean register(String username, String hashedPassword, String name, String email) {
        if (email == null || email.trim().isEmpty()) {
            email = null;
        }
        String sql = "INSERT INTO users(username, email, password, fullName) " +
                "VALUES(?, ?, ?, ?)";
        try {
            String finalEmail = email;
            return jdbi.withHandle(handle -> {
                Update update = handle.createUpdate(sql);
                update.bind(0, username);
                update.bind(1, finalEmail);
                update.bind(2, hashedPassword);
                update.bind(3, name);
                int rowsAffected = update.execute();
                return rowsAffected > 0;
            });
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<User> getAllUsers() {
        String sql = "SELECT * FROM users";
        return jdbi.withHandle(handle -> {
            return handle.createQuery(sql)
                    .mapToBean(User.class)
                    .list();
        });
    }
}
