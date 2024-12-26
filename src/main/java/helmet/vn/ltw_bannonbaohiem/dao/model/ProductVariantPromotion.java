package helmet.vn.ltw_bannonbaohiem.dao.model;

import java.time.LocalDateTime;
import java.time.LocalTime;

public class ProductVariantPromotion {
    private int id;
    private ProductVariant variant;
    private Promotion promotion;
    private LocalDateTime createdAt;

    public ProductVariantPromotion() {
    }

    public ProductVariantPromotion(int id, ProductVariant variant, Promotion promotion, LocalDateTime createdAt) {
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

    public ProductVariant getVariant() {
        return variant;
    }

    public void setVariant(ProductVariant variant) {
        this.variant = variant;
    }

    public Promotion getPromotion() {
        return promotion;
    }

    public void setPromotion(Promotion promotion) {
        this.promotion = promotion;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
}
