package helmet.vn.ltw_bannonbaohiem.dao.model;

public class Brand {
    private int id;
    private String name;
    private String imageUrl;
    public Brand(int id, String name, String imageUrl){
        this.id = id;
        this.name = name;
        this.imageUrl = imageUrl;
    }
    public Brand() {
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

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    @Override
    public String toString() {
        return "Brand{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", imageUrl='" + imageUrl + '\'' +
                '}';
    }
}
