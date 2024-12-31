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

    public boolean addCate(String name, String image) {
        String sql = "INSERT INTO categories (name, image) VALUES (?, ?)";
        try {
            return jdbi.withHandle(handle -> {
                Update update = handle.createUpdate(sql);
                update.bind(0, name);
                update.bind(1, image);
                int rowsAffected = update.execute();
                return rowsAffected > 0;
            });
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Category> getAllCate() {
        String sql = "SELECT * FROM categories";
        return jdbi.withHandle(handle -> {
            return handle.createQuery(sql)
                    .mapToBean(Category.class)
                    .list();
        });
    }
    public Category getCateById(int id) {
        String sql = "SELECT * FROM categories WHERE id = ?";
        return jdbi.withHandle(handle -> {
            return handle.createQuery(sql)
                    .bind(0, id)
                    .mapTo(Category.class)
                    .findOne()
                    .orElse(null);
        });
    }
    public boolean updateCate(int id, String name, String image) {
        String sql = "UPDATE categories SET name = ?, image = ? WHERE id = ?";
        return jdbi.withHandle(handle -> {
            Update update = handle.createUpdate(sql);
            update.bind(0, name);
            update.bind(1, id);
            update.bind(2, image);
            int rowsAffected = update.execute();
            return rowsAffected > 0;
        });
    }
    public boolean deleteCate(int id) {
        String sql = "DELETE FROM categories WHERE id = ?";
        return jdbi.withHandle(handle -> {
            Update update = handle.createUpdate(sql);
            update.bind(0, id);
            int row = update.execute();
            return row > 0;
        });
    }

}
