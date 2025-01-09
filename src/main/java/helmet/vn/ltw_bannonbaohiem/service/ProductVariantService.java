package helmet.vn.ltw_bannonbaohiem.service;

import helmet.vn.ltw_bannonbaohiem.dao.ProductSizeDao;
import helmet.vn.ltw_bannonbaohiem.dao.ProductVariantDao;
import helmet.vn.ltw_bannonbaohiem.dao.PromotionDao;
import helmet.vn.ltw_bannonbaohiem.dao.PromotionVariantDao;
import helmet.vn.ltw_bannonbaohiem.dao.model.Product;
import helmet.vn.ltw_bannonbaohiem.dao.model.ProductSize;
import helmet.vn.ltw_bannonbaohiem.dao.model.ProductVariant;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

public class ProductVariantService {
    ProductVariantDao productVariantD = new ProductVariantDao();
    PromotionVariantDao promtionVaD = new PromotionVariantDao();
    ProductSizeDao proSizeD = new ProductSizeDao();

    public List<ProductVariant> getAllVariant(){
        List<ProductVariant> variants = productVariantD.getAllVariant(false);
        return supportVariantSize(variants);
    }
    public List<ProductVariant> getAllVariantsForAdmin(){
        List<ProductVariant> variants = productVariantD.getAllVariant(true);
        return supportVariantSize(variants);
    }
    public List<ProductVariant> getNewProductVariants(){
        List<ProductVariant> variants = productVariantD.getNewProductVariants();
        return supportVariantSize(variants);
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

    public List<ProductVariant> getProVariantsByCategoryIdWithPagination(int categoryId, int offset, int pageSize) {
        List<ProductVariant> variants = productVariantD.getProVariantsByCategoryIdWithPagination(categoryId, offset, pageSize);
        return supportVariantSize(variants);
    }

    public int getTotalVariantCount(int categoryId) {
        return productVariantD.getTotalVariantCount(categoryId);
    }
    private List<ProductVariant> supportVariantSize(List<ProductVariant> variants){
        List<Integer> variantIds = variants.stream().map(ProductVariant::getId).collect(Collectors.toList());
        if (!variantIds.isEmpty()) {
            Map<Integer, List<ProductSize>> sizeMap = productVariantD.getProductSizes(variantIds);
            Set<Integer> listIdVariantSale = promtionVaD.listVariantIds();
            for (ProductVariant variant : variants) {
                List<ProductSize> sizes = sizeMap.getOrDefault(variant.getId(), List.of());
                variant.setListPSize(sizes);
                if (listIdVariantSale.contains(variant.getId())) {
                    variant.setSale(true);
                }
            }
        }

        return variants;
    }

    public List<ProductVariant> getLimitedSaleProductVariants(int limit) {
        List<ProductVariant> saleProductVariants = getSaleProductVariants();
        return saleProductVariants.stream()
                .limit(limit)
                .collect(Collectors.toList());
    }

    private List<ProductVariant> getSaleProductVariants() {
        List<ProductVariant> variants = productVariantD.getSaleProductVariants();
        return supportVariantSize(variants);
    }

    public boolean addNewSize(int variantId, int sizeid, int stock) {
        return proSizeD.add(variantId, sizeid, stock);
    }

    public boolean deleteProSize(String id) {
        return proSizeD.delete(Integer.parseInt(id));
    }

    public boolean deleteVariant(String id) {
        return productVariantD.delete(Integer.parseInt(id));
    }
}
