package helmet.vn.ltw_bannonbaohiem.dao.cart;

import helmet.vn.ltw_bannonbaohiem.dao.model.ProductSize;

public class CartProduct {
    private int id;
    private String name;
    private String image;
    private int quantity;
    private ProductSize size;
    private double price;

    public CartProduct(int id, String name, String image, int quantity, ProductSize size, double price) {
        this.id = id;
        this.name = name;
        this.image = image;
        this.quantity = quantity;
        this.size = size;
        this.price = price;
    }

    public CartProduct() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public ProductSize getSize() {
        return size;
    }

    public void setSize(ProductSize size) {
        this.size = size;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
}
