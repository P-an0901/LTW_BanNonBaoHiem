package helmet.vn.ltw_bannonbaohiem.service;

import helmet.vn.ltw_bannonbaohiem.dao.PromotionDao;
import helmet.vn.ltw_bannonbaohiem.dao.PromotionVariantDao;
import helmet.vn.ltw_bannonbaohiem.dao.model.Promotion;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

public class PromotionService {
    private PromotionDao promotionD = new PromotionDao();
    private PromotionVariantDao promotionVaD = new PromotionVariantDao();
    public List<Promotion> listPromotions(){
        return promotionD.getAllPromotions();
    }
    public Promotion getPromotionById(int id){
        Promotion promotion = promotionD.getPromotionById(id);
        if (promotion != null) {
            Set<Integer> sets = promotionVaD.listVariantIds(id);
            List<Integer> listIdVariants = new ArrayList<>(sets);
            promotion.setLstVariant(listIdVariants);
            return promotion;
        } else {
            System.out.println("Promotion is null");
        }
        return null;
    }

    public boolean addPromotion(String name, String description, double discountPercentage, LocalDateTime startDate, LocalDateTime endDate) {
        return promotionD.addPromotion(name, description, discountPercentage, startDate, endDate);
    }
}
