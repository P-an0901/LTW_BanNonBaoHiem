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
        ProductSize selectedSize = pVService.getById(proSizeId);
        if (selectedSize == null) {
            System.out.println("Không tìm thấy kích cỡ cho sản phẩm.");
            return false;
        }
        String uniqueKey = pv.getId() + "_" + selectedSize.getId();
        if(data.containsKey(uniqueKey)){
            update(pv.getId(), proSizeId, data.get(uniqueKey).getQuantity()+ quantity);
            System.out.println("Đã cập nhật số lượng sản phẩm trong giỏ hàng.");
        }else{
            if(selectedSize.getStock() < quantity){
                System.out.println("Không đủ hàng để thêm số lượng này vào giỏ!");
                return false;
            }
            CartProduct cartProduct = new CartProduct(
                    pv.getId(),
                    pv.getName(),
                    pv.getImage(),
                    quantity,
                    selectedSize,
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

    public void delete(int pvId, int proSize) {
        data.remove(pvId + "_" + proSize);
    }


    public void update(int pvId, int sizeId, int newQuantity) {
        String key = pvId +"_" + sizeId;
        ProductSize selectedSize = pVService.getById(sizeId);
        if (data.containsKey(key)) {
            if(selectedSize.getStock() < newQuantity){
                System.out.println("Không đủ hàng để thêm số lượng này vào giỏ!");
                return;
            }
            CartProduct existingProduct = data.get(key);
            existingProduct.setQuantity(newQuantity);
            System.out.println("Đã cập nhật số lượng sản phẩm với key " + key);
        } else {
            System.out.println("Sản phẩm với key " + key + " không tồn tại trong giỏ hàng.");
        }
    }
}
