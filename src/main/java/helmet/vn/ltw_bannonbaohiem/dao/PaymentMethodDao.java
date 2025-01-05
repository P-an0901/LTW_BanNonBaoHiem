package helmet.vn.ltw_bannonbaohiem.dao;

import helmet.vn.ltw_bannonbaohiem.dao.db.JdbiConnect;
import helmet.vn.ltw_bannonbaohiem.dao.model.PaymentMethod;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class PaymentMethodDao {
    private Jdbi jdbi;
    public PaymentMethodDao(){
        this.jdbi = JdbiConnect.get();
    }
    public List<PaymentMethod> getListPaymentMethod(){
        String sql = "SELECT * FROM payment_methods";
        return jdbi.withHandle(handle -> {
            return handle.createQuery(sql)
                    .mapToBean(PaymentMethod.class)
                    .list();
        });
    }
}
