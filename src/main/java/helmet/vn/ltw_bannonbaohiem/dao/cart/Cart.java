package helmet.vn.ltw_bannonbaohiem.dao.cart;

import helmet.vn.ltw_bannonbaohiem.dao.model.ProductSize;
import helmet.vn.ltw_bannonbaohiem.dao.model.ProductVariant;
import helmet.vn.ltw_bannonbaohiem.service.ProductVariantService;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Cart {
    Map<String, CartProduct> data = new HashMap<>();
    ProductVariantService pVService = new ProductVariantService();

    public boolean add(ProductVariant pv, int proSizeId, int quantity){
        List<ProductSize> sizes = pVService.getListSizeById(pv.getId());
        ProductSize selectedSize = null;
        System.out.println(sizes);

        for(ProductSize size: sizes) {
            if(size.getId() == proSizeId){
                System.out.println(sizes);
                selectedSize = size;
                break;
            }
        }
        if(selectedSize == null){
            System.out.println("null sizw");
            return false;
        }
        if(selectedSize.getStock() < quantity){
            return false;
        }
        String uniqueKey = pv.getId() + "_" + selectedSize.getSize().getName();
        if(data.containsKey(uniqueKey)){
            CartProduct existingProduct = data.get(uniqueKey);
            int newQuantity = existingProduct.getQuantity() + quantity;

            if (selectedSize.getStock() < newQuantity) {
                System.out.println("Không đủ hàng để thêm số lượng này vào giỏ!");
                return false;
            }

            existingProduct.setQuantity(newQuantity);
            System.out.println("Đã cập nhật số lượng sản phẩm trong giỏ hàng.");
        }else{
            CartProduct cartProduct = new CartProduct(
                    pv.getId(),
                    pv.getName(),
                    pv.getImage(),
                    quantity,
                    selectedSize.getSize().getName(),
                    pv.getPrice()
            );
            data.put(uniqueKey, cartProduct);
            System.out.println("Đã thêm sản phẩm vào giỏ hàng.");
        }

        return true;
    }
    public List<CartProduct> show(){
        return new ArrayList<>(data.values());
    }

    public void delete(int pvId, String proSize) {
        data.remove(pvId + "_" + proSize);
    }


    public void update(int productId, int quantity) {
    }
}
