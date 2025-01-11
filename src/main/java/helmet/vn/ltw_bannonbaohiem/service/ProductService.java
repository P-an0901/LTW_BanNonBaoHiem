package helmet.vn.ltw_bannonbaohiem.service;

import helmet.vn.ltw_bannonbaohiem.dao.ProductDao;
import helmet.vn.ltw_bannonbaohiem.dao.model.Product;
import helmet.vn.ltw_bannonbaohiem.dao.model.ProductTechnicalDetail;
import helmet.vn.ltw_bannonbaohiem.dao.model.ProductVariant;

import java.util.ArrayList;
import java.util.List;

public class ProductService {
    private ProductDao prodao = new ProductDao();

    public List<Product> getAllPro(){
        return prodao.getAllPro();
    }
    public Product getProById(int id){
        return prodao.getProById(id);
    }
    public boolean addProduct(String name, String description, int brandId, int cateId){
        return prodao.addProduct(name, description, brandId, cateId);
    }
    public boolean updateProduct(int id, String name, String description, int brandId, int cateId){
        return prodao.updateProduct(id, name, description, brandId, cateId);
    }
    public List<Product> getProByCateId(int id){
        List<Product> list = new ArrayList<>();
        for (Product pro : getAllPro()) {
            if(pro.getCategory().getId() == id){
                list.add(pro);
            }
        }
        return list;
    }
    public boolean deleteProduct(String id) {
        return prodao.delete(Integer.parseInt(id));
    }

    public ProductTechnicalDetail getProductTeach(int productId){
        return prodao.getProductTech(productId);
    }
}
