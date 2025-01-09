package helmet.vn.ltw_bannonbaohiem.dao;

import helmet.vn.ltw_bannonbaohiem.dao.db.JdbiConnect;
import helmet.vn.ltw_bannonbaohiem.dao.model.Brand;
import helmet.vn.ltw_bannonbaohiem.dao.model.Category;
import helmet.vn.ltw_bannonbaohiem.dao.model.Product;
import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.core.statement.Update;

import java.util.ArrayList;
import java.util.List;

public class ProductDao {
    private Jdbi jdbi;
    public ProductDao(){
        this.jdbi = JdbiConnect.get();

    }

    public List<Product> getAllPro() {
        return jdbi.withHandle(handle -> {
            String query = "SELECT p.id AS pid, p.name AS pname, p.description, " +
                    "p.brandId, p.categoryId, p.createdAt, p.updatedAt, " +
                    "b.id AS bid, b.name AS bname, " +
                    "c.id AS cateId, c.name AS catename " +
                    "FROM products p " +
                    "JOIN brands b ON p.brandId = b.id " +
                    "JOIN categories c ON p.categoryId = c.id";

            return handle.createQuery(query)
                    .map((rs, ctx) -> {
                        Product product = new Product();
                        product.setId(rs.getInt("pid"));
                        product.setName(rs.getString("pname"));
                        product.setDescription(rs.getString("description"));
                        product.setCreatedAt(rs.getTimestamp("createdAt").toLocalDateTime());
                        product.setUpdatedAt(rs.getTimestamp("updatedAt").toLocalDateTime());

                        Brand brand = new Brand();
                        brand.setId(rs.getInt("bid"));
                        brand.setName(rs.getString("bname"));
                        product.setBrand(brand);

                        Category category = new Category();
                        category.setId(rs.getInt("cateId"));
                        category.setName(rs.getString("catename"));
                        product.setCategory(category);

                        return product;
                    })
                    .list();
        });
    }
    public Product getProById(int id) {
        String sql = "SELECT p.*, b.*, c.* FROM products p JOIN brands b ON p.brandId = b.id " +
                "JOIN categories c ON c.id = p.categoryId " +
                "WHERE p.id = ?";
        return jdbi.withHandle(handle -> {
            return handle.createQuery(sql)
                    .bind(0, id)
                    .map((rs, ctx) -> {
                        Product product = new Product();
                        product.setId(rs.getInt("p.id"));
                        product.setName(rs.getString("p.name"));
                        product.setDescription(rs.getString("p.description"));

                        Brand brand = new Brand();
                        brand.setId(rs.getInt("b.id"));
                        brand.setName(rs.getString("b.name"));

                        Category category = new Category();
                        category.setId(rs.getInt("c.id"));
                        category.setName(rs.getString("c.name"));

                        product.setBrand(brand);
                        product.setCategory(category);

                        return product;
                    })
                    .findOne()
                    .orElse(null);
        });
    }
    public boolean addProduct(String name, String description, int brandId, int cateid){
        String sql = "INSERT INTO products(name, description, brandId, categoryId)" +
                "VALUES (?, ?, ?, ?)";
        try{
            return jdbi.withHandle(handle -> {
                Update update = handle.createUpdate(sql);
                update.bind(0, name);
                update.bind(1, description);
                update.bind(2, brandId);
                update.bind(3, cateid);
                int rowsAffected = update.execute();
                return rowsAffected > 0;
            });
        }catch (Exception e ){
            e.printStackTrace();
            return false;
        }
    }
    public boolean updateProduct(int id, String name, String description, int brandId, int cateId){
        String sql = "UPDATE products SET name = ?, description = ?, brandId = ?, categoryId = ? " +
                "WHERE id = ?;";
        try{
            return jdbi.withHandle(handle -> {
                Update update = handle.createUpdate(sql);
                update.bind(0, name);
                update.bind(1, description);
                update.bind(2, brandId);
                update.bind(3, cateId);
                update.bind(4, id);
                int rowsAffected = update.execute();
                return rowsAffected > 0;
            });
        }catch (Exception e ){
            e.printStackTrace();
            return false;
        }
    }

    public boolean delete(int id) {
        String sql = "DELETE FROM products WHERE id = ?";
        return jdbi.withHandle(handle -> {
            Update update = handle.createUpdate(sql);
            update.bind(0, id);
            int rowsAffected = update.execute();
            return rowsAffected > 0;
        });
    }
}
