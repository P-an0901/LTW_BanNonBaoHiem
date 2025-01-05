package helmet.vn.ltw_bannonbaohiem.service;

import helmet.vn.ltw_bannonbaohiem.dao.PaymentMethodDao;
import helmet.vn.ltw_bannonbaohiem.dao.model.PaymentMethod;

import java.util.List;

public class PaymentMethodService {
    private PaymentMethodDao payDao = new PaymentMethodDao();
    public List<PaymentMethod> getListPaymentMethod(){
        return payDao.getListPaymentMethod();
    }
}
