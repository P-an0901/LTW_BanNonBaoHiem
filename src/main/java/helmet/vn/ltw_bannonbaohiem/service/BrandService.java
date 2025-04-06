package helmet.vn.ltw_bannonbaohiem.service;

import helmet.vn.ltw_bannonbaohiem.dao.BrandDao;
import helmet.vn.ltw_bannonbaohiem.dao.db.JdbiConnect;
import helmet.vn.ltw_bannonbaohiem.dao.model.Brand;
import org.jdbi.v3.core.Handle;
import java.util.List;

public class BrandService {

    private BrandDao brandDao = new BrandDao();
    public List<Brand> getAllBrands() {
        return brandDao.getAllBrands();
    }

    public boolean deleteBrand(int id) {
        if(brandDao.getBrandById(id) != null){
            return brandDao.deleteBrand(id);
        }
        return false;
    }

    public boolean addBrand(String name, String imageUrl) {
        if(name != null && imageUrl != null){
            brandDao.addBrand(name, imageUrl);
            return true;
        }
        return false;
    }


    public boolean updateBrand(int id, String name, String imageUrl) {
        if(brandDao.getBrandById(id) != null){
            return brandDao.updateBrand(id, name, imageUrl);
        }
        return false;
    }
    public Brand getBrandById(int id){
        return brandDao.getBrandById(id);
    }
    public static void main(String[] args) {
        // Tạo đối tượng BrandDao
        BrandDao brandDao = new BrandDao();
        List<Brand> brands = brandDao.getAllBrands();
        //brandDao.addBrand("2", "11");
        for (Brand brand : brands) {
            System.out.println(brand);
        }
    }
}

