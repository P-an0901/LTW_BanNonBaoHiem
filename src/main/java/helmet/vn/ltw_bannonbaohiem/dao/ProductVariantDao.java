package helmet.vn.ltw_bannonbaohiem.dao;

import helmet.vn.ltw_bannonbaohiem.dao.db.JdbiConnect;
import helmet.vn.ltw_bannonbaohiem.dao.model.ProductImages;
import helmet.vn.ltw_bannonbaohiem.dao.model.ProductSize;
import helmet.vn.ltw_bannonbaohiem.dao.model.ProductVariant;
import helmet.vn.ltw_bannonbaohiem.dao.model.Sizes;
import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.core.statement.Query;
import org.jdbi.v3.core.statement.Update;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class ProductVariantDao {
    Jdbi jdbi;
    public ProductVariantDao(){
        this.jdbi = JdbiConnect.get();
    }
    public List<ProductVariant> getAllVariant(boolean forAdmin) {
        String sql = "SELECT pv.id, pv.name, pv.color, pv.price, pv.image, pv.isActive, " +
                "       pv.productId AS pid, pv.createdAt, p.name AS pname " +
                "FROM product_variants pv " +
                "JOIN products p ON pv.productId = p.id ";

        if (!forAdmin) {
            sql += "WHERE pv.isActive > 0";
        }

        return getProductVariants(sql);
    }

    private List<ProductVariant> getProductVariants(String sql) {
        return jdbi.withHandle(handle -> {
            return handle.createQuery(sql)
                    .map((rs, ctx) -> {
                        ProductVariant variant = new ProductVariant();
                        variant.setId(rs.getInt("id"));
                        variant.setName(rs.getString("name"));
                        variant.setProductId(rs.getInt("pid"));
                        variant.setColor(rs.getString("color"));
                        variant.setPrice(rs.getDouble("price"));
                        variant.setImage(rs.getString("image"));
                        variant.setActive(rs.getInt("isActive") > 0);
                        variant.setCreatedAt(rs.getTimestamp("createdAt").toLocalDateTime());
                        return variant;
                    }).list();
        });
    }
    public Map<Integer, List<ProductSize>> getProductSizes(List<Integer> variantIds) {
        return jdbi.withHandle(handle -> {
            String sizeSql = "SELECT ps.variantId, ps.id AS psid, ps.stock, " +
                    "       s.id AS sizeId, s.name AS sname " +
                    "FROM product_sizes ps " +
                    "JOIN sizes s ON ps.sizeId = s.id " +
                    "WHERE ps.variantId IN (<variantIds>)";

            return handle.createQuery(sizeSql)
                    .bindList("variantIds", variantIds)
                    .map((rs, ctx) -> {
                        int variantId = rs.getInt("variantId");
                        ProductSize productSize = new ProductSize();
                        productSize.setId(rs.getInt("psid"));
                        productSize.setStock(rs.getInt("stock"));

                        Sizes size = new Sizes();
                        size.setId(rs.getInt("sizeId"));
                        size.setName(rs.getString("sname"));
                        productSize.setSize(size);

                        return Map.entry(variantId, productSize);
                    })
                    .list()
                    .stream()
                    .collect(Collectors.groupingBy(Map.Entry::getKey,
                            Collectors.mapping(Map.Entry::getValue, Collectors.toList())));
        });
    }


    public boolean addVariant(String name, String color, int product, double price, String image, int active){
        String sql = "INSERT INTO product_variants(name, productId, color, price, image, isActive)" +
                "VALUES (?, ?, ?, ?, ?, ?)";
        String sql2 = "INSERT INTO product_images(variantId, imageUrl) VALUES(?, ?)";
        try {
            jdbi.useTransaction(handle -> {
                    int variantId = handle.createUpdate(sql)
                            .bind(0, name)
                            .bind(1, product)
                            .bind(2, color)
                            .bind(3, price)
                            .bind(4, image)
                            .bind(5, active)
                            .executeAndReturnGeneratedKeys("id")
                            .mapTo(int.class)
                            .one();
                    handle.createUpdate(sql2)
                            .bind(0, variantId)
                            .bind(1, image)
                            .execute();
            });
            return true;
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
                "       pv.productId AS pid, pv.createdAt, p.name AS pname " +
                "FROM product_variants pv " +
                "JOIN products p ON pv.productId = p.id " +
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
    public List<ProductVariant> getProVariantsWithPagination(Integer categoryId, Integer brandId, String color, Double minPrice,
            Double maxPrice, int offset, int pageSize) {

        StringBuilder sql = new StringBuilder("SELECT pv.id, pv.name, pv.color, pv.price, pv.image, pv.isActive, " +
                "       pv.productId AS pid, pv.createdAt, p.name AS pname " +
                "FROM product_variants pv " +
                "JOIN products p ON pv.productId = p.id " +
                "WHERE pv.isActive > 0 ");

        if (categoryId != null) {
            sql.append("AND p.categoryId = :categoryId ");
        }
        if (categoryId != null) {
            sql.append("AND p.brandId = :brandId ");
        }

        if (color != null && !color.isEmpty()) {
            sql.append("AND pv.color = :color ");
        }

        if (minPrice != null) {
            sql.append("AND pv.price >= :minPrice ");
        }
        if (maxPrice != null) {
            sql.append("AND pv.price <= :maxPrice ");
        }

        sql.append("LIMIT :pageSize OFFSET :offset");

        return jdbi.withHandle(handle -> {
            Query query = handle.createQuery(sql.toString())
                    .bind("pageSize", pageSize)
                    .bind("offset", offset);

            if (categoryId != null) {
                query.bind("categoryId", categoryId);
            }
            if (brandId != null) {
                query.bind("brandId", brandId);
            }
            if (color != null && !color.isEmpty()) {
                query.bind("color", color);
            }
            if (minPrice != null) {
                query.bind("minPrice", minPrice);
            }
            if (maxPrice != null) {
                query.bind("maxPrice", maxPrice);
            }

            return query.map((rs, ctx) -> {
                ProductVariant variant = new ProductVariant();
                variant.setId(rs.getInt("id"));
                variant.setName(rs.getString("name"));
                variant.setProductId(rs.getInt("pid"));
                variant.setColor(rs.getString("color"));
                variant.setPrice(rs.getDouble("price"));
                variant.setImage(rs.getString("image"));
                variant.setActive(rs.getInt("isActive") > 0);
                variant.setCreatedAt(rs.getTimestamp("createdAt").toLocalDateTime());
                return variant;
            }).list();
        });
    }

    public int getTotalVariantCount(int categoryId) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) " +
                "FROM product_variants pv " +
                "JOIN products p ON pv.productId = p.id " +
                "WHERE pv.isActive > 0 ");

        if (categoryId != -1) {
            sql.append("AND p.categoryId = :categoryId ");
        }

        return jdbi.withHandle(handle -> {
            Query query = handle.createQuery(sql.toString());
            if (categoryId != -1) {
                query.bind("categoryId", categoryId);
            }
            return query.mapTo(int.class).one();
        });
    }


    public List<ProductVariant> getSaleProductVariants() {
        String sql = "SELECT pv.id, pv.name, pv.color, pv.price, pv.image, pv.isActive, " +
                "       pv.productId AS pid, pv.createdAt, p.name AS pname, pm.discountPercentage AS discount " +
                "FROM product_variants pv " +
                "JOIN products p ON pv.productId = p.id " +
                "JOIN product_variant_promotions pvp ON pvp.variantId = pv.id " +
                "JOIN promotions pm ON pm.id = pvp.promotionId " +
                "WHERE pv.isActive > 0 AND pm.startDate <= NOW() AND pm.endDate >= NOW() " +
                "ORDER BY pm.endDate DESC " +
                "LIMIT 5";

        return jdbi.withHandle(handle -> {
            return handle.createQuery(sql)
                    .map((rs, ctx) -> {
                        ProductVariant variant = new ProductVariant();
                        variant.setId(rs.getInt("id"));
                        variant.setName(rs.getString("name"));
                        variant.setProductId(rs.getInt("pid"));
                        variant.setColor(rs.getString("color"));
                        variant.setPrice(rs.getDouble("price"));
                        variant.setImage(rs.getString("image"));
                        variant.setActive(rs.getInt("isActive") > 0);
                        variant.setSalePrice(rs.getDouble("discount")/100);
                        variant.setCreatedAt(rs.getTimestamp("createdAt").toLocalDateTime());
                        return variant;
                    }).list();
        });
    }

    public boolean delete(int id) {
        String sql = "DELETE FROM product_variants WHERE id = ?";
        return jdbi.withHandle(handle -> {
            Update update = handle.createUpdate(sql);
            update.bind(0, id);
            int rowsAffected = update.execute();
            return rowsAffected > 0;
        });
    }

    public List<ProductImages> listImages(int variantId){
        String sql = "SELECT * FROM product_images WHERE variantId = ?";
        return jdbi.withHandle(handle -> {
            return handle.createQuery(sql)
                    .bind(0, variantId)
                    .mapToBean(ProductImages.class)
                    .list();
        });
    }
}
