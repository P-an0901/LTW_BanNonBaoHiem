package helmet.vn.ltw_bannonbaohiem.dao.model;

public class OrderItem {
    private int id;
    private ProductVariant proVariant;
    private Sizes size;
    private int quantity;
    private double price;

    public OrderItem(int id, ProductVariant proVariant, Sizes size, int quantity, double price) {
        this.id = id;
        this.proVariant = proVariant;
        this.size = size;
        this.quantity = quantity;
        this.price = price;
    }

    public OrderItem() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public ProductVariant getProVariant() {
        return proVariant;
    }

    public void setProVariant(ProductVariant proVariant) {
        this.proVariant = proVariant;
    }

    public Sizes getSize() {
        return size;
    }

    public void setSize(Sizes size) {
        this.size = size;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
}
