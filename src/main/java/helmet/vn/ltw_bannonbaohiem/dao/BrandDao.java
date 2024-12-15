package helmet.vn.ltw_bannonbaohiem.dao;

import helmet.vn.ltw_bannonbaohiem.dao.db.JdbiConnect;
import helmet.vn.ltw_bannonbaohiem.dao.model.Brand;
import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.core.Handle;
import org.jdbi.v3.core.statement.Update;
import org.jdbi.v3.core.result.ResultIterable;
import java.util.List;

public class BrandDao {
    private Jdbi jdbi;

    public BrandDao() {
        this.jdbi = JdbiConnect.get();
    }
    public boolean addBrand(String name, String imageUrl) {
        String sql = "INSERT INTO brands (name, imageUrl) VALUES (?, ?)";
        try {
            return jdbi.withHandle(handle -> {
                Update update = handle.createUpdate(sql);
                update.bind(0, name);
                update.bind(1, imageUrl);
                int rowsAffected = update.execute();
                return rowsAffected > 0;
            });
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Brand> getAllBrands() {
        String sql = "SELECT * FROM brands";
        return jdbi.withHandle(handle -> {
            return handle.createQuery(sql)
                    .mapToBean(Brand.class)
                    .list();
        });
    }
    public Brand getBrandById(int id) {
        String sql = "SELECT * FROM brands WHERE id = ?";
        return jdbi.withHandle(handle -> {
            return handle.createQuery(sql)
                    .bind(0, id)
                    .mapToBean(Brand.class)
                    .findOne()
                    .orElse(null);
        });
    }
    public boolean updateBrand(int id, String name, String imageUrl) {
        String sql = "UPDATE brands SET name = ?, imageUrl = ? WHERE id = ?";
        return jdbi.withHandle(handle -> {
            Update update = handle.createUpdate(sql);
            update.bind(0, name);
            update.bind(1, imageUrl);
            update.bind(2, id);
            int rowsAffected = update.execute();
            return rowsAffected > 0;
        });
    }
    public boolean deleteBrand(int id) {
        String sql = "DELETE FROM brands WHERE id = ?";
        return jdbi.withHandle(handle -> {
            Update update = handle.createUpdate(sql);
            update.bind(0, id);
            int rowsAffected = update.execute();
            return rowsAffected > 0;
        });
    }


}

