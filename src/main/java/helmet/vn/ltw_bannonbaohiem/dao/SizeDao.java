package helmet.vn.ltw_bannonbaohiem.dao;

import helmet.vn.ltw_bannonbaohiem.dao.db.JdbiConnect;
import helmet.vn.ltw_bannonbaohiem.dao.model.Sizes;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class SizeDao {
    Jdbi jdbi;

    public SizeDao(){this.jdbi = JdbiConnect.get();
    }
    public List<Sizes> getAllSize(){
        String sql = "SELECT * FROM sizes";
        return jdbi.withHandle(handle -> {
            return handle.createQuery(sql)
                    .mapToBean(Sizes.class)
                    .list();
        });
    }
    public boolean addSize(String name){
        return false;
    }
}
