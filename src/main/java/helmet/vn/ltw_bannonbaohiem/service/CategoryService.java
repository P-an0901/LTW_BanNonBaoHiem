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
}
