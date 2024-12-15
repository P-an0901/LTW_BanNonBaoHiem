package helmet.vn.ltw_bannonbaohiem.dao;

import helmet.vn.ltw_bannonbaohiem.dao.db.JdbiConnect;
import helmet.vn.ltw_bannonbaohiem.dao.model.Category;
import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.core.statement.Update;

import java.util.List;

public class CategoryDao {
    private Jdbi jdbi;

    public CategoryDao() {
        this.jdbi = JdbiConnect.get();
    }

    public boolean addBCate(String name) {
        String sql = "INSERT INTO categoríes (name) VALUES (?)";
        try {
            return jdbi.withHandle(handle -> {
                Update update = handle.createUpdate(sql);
                update.bind(0, name);
                int rowsAffected = update.execute();
                return rowsAffected > 0;
            });
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Category> getAllCate() {
        String sql = "SELECT * FROM categoríes";
        return jdbi.withHandle(handle -> {
            return handle.createQuery(sql)
                    .mapToBean(Category.class)
                    .list();
        });
    }
    public Category getCateById(int id) {
        String sql = "SELECT * FROM categoríes WHERE id = ?";
        return jdbi.withHandle(handle -> {
            return handle.createQuery(sql)
                    .bind(0, id)
                    .mapTo(Category.class)
                    .findOne()
                    .orElse(null);
        });
    }
    public void updateCate(int id, String name) {
        String sql = "UPDATE categoríes SET name = ? WHERE id = ?";
        jdbi.useHandle(handle -> {
            Update update = handle.createUpdate(sql);
            update.bind(0, name);
            update.bind(2, id);
            update.execute();
        });
    }
    public void deleteCate(int id) {
        String sql = "DELETE FROM categoríes WHERE id = ?";
        jdbi.useHandle(handle -> {
            Update update = handle.createUpdate(sql);
            update.bind(0, id);
            update.execute();
        });
    }
}
