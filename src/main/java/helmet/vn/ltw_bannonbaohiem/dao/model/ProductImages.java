package helmet.vn.ltw_bannonbaohiem.dao.model;

public class ProductImages {
    private int id;
    private String imageUrl;
    private int variantId;

    public ProductImages(int id, String imageUrl, int variantId) {
        this.id = id;
        this.imageUrl = imageUrl;
        this.variantId = variantId;
    }

    public ProductImages() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public int getVariantId() {
        return variantId;
    }

    public void setVariantId(int variantId) {
        this.variantId = variantId;
    }
}