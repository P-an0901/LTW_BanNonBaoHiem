package helmet.vn.ltw_bannonbaohiem.dao.model;

public class ProductVariant {

    private int id;
    private String name;
    private int productId;
    private String color;
    private double price;
    private String image;

    public ProductVariant() {}

    public ProductVariant(int id, String name, int productId, String color, double price, String image) {
        this.id = id;
        this.name = name;
        this.productId = productId;
        this.color = color;
        this.price = price;
        this.image = image;
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

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }
}

