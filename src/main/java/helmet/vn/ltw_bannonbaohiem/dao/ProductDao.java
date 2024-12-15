package helmet.vn.ltw_bannonbaohiem.dao;

import helmet.vn.ltw_bannonbaohiem.dao.db.JdbiConnect;
import helmet.vn.ltw_bannonbaohiem.dao.model.Brand;
import helmet.vn.ltw_bannonbaohiem.dao.model.Category;
import helmet.vn.ltw_bannonbaohiem.dao.model.Product;
import org.jdbi.v3.core.Jdbi;

import java.util.ArrayList;
import java.util.List;

public class ProductDao {
    private Jdbi jdbi;
    public ProductDao(){
        this.jdbi = JdbiConnect.get();

    }

    public List<Product> getAllPro() {
        return jdbi.withHandle(handle -> {
            String query = "SELECT p.id AS product_id, p.name AS product_name, p.description, " +
                    "p.brand_id, p.category_id, p.created_at, p.updated_at, " +
                    "b.id AS brand_id, b.name AS brand_name, " +
                    "c.id AS category_id, c.name AS category_name " +
                    "FROM products p " +
                    "JOIN brands b ON p.brand_id = b.id " +
                    "JOIN categories c ON p.category_id = c.id";

            return handle.createQuery(query)
                    .map((rs, ctx) -> {
                        Product product = new Product();
                        product.setId(rs.getInt("product_id"));
                        product.setName(rs.getString("product_name"));
                        product.setDescription(rs.getString("description"));
                        product.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                        product.setUpdatedAt(rs.getTimestamp("updated_at").toLocalDateTime());

                        Brand brand = new Brand();
                        brand.setId(rs.getInt("brand_id"));
                        brand.setName(rs.getString("brand_name"));
                        product.setBrand(brand);

                        Category category = new Category();
                        category.setId(rs.getInt("category_id"));
                        category.setName(rs.getString("category_name"));
                        product.setCategory(category);

                        return product;
                    })
                    .list();
        });
    }




    public Product getProById(int id) {
        String sql = "SELECT * FROM products WHERE id = ?";
        return jdbi.withHandle(handle -> {
            return handle.createQuery(sql)
                    .bind(0, id)
                    .mapTo(Product.class)
                    .findOne()
                    .orElse(null);
        });
    }
}
