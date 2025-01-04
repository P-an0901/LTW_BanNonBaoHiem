package helmet.vn.ltw_bannonbaohiem.dao.model;

public class PaymentMethod {
    private int id;
    private String name;
    private int active;

    public PaymentMethod(int id, String name, int active) {
        this.id = id;
        this.name = name;
        this.active = active;
    }

    public PaymentMethod() {
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

    public int getActive() {
        return active;
    }

    public void setActive(int active) {
        this.active = active;
    }
    public String getActiveStatus() {
        return active == 1 ? "Hoạt động" : "Không hoạt động";
    }
}
