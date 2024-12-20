package helmet.vn.ltw_bannonbaohiem.dao.model;

public class ProductSize {

    private int id;
    private int variantId;
    private Sizes size;
    private int stock;

    // Constructor
    public ProductSize() {}

    public ProductSize(int id, int variantId, Sizes size, int stock) {
        this.id = id;
        this.variantId = variantId;
        this.size = size;
        this.stock = stock;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getVariantid() {
        return variantId;
    }

    public void setVariantId(int variantId) {
        this.variantId = variantId;
    }

    public Sizes getSize() {
        return size;
    }

    public void setSize(Sizes size) {
        this.size = size;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    @Override
    public String toString() {
        return "ProductSize{" +
                "id=" + id +
                ", variantId=" + variantId +
                ", size=" + size +
                ", stock=" + stock +
                '}';
    }
}

