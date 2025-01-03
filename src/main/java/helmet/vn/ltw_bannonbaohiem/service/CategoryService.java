package helmet.vn.ltw_bannonbaohiem.service;

import helmet.vn.ltw_bannonbaohiem.dao.CategoryDao;
import helmet.vn.ltw_bannonbaohiem.dao.model.Category;

import java.util.List;

public class CategoryService {
    CategoryDao cateDao = new CategoryDao();

    public Category getCateById(int id){
        return cateDao.getCateById(id);
    }
    public List<Category> getAllCate(){
        return cateDao.getAllCate();
    }

    public boolean addCate(String name, String image) {
        if(name != null){
            cateDao.addCate(name, image);
            return true;
        }
        return false;
    }

    public boolean deleteCate(int id) {
        if(cateDao.getCateById(id) != null){
            return cateDao.deleteCate(id);
        }
        return false;
    }

    public boolean updateCate(int id, String name, String image) {
        if(cateDao.getCateById(id) != null){
            return cateDao.updateCate(id, name, image);
        }
        return false;
    }
}
