package helmet.vn.ltw_bannonbaohiem.dao.model;

public class ProductSize {

    private int id;
    private int variantId;
    private int sizeId;
    private int stock;

    // Constructor
    public ProductSize() {}

    public ProductSize(int id, int variantId, int sizeId, int stock) {
        this.id = id;
        this.variantId = variantId;
        this.sizeId = sizeId;
        this.stock = stock;
    }

    // Getter và Setter
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getVariantId() {
        return variantId;
    }

    public void setVariantId(int variantId) {
        this.variantId = variantId;
    }

    public int getSizeId() {
        return sizeId;
    }

    public void setSizeId(int sizeId) {
        this.sizeId = sizeId;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }
}

