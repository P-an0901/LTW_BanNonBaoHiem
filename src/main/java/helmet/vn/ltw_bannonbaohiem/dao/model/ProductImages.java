package helmet.vn.ltw_bannonbaohiem.dao.model;

public class ProductImages {
    private int id;
    private String image;
    private int productVariantId;

    public ProductImages(int id, String image, int productVariantId) {
        this.id = id;
        this.image = image;
        this.productVariantId = productVariantId;
    }

    public ProductImages() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getProductVariantId() {
        return productVariantId;
    }

    public void setProductVariantId(int productVariantId) {
        this.productVariantId = productVariantId;
    }
}
