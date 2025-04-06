package helmet.vn.ltw_bannonbaohiem.service;

import helmet.vn.ltw_bannonbaohiem.dao.SizeDao;
import helmet.vn.ltw_bannonbaohiem.dao.model.Sizes;

import java.util.List;

public class SizeService {
    SizeDao sizeDao = new SizeDao();
    public List<Sizes> getAllSize(){
        return sizeDao.getAllSize();
    }

    public boolean add(String name) {
        return sizeDao.addSize(name);
    }
}
