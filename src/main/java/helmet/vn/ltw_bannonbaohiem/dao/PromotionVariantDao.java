package helmet.vn.ltw_bannonbaohiem.dao;

import helmet.vn.ltw_bannonbaohiem.dao.db.JdbiConnect;
import helmet.vn.ltw_bannonbaohiem.dao.model.ProductVariant;
import helmet.vn.ltw_bannonbaohiem.dao.model.ProductVariantPromotion;
import helmet.vn.ltw_bannonbaohiem.dao.model.Promotion;
import org.jdbi.v3.core.Jdbi;

import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

public class PromotionVariantDao {
    private Jdbi jdbi;
//    private ProductVariantDao productVariantDao;
//    private PromotionDao promotionDao;

    public PromotionVariantDao() {
        this.jdbi = JdbiConnect.get();
    }
   public Set<Integer> listVariantIds() {
        String sql = "SELECT pvp.variantId " +
                "FROM product_variant_promotions pvp " +
                "JOIN promotions p ON pvp.promotionId = p.id " +
                "WHERE p.startDate <= NOW() AND p.endDate >= NOW()";

        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .mapTo(Integer.class)
                        .collect(Collectors.toSet())
        );
    }
    public Set<Integer> listVariantIds(int id) {
        String sql = "SELECT variantId " +
                "FROM product_variant_promotions " +
                "WHERE promotionId = ?";

        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind(0, id)
                        .mapTo(Integer.class)
                        .collect(Collectors.toSet())
        );
    }
}
