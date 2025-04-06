package helmet.vn.ltw_bannonbaohiem.dao.model;

public class Sizes {

    private int id;
    private String name;

    public Sizes() {}

    public Sizes(int id, String name) {
        this.id = id;
        this.name = name;
    }

    // Getter và Setter
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
}

