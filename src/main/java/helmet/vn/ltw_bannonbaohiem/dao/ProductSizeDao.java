package helmet.vn.ltw_bannonbaohiem.dao;

import helmet.vn.ltw_bannonbaohiem.dao.db.JdbiConnect;
import helmet.vn.ltw_bannonbaohiem.dao.model.ProductSize;
import helmet.vn.ltw_bannonbaohiem.dao.model.ProductVariant;
import helmet.vn.ltw_bannonbaohiem.dao.model.Sizes;
import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.core.statement.Update;

import java.util.List;

public class ProductSizeDao {
    Jdbi jdbi;
    public ProductSizeDao(){
        this.jdbi = JdbiConnect.get();
    }

    public List<ProductSize> getSizeByVariantId(int id){
        String sql = "SELECT ps.id, s.id AS size_id, s.name AS size_name, ps.variantId, ps.stock " +
                "FROM product_sizes ps " +
                "JOIN sizes s ON ps.sizeId = s.id " +
                "WHERE ps.variantId = ?";

        return jdbi.withHandle(handle -> {
            return handle.createQuery(sql)
                    .bind(0, id)
                    .map((rs, ctx) -> {
                        ProductSize productSize = new ProductSize();
                        productSize.setId(rs.getInt("id"));
                        productSize.setStock(rs.getInt("stock"));

                        Sizes size = new Sizes(
                                rs.getInt("size_id"),
                                rs.getString("size_name")
                        );
                        productSize.setSize(size);
                        return productSize;
                    })
                    .list();
        });
    }
    public ProductSize getById(int id) {
        String sql = "SELECT ps.id, ps.variantId, ps.sizeId, ps.stock, s.name AS size_name, pv.name AS variant_name " +
                "FROM product_sizes ps " +
                "JOIN sizes s ON ps.sizeId = s.id " +
                "JOIN product_variants pv ON ps.variantId = pv.id " +
                "WHERE ps.id = ?";
        return jdbi.withHandle(handle -> {
            return handle.createQuery(sql)
                    .bind(0, id)
                    .map((rs, ctx) -> {
                        ProductSize productSize = new ProductSize();
                        productSize.setId(rs.getInt("id"));
                        productSize.setStock(rs.getInt("stock"));

                        Sizes size = new Sizes();
                        size.setId(rs.getInt("sizeId"));
                        size.setName(rs.getString("size_name"));

                        ProductVariant productVariant = new ProductVariant(
                                rs.getInt("variantId"),
                                rs.getString("variant_name")
                        );
                        productSize.setVariant(productVariant);
                        productSize.setSize(size);

                        return productSize;
                    })
                    .findOne()
                    .orElse(null);
        });
    }

    public List<ProductSize> getAll() {
        String sql = "SELECT ps.id, ps.variantId, ps.sizeId, ps.stock, s.name AS size_name, " +
                "pv.name AS variant_name " +
                "FROM product_sizes ps " +
                "JOIN sizes s ON ps.sizeId = s.id " +
                "JOIN product_variants pv ON ps.variantId = pv.id";
        return jdbi.withHandle(handle -> {
            return handle.createQuery(sql)
                    .map((rs, ctx) -> {
                        ProductSize productSize = new ProductSize();
                        productSize.setId(rs.getInt("id"));
                        productSize.setStock(rs.getInt("stock"));

                        Sizes size = new Sizes();
                        size.setId(rs.getInt("sizeId"));
                        size.setName(rs.getString("size_name"));
                        productSize.setSize(size);

                        ProductVariant productVariant = new ProductVariant();
                        productVariant.setId(rs.getInt("variantId"));
                        productVariant.setName(rs.getString("variant_name"));
                        productSize.setVariant(productVariant);

                        return productSize;
                    })
                    .list();
        });
    }

    public boolean add(int variantId, int sizeId, int stock) {
        String sql = "INSERT INTO products_sizes (variantId, sizeId, stock) VALUES (?, ?, ?)";
        try {
            return jdbi.withHandle(handle -> {
                Update update = handle.createUpdate(sql);
                update.bind(0, variantId);
                update.bind(1, sizeId);
                update.bind(2, stock);
                int rowsAffected = update.execute();
                return rowsAffected > 0;
            });
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean delete(int id) {
        String sql = "DELETE FROM product_sizes WHERE id = ?";
        return jdbi.withHandle(handle -> {
            Update update = handle.createUpdate(sql);
            update.bind(0, id);
            int rowsAffected = update.execute();
            return rowsAffected > 0;
        });
    }
}
