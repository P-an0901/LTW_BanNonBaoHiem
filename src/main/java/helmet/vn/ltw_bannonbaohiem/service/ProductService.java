package helmet.vn.ltw_bannonbaohiem.service;

import helmet.vn.ltw_bannonbaohiem.dao.ProductDao;
import helmet.vn.ltw_bannonbaohiem.dao.model.Product;

import java.util.List;

public class ProductService {
    private ProductDao prodao = new ProductDao();

    public List<Product> getAllPro(){
        return prodao.getAllPro();
    }
    public Product getProById(int id){
        return prodao.getProById(id);
    }
}
