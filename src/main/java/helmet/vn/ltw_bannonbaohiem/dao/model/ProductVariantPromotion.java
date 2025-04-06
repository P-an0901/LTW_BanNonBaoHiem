package helmet.vn.ltw_bannonbaohiem.dao.model;

import java.time.LocalDateTime;
import java.time.LocalTime;

public class ProductVariantPromotion {
    private int id;
    private int variant;
    private int promotion;
    private LocalDateTime createdAt;

    public ProductVariantPromotion() {
    }

    public ProductVariantPromotion(int id, int variant, int promotion, LocalDateTime createdAt) {
        this.id = id;
        this.variant = variant;
        this.promotion = promotion;
        this.createdAt = createdAt;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getVariant() {
        return variant;
    }

    public void setVariant(int variant) {
        this.variant = variant;
    }

    public int getPromotion() {
        return promotion;
    }

    public void setPromotion(int promotion) {
        this.promotion = promotion;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
}
