package helmet.vn.ltw_bannonbaohiem.controller.Filter;

import helmet.vn.ltw_bannonbaohiem.dao.ProductVariantDao;

import java.util.HashMap;
import java.util.Map;

public class DanhMucFilter {
    private Map<String, String> colorMap;
    private Map<String, String> filterMap;
    private Map<String, String> priceMap;
    public DanhMucFilter(){
        colorMap = new HashMap<>();
        colorMap.put("red", "Đỏ");
        colorMap.put("blue", "Xanh");
        colorMap.put("black", "Đen");
        colorMap.put("white", "Trắng");
        colorMap.put("green", "Xanh lá");
        colorMap.put("yellow", "Vàng");
        colorMap.put("gray", "Xám");

        filterMap = new HashMap<>();
        filterMap.put("all", "Tất cả");
        filterMap.put("new", "Mới nhất");
        filterMap.put("old", "Cũ nhất");
//        filterMap.put("popular", "Mua nhiều nhất");

        priceMap = new HashMap<>();
        priceMap.put("all", "Tất cả");
        priceMap.put("below500", "Dưới 500.000 đ");
        priceMap.put("500to1000", "Trên 500.000 đ Dưới 1.000.000 đ");
        priceMap.put("above10000", "Trên 1.000.000 đ");
    }

    public Map<String, String> getColorMap() {
        return colorMap;
    }

    public void setColorMap(Map<String, String> colorMap) {
        this.colorMap = colorMap;
    }

    public Map<String, String> getFilterMap() {
        return filterMap;
    }

    public void setFilterMap(Map<String, String> filterMap) {
        this.filterMap = filterMap;
    }

    public Map<String, String> getPriceMap() {
        return priceMap;
    }

    public void setPriceMap(Map<String, String> priceMap) {
        this.priceMap = priceMap;
    }
}
