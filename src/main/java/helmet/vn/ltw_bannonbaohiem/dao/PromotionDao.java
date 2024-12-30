package helmet.vn.ltw_bannonbaohiem.dao;

import helmet.vn.ltw_bannonbaohiem.dao.db.JdbiConnect;
import helmet.vn.ltw_bannonbaohiem.dao.model.ProductVariant;
import helmet.vn.ltw_bannonbaohiem.dao.model.Promotion;
import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.core.statement.Update;

import java.time.LocalDateTime;
import java.util.List;

public class PromotionDao {
    private Jdbi jdbi;

    public PromotionDao() {
        this.jdbi = JdbiConnect.get();
    }
    public List<Promotion> getAllPromotions(){
        String sql = "SELECT * FROM promotions;";
        return jdbi.withHandle(handle -> {
            return handle.createQuery(sql)
                    .mapToBean(Promotion.class)
                    .list();
        });
    }
    public boolean addPromotion(String name, String description, double discountPercentage, LocalDateTime start, LocalDateTime end){
        String sql = "INSERT INTO promotions(name, description, discountPercentage, startDate, endDate) " +
                "VALUES(?, ?, ?, ?, ?);";
        try {
            return jdbi.withHandle(handle -> {
                Update update = handle.createUpdate(sql);
                update.bind(0, name);
                update.bind(1, description);
                update.bind(2, discountPercentage);
                update.bind(3, start);
                update.bind(4, end);
                int rowsAffected = update.execute();
                return rowsAffected > 0;
            });
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    public boolean updatePromotion(int id, String name, String description, double discountPercentage, LocalDateTime start, LocalDateTime end){
        String sql = "UPDATE promotions SET name = ?, description = ?, discountPercentage = ?, startDate = ? ," +
                "endDate = ? WHERE id = ?;";
        try {
            return jdbi.withHandle(handle -> {
                Update update = handle.createUpdate(sql);
                update.bind(0, name);
                update.bind(1, description);
                update.bind(2, discountPercentage);
                update.bind(3, start);
                update.bind(4, end);
                update.bind(5, id);
                int rowsAffected = update.execute();
                return rowsAffected > 0;
            });
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    public Promotion getPromotionById(int id){
        String sql = "SELECT * FROM promotions WHERE id = ?;";
        return jdbi.withHandle(handle -> {
            return handle.createQuery(sql)
                    .bind(0, id)
                    .mapToBean(Promotion.class)
                    .findOne()
                    .orElse(null);
        });
    }
}
