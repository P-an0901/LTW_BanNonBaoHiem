package helmet.vn.ltw_bannonbaohiem.dao;

import helmet.vn.ltw_bannonbaohiem.dao.db.JdbiConnect;
import helmet.vn.ltw_bannonbaohiem.dao.model.Product;
import helmet.vn.ltw_bannonbaohiem.dao.model.ProductSize;
import helmet.vn.ltw_bannonbaohiem.dao.model.ProductVariant;
import helmet.vn.ltw_bannonbaohiem.dao.model.Sizes;
import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.core.statement.Update;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class ProductVariantDao {
    Jdbi jdbi;
    public ProductVariantDao(){
        this.jdbi = JdbiConnect.get();
    }
    public List<ProductVariant> getAllVariant() {
        String sql = "SELECT pv.id, pv.name, pv.color, pv.price, pv.image, pv.isActive, " +
                "       pv.productId AS pid, p.name AS pname, " +
                "       ps.id AS psid, s.name AS sname, s.id AS sizeId, ps.stock " +
                "FROM product_variants pv " +
                "JOIN products p ON pv.productId = p.id " +
                "JOIN product_sizes ps ON pv.id = ps.variantId " +
                "JOIN sizes s ON ps.sizeId = s.id";

        return jdbi.withHandle(handle -> {
            List<ProductVariant> variants = new ArrayList<>();

            handle.createQuery(sql)
                    .map((rs, ctx) -> {
                        int variantId = rs.getInt("id");

                        ProductVariant existingVariant = null;
                        for (ProductVariant variant : variants) {
                            if (variant.getId() == variantId) {
                                existingVariant = variant;
                                break;
                            }
                        }

                        if (existingVariant == null) {
                            ProductVariant variant = new ProductVariant();
                            variant.setId(variantId);
                            variant.setName(rs.getString("name"));
                            variant.setProductId(rs.getInt("pid"));
                            variant.setColor(rs.getString("color"));
                            variant.setPrice(rs.getDouble("price"));
                            variant.setImage(rs.getString("image"));
                            variant.setActive(rs.getInt("isActive") > 0);
                            variant.setListPSize(new ArrayList<>());
                            variants.add(variant);
                            existingVariant = variant;
                        }

                        ProductSize productSize = new ProductSize();
                        productSize.setId(rs.getInt("psid"));
                        productSize.setStock(rs.getInt("stock"));

                        Sizes size = new Sizes();
                        size.setId(rs.getInt("sizeId"));
                        size.setName(rs.getString("sname"));
                        productSize.setSize(size);

                        existingVariant.getListPSize().add(productSize);

                        return null;
                    }).list();

            return variants;
        });
    }

    public boolean addVariant(String name, String color, int product, double price, String image, int active){
        String sql = "INSERT INTO product_variants(name, productId, color, price, image, isActive)" +
                "VALUES (?, ?, ?, ?, ?, ?)";
        try {
            return jdbi.withHandle(handle -> {
                Update update = handle.createUpdate(sql);
                update.bind(0, name);
                update.bind(1, product);
                update.bind(2, color);
                update.bind(3, price);
                update.bind(4, image);
                update.bind(5, active > 0);
                int rowsAffected = update.execute();
                return rowsAffected > 0;
            });
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    public ProductVariant getProVariantById(int id){
        String sql ="SELECT pv.id, pv.name, pv.productId, pv.color, pv.price, pv.image, pv.isActive " +
                "FROM product_variants pv " +
                "WHERE pv.id = ?;";
        try {
            return jdbi.withHandle(handle ->
                    handle.createQuery(sql)
                            .bind(0, id)
                            .map((rs, ctx) -> new ProductVariant(
                                    rs.getInt("id"),
                                    rs.getString("name"),
                                    rs.getInt("productId"),
                                    rs.getString("color"),
                                    rs.getDouble("price"),
                                    rs.getString("image"),
                                    rs.getBoolean("isActive")
                            )).findOne().orElse(null)
            );
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    public List<ProductVariant> listProVariantByProId(int id) {
        String sql = "SELECT * FROM product_variants WHERE productId = ?";
        try {
            return jdbi.withHandle(handle ->
                    handle.createQuery(sql)
                            .bind(0, id)
                            .mapToBean(ProductVariant.class)
                            .list()
            );
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>(); 
        }
    }
}
