package helmet.vn.ltw_bannonbaohiem.service;

import helmet.vn.ltw_bannonbaohiem.dao.ProductSizeDao;
import helmet.vn.ltw_bannonbaohiem.dao.ProductVariantDao;
import helmet.vn.ltw_bannonbaohiem.dao.model.Product;
import helmet.vn.ltw_bannonbaohiem.dao.model.ProductSize;
import helmet.vn.ltw_bannonbaohiem.dao.model.ProductVariant;

import java.util.List;

public class ProductVariantService {
    ProductVariantDao productVariantD = new ProductVariantDao();
    ProductSizeDao proSizeD = new ProductSizeDao();

    public List<ProductVariant> getAllVariant(){
        return productVariantD.getAllVariant();
    }
    public boolean addProductVariant(String name, String color, int product, double price, String image, int active){
        return productVariantD.addVariant(name, color, product, price, image, active);
    }
    public ProductVariant getProVariant(int id){
        return productVariantD.getProVariantById(id);
    }
    public List<ProductSize> getListSizeById(int id){
        return proSizeD.getSizeByVariantId(id);
    }
    public List<ProductVariant> getListProVarByProId(int id){
        return productVariantD.listProVariantByProId(id);
    }
    public ProductSize getById(int id){
        return proSizeD.getById(id);
    }

}
