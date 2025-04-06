package helmet.vn.ltw_bannonbaohiem.dao;

import helmet.vn.ltw_bannonbaohiem.dao.db.JdbiConnect;
import helmet.vn.ltw_bannonbaohiem.dao.model.User;
import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.core.statement.Update;

import java.util.ArrayList;
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

    public boolean addUser(String username, String password, String name, String email, int role, int active) {
        if (email == null || email.trim().isEmpty()) {
            email = null;
        }
        String sql = "INSERT INTO users(username, email, password, fullName, role, isActive) " +
                "VALUES(?, ?, ?, ?, ?, ?)";
        try {
            String finalEmail = email;
            return jdbi.withHandle(handle -> {
                Update update = handle.createUpdate(sql);
                update.bind(0, username);
                update.bind(1, finalEmail);
                update.bind(2, password);
                update.bind(3, name);
                update.bind(4, role);
                update.bind(5, active);
                int rowsAffected = update.execute();
                return rowsAffected > 0;
            });
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateInfo(int uid, String fullName, String email, String phone, String birthday, String address, String image) {
        StringBuilder updateQuery = new StringBuilder("UPDATE users SET fullName = ?");
        List<Object> params = new ArrayList<>();
        params.add(fullName);
        if (email != null && !email.isEmpty()) {
            updateQuery.append(", email = ?");
            params.add(email);
        }
        if (phone != null && !phone.isEmpty()) {
            updateQuery.append(", phone = ?");
            params.add(phone);
        }
        if (birthday != null && !birthday.isEmpty()) {
            updateQuery.append(", birthday = ?");
            params.add(birthday);
        }
        if (address != null && !address.isEmpty()) {
            updateQuery.append(", address = ?");
            params.add(address);
        }
        if (image != null && !image.isEmpty()) {
            updateQuery.append(", image = ?");
            params.add(image);
        }
        updateQuery.append(" WHERE id = ?");
        params.add(uid);
        return jdbi.withHandle(handle -> {
            Update update = handle.createUpdate(updateQuery.toString());
            for (int i = 0; i < params.size(); i++) {
                update.bind(i , params.get(i));
            }
            int rowsUpdated = update.execute();
            return rowsUpdated > 0;
        });
    }

    public int countCustomer() {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT COUNT(*) FROM users WHERE role = 0")
                        .mapTo(int.class)
                        .one()
        );
    }
}
