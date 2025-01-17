package helmet.vn.ltw_bannonbaohiem.dao.model;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class Product {
    private int id;
    private String name;
    private String description;
    private Brand brand;
    private Category category;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private List<ProductVariant> listVariant;

    public Product() {
        this.listVariant = new ArrayList<>();
    }

    public Product(int id) {
        this.id = id;
    }

    public Product(int id, String name, String description, Brand brand, Category category, LocalDateTime createdAt, LocalDateTime updatedAt) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.brand = brand;
        this.category = category;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.listVariant = new ArrayList<>();
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Brand getBrand() {
        return brand;
    }

    public void setBrand(Brand brand) {
        this.brand = brand;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }
    public boolean addVariant(ProductVariant pv){
        return listVariant.add(pv);
    }

    public List<ProductVariant> getListVariant() {
        return listVariant;
    }

    public void setListVariant(List<ProductVariant> listVariant) {
        this.listVariant = listVariant;
    }

    @Override
    public String toString() {
        return "Product{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", brand=" + brand +
                ", category=" + category +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                '}';
    }

}
