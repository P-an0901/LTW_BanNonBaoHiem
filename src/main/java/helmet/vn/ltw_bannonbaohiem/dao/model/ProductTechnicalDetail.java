package helmet.vn.ltw_bannonbaohiem.dao.model;

public class ProductTechnicalDetail {
    private int id;
    private int productId;
    private double weight;
    private String material;
    private String standards;
    private String warranty;
    private String visorType;
    private String returns;
    private String condition;
    private String madeIn;
    private String innerLining;
    private String lstSize;
    private String lstColor;
    public ProductTechnicalDetail() {
    }

    public ProductTechnicalDetail(int id, int productId, double weight, String material, String standards, String warranty,
                                  String visorType, String returns, String condition, String madeIn, String innerLining, String lstSize, String lstColor) {
        this.id = id;
        this.productId = productId;
        this.weight = weight;
        this.material = material;
        this.standards = standards;
        this.warranty = warranty;
        this.visorType = visorType;
        this.returns = returns;
        this.condition = condition;
        this.madeIn = madeIn;
        this.innerLining = innerLining;
        this.lstSize = lstSize;
        this.lstColor = lstColor;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public double getWeight() {
        return weight;
    }

    public void setWeight(double weight) {
        this.weight = weight;
    }

    public String getMaterial() {
        return material;
    }

    public void setMaterial(String material) {
        this.material = material;
    }

    public String getStandards() {
        return standards;
    }

    public void setStandards(String standards) {
        this.standards = standards;
    }

    public String getWarranty() {
        return warranty;
    }

    public void setWarranty(String warranty) {
        this.warranty = warranty;
    }

    public String getVisorType() {
        return visorType;
    }

    public void setVisorType(String visorType) {
        this.visorType = visorType;
    }

    public String getReturns() {
        return returns;
    }

    public void setReturns(String returns) {
        this.returns = returns;
    }

    public String getCondition() {
        return condition;
    }

    public void setCondition(String condition) {
        this.condition = condition;
    }

    public String getMadeIn() {
        return madeIn;
    }

    public void setMadeIn(String madeIn) {
        this.madeIn = madeIn;
    }

    public String getInnerLining() {
        return innerLining;
    }

    public void setInnerLining(String innerLining) {
        this.innerLining = innerLining;
    }

    public String getLstSize() {
        return lstSize;
    }

    public void setLstSize(String lstSize) {
        this.lstSize = lstSize;
    }

    public String getLstColor() {
        return lstColor;
    }

    public void setLstColor(String lstColor) {
        this.lstColor = lstColor;
    }
}
