package helmet.vn.ltw_bannonbaohiem.dao.model;

import java.time.Duration;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class ProductVariant {

    private int id;
    private String name;
    private int productId;
    private String color;
    private double price;
    private String image;
    private List<ProductSize> listPSize;
    private boolean isActive;
    private LocalDateTime createdAt;
    private boolean newProV;
    private boolean isSale;
    private double salePrice;
    public ProductVariant() {}

    public ProductVariant(int id, String name) {
        this.id = id;
        this.name = name;
    }

    public ProductVariant(int id, String name, int productId, String color, double price, String image, boolean isActive, LocalDateTime createdAt) {
        this.id = id;
        this.name = name;
        this.productId = productId;
        this.color = color;
        this.price = price;
        this.image = image;
        this.isActive = isActive;
        this.createdAt = createdAt;
        this.listPSize = new ArrayList<>();
        this.newProV = isNewProduct();
        this.salePrice = 0;
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

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }
    public boolean addPSize(ProductSize s){
        return listPSize.add(s);
    }

    public List<ProductSize> getListPSize() {
        return listPSize;
    }

    public void setListPSize(List<ProductSize> listPSize) {
        this.listPSize = listPSize;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public boolean isNewProV() {
        return isNewProduct();
    }

    public void setNewProV(boolean newProV) {
        this.newProV = newProV;
    }

    public boolean isNewProduct() {
        if (createdAt == null) {
            return false;
        }
        long daysDifference = Duration.between(createdAt, LocalDateTime.now()).toDays();
        return daysDifference <= 30;
    }

    public boolean isSale() {
        return isSale;
    }

    public void setSale(boolean sale) {
        isSale = sale;
    }

    public double getSalePrice() {
        return salePrice;
    }

    public void setSalePrice(double percent) {
        this.salePrice = this.price - this.price*percent;
    }

    @Override
    public String toString() {
        return "ProductVariant{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", productId=" + productId +
                ", color='" + color + '\'' +
                ", price=" + price +
                ", image='" + image + '\'' +
                ", listPSize=" + listPSize +
                ", isActive=" + isActive +
                '}';
    }
}

