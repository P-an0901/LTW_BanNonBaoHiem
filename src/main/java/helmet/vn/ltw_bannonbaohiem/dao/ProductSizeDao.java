package helmet.vn.ltw_bannonbaohiem.dao;

import helmet.vn.ltw_bannonbaohiem.dao.db.JdbiConnect;
import helmet.vn.ltw_bannonbaohiem.dao.model.ProductSize;
import helmet.vn.ltw_bannonbaohiem.dao.model.Sizes;
import org.jdbi.v3.core.Jdbi;

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
}
