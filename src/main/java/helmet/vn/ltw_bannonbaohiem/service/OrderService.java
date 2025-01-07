package helmet.vn.ltw_bannonbaohiem.service;

import helmet.vn.ltw_bannonbaohiem.dao.OrderDao;
import helmet.vn.ltw_bannonbaohiem.dao.cart.Cart;
import helmet.vn.ltw_bannonbaohiem.dao.model.Order;

import java.time.LocalDate;
import java.util.List;

public class OrderService {
    private OrderDao orderDao = new OrderDao();
    public List<Order> getAllList(){
        return orderDao.getListAll();
    }

    public boolean add(int id, Cart cart, String recipientName, String address, int methodPaymentId, String phone, String note, LocalDate estimatedDeliveryDate) {
        return orderDao.add(id, recipientName, address, methodPaymentId, phone, cart,note, estimatedDeliveryDate);
    }
}
