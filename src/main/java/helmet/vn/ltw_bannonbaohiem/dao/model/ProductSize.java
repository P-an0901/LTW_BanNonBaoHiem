package helmet.vn.ltw_bannonbaohiem.dao.model;

public class ProductSize {

    private int id;
    private ProductVariant variant;
    private Sizes size;
    private int stock;

    // Constructor
    public ProductSize() {}

    public ProductSize(int id, ProductVariant variant, Sizes size, int stock) {
        this.id = id;
        this.variant = variant;
        this.size = size;
        this.stock = stock;
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
                ", variant=" + variant +
                ", size=" + size +
                ", stock=" + stock +
                '}';
    }
}

