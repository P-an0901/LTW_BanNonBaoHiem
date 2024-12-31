package helmet.vn.ltw_bannonbaohiem.dao;

import helmet.vn.ltw_bannonbaohiem.dao.db.JdbiConnect;
import helmet.vn.ltw_bannonbaohiem.dao.model.ProductSize;
import helmet.vn.ltw_bannonbaohiem.dao.model.ProductVariant;
import helmet.vn.ltw_bannonbaohiem.dao.model.Sizes;
import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.core.statement.Update;

import java.util.ArrayList;
import java.util.List;

public class ProductVariantDao {
    Jdbi jdbi;
    public ProductVariantDao(){
        this.jdbi = JdbiConnect.get();
    }
    public List<ProductVariant> getAllVariant() {
        String sql = "SELECT pv.id, pv.name, pv.color, pv.price, pv.image, pv.isActive, " +
                "       pv.productId AS pid, pv.createdAt, p.name AS pname, " +
                "       ps.id AS psid, s.name AS sname, s.id AS sizeId, ps.stock " +
                "FROM product_variants pv " +
                "JOIN products p ON pv.productId = p.id " +
                "LEFT JOIN product_sizes ps ON pv.id = ps.variantId " +
                "LEFT JOIN sizes s ON ps.sizeId = s.id " +
                "WHERE pv.isActive > 0";


        return getProductVariants(sql);
    }
    public List<ProductVariant> getAllVariantsForAdmin() {
        String sql = "SELECT pv.id, pv.name, pv.color, pv.price, pv.image, pv.isActive, " +
                "       pv.productId AS pid, pv.createdAt, p.name AS pname, " +
                "       ps.id AS psid, s.name AS sname, s.id AS sizeId, ps.stock " +
                "FROM product_variants pv " +
                "JOIN products p ON pv.productId = p.id " +
                "LEFT JOIN product_sizes ps ON pv.id = ps.variantId " +
                "LEFT JOIN sizes s ON ps.sizeId = s.id";

        return getProductVariants(sql);
    }

    private List<ProductVariant> getProductVariants(String sql) {
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
                            variant.setCreatedAt(rs.getTimestamp("createdAt").toLocalDateTime());
                            variant.setListPSize(new ArrayList<>());
                            variants.add(variant);
                            existingVariant = variant;
                        }

                        if (rs.getObject("sizeId") != null && rs.getObject("psid") != null) {
                            ProductSize productSize = new ProductSize();
                            productSize.setId(rs.getInt("psid"));
                            productSize.setStock(rs.getInt("stock"));

                            Sizes size = new Sizes();
                            size.setId(rs.getInt("sizeId"));
                            size.setName(rs.getString("sname"));
                            productSize.setSize(size);

                            existingVariant.getListPSize().add(productSize);
                        }

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
                update.bind(5, active);
                int rowsAffected = update.execute();
                return rowsAffected > 0;
            });
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    public ProductVariant getProVariantById(int id){
        String sql ="SELECT pv.id, pv.name, pv.productId, pv.color, pv.price, pv.image, pv.isActive, pv.createdAt " +
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
                                    rs.getInt("isActive") > 0,
                                    rs.getTimestamp("createdAt").toLocalDateTime()
                            )).findOne().orElse(null)
            );
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    public List<ProductVariant> getNewProductVariants() {

        String sql = "SELECT pv.id, pv.name, pv.color, pv.price, pv.image, pv.isActive, " +
                "       pv.productId AS pid, pv.createdAt, p.name AS pname, " +
                "       ps.id AS psid, s.name AS sname, s.id AS sizeId, ps.stock " +
                "FROM product_variants pv " +
                "JOIN products p ON pv.productId = p.id " +
                "LEFT JOIN product_sizes ps ON pv.id = ps.variantId " +
                "LEFT JOIN sizes s ON ps.sizeId = s.id " +
                "WHERE pv.isActive > 0 " +
                "ORDER BY pv.createdAt DESC " +
                "LIMIT 5";

        return getProductVariants(sql);
    }


    public boolean update(int id, int productId, String name, String color, double price, String image, int active) {
        String sql = "UPDATE product_variants SET name = ?, productId = ?, color = ?, price = ?, image = ?, isActive = ? " +
                "WHERE id = ?";
        try{
            return jdbi.withHandle(handle -> {
                Update update = handle.createUpdate(sql);
                update.bind(0, name);
                update.bind(1, productId);
                update.bind(2, color);
                update.bind(3, price);
                update.bind(4, image);
                update.bind(5, active);
                update.bind(6, id);
                int rowsAffected = update.execute();
                return rowsAffected > 0;
            });
        }catch (Exception e ){
            e.printStackTrace();
            return false;
        }
    }
}
