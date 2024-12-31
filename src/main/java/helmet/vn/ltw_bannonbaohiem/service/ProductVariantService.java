package helmet.vn.ltw_bannonbaohiem.service;

import helmet.vn.ltw_bannonbaohiem.dao.ProductSizeDao;
import helmet.vn.ltw_bannonbaohiem.dao.ProductVariantDao;
import helmet.vn.ltw_bannonbaohiem.dao.model.Product;
import helmet.vn.ltw_bannonbaohiem.dao.model.ProductSize;
import helmet.vn.ltw_bannonbaohiem.dao.model.ProductVariant;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class ProductVariantService {
    ProductVariantDao productVariantD = new ProductVariantDao();
    ProductSizeDao proSizeD = new ProductSizeDao();

    public List<ProductVariant> getAllVariant(){
        return productVariantD.getAllVariant();
    }
    public List<ProductVariant> getAllVariantsForAdmin(){
        return productVariantD.getAllVariantsForAdmin();
    }
    public List<ProductVariant> getNewProductVariants(){
        return productVariantD.getNewProductVariants();
    }
    public boolean addProductVariant(String name, String color, int product, double price, String image, int active){
        return productVariantD.addVariant(name, color, product, price, image, active);
    }
    public ProductVariant getProVariant(int id){
        return productVariantD.getProVariantById(id);
    }
    public List<ProductVariant> getListProVarByProId(int id){
        List<ProductVariant> result = new ArrayList<>();
        for(ProductVariant variant : getAllVariant()){
            if(variant.getProductId() == id){
                result.add(variant);
            }
        }
        return result;

    }


    // product size
    public ProductSize getById(int id){
        return proSizeD.getById(id);
    }
    public List<ProductSize> getListSizeById(int id){
        return proSizeD.getSizeByVariantId(id);
    }
    public List<ProductSize> getListProSize(){return proSizeD.getAll();}

    public List<ProductVariant> getLimitedNewProductVariants(int limit) {
        List<ProductVariant> newProductVariants = getNewProductVariants();
        return newProductVariants.stream()
                .limit(limit)
                .collect(Collectors.toList());
    }
    public boolean updateVariant(int id, int productId, String name, String color, double price, String image, int active){
        return productVariantD.update(id, productId, name, color, price, image, active);
    }
}
