package helmet.vn.ltw_bannonbaohiem.service;

import helmet.vn.ltw_bannonbaohiem.dao.OrderDao;
import helmet.vn.ltw_bannonbaohiem.dao.cart.Cart;
import helmet.vn.ltw_bannonbaohiem.dao.model.Order;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class OrderService {
    private OrderDao orderDao = new OrderDao();
    private Map<Integer, String> status = new HashMap<>();
    public OrderService(){
        status.put(1, "Đang xử lý");
        status.put(2, "Đang giao");
        status.put(3, "Đã giao");
        status.put(4, "Đã hủy");
    }
    public List<Order> getAllList(){
        return orderDao.getListAll();
    }

    public boolean add(int id, Cart cart, String recipientName, String address, int methodPaymentId, String phone, String note, LocalDate estimatedDeliveryDate) {
        return orderDao.add(id, recipientName, address, methodPaymentId, phone, cart,note, estimatedDeliveryDate);
    }
    public Map<Integer, String> getStatusMap() {
        return status;
    }
    public String getStatusName(int statusId) {
        return status.getOrDefault(statusId, "Không xác định");
    }

    public void updateStatus(int oid, String status) {
        orderDao.updateStatus(oid, status);
    }

    public int countOrder() {
        return orderDao.countOrder();
    }

    public double revenueMonth() {
        return orderDao.revenueMonth();
    }

    public int countVariantSell() {
        return orderDao.countVariantSell();
    }
}
