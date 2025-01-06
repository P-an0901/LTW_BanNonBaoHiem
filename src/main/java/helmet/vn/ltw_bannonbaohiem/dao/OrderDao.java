package helmet.vn.ltw_bannonbaohiem.dao;

import helmet.vn.ltw_bannonbaohiem.dao.cart.Cart;
import helmet.vn.ltw_bannonbaohiem.dao.cart.CartProduct;
import helmet.vn.ltw_bannonbaohiem.dao.db.JdbiConnect;
import helmet.vn.ltw_bannonbaohiem.dao.model.Order;
import helmet.vn.ltw_bannonbaohiem.dao.model.PaymentMethod;
import helmet.vn.ltw_bannonbaohiem.dao.model.User;
import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.core.statement.Update;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class OrderDao {
    private Jdbi jdbi;

    public OrderDao() {
        this.jdbi = JdbiConnect.get();
    }
    public List<Order> getListAll(){
        String sql = "SELECT o.*, " +
                "u.id AS userId, u.fullName AS user_name, " +
                "p.id AS paymentMethodId, p.name AS payment_method_name " +
                "FROM orders o " +
                "JOIN users u ON o.userId = u.id " +
                "JOIN payment_methods p ON o.paymentMethodId = p.id";
        return jdbi.withHandle(handle -> {
            return handle.createQuery(sql)
                    .map((rs, ctx) ->  mapOrder(rs))
                    .list();
        });
    }

    public List<Order> getListByStatus(String status) {
        String sql = "SELECT o.*, " +
                "u.id AS userId, u.fullName AS user_name, " +
                "p.id AS paymentMethodId, p.name AS payment_method_name " +
                "FROM orders o " +
                "JOIN users u ON o.userId = u.id " +
                "JOIN payment_methods p ON o.paymentMethodId = p.id " +
                "WHERE o.status = :status";  // Điều kiện lọc theo status

        return jdbi.withHandle(handle -> {
            return handle.createQuery(sql)
                    .bind("status", status)
                    .map((rs, ctx) -> mapOrder(rs))
                    .list();
        });
    }
    private Order mapOrder(ResultSet rs) throws SQLException {
        // Ánh xạ Order
        Order order = new Order();
        order.setId(rs.getInt("id"));
        order.setRecipientName(rs.getString("recipientName"));
        order.setShippingAddress(rs.getString("shippingAddress"));
        order.setPhone(rs.getString("phone"));
        order.setTotalAmount(rs.getDouble("totalAmount"));
        order.setStatus(rs.getString("status"));
        order.setCreatedAt(rs.getTimestamp("createdAt").toLocalDateTime());
        order.setUpdatedAt(rs.getTimestamp("updatedAt").toLocalDateTime());

        // Ánh xạ User
        User user = new User();
        user.setId(rs.getInt("userId"));
        user.setFullName(rs.getString("user_name"));
        order.setUser(user);

        // Ánh xạ PaymentMethod
        PaymentMethod paymentMethod = new PaymentMethod();
        paymentMethod.setId(rs.getInt("paymentMethodId"));
        paymentMethod.setName(rs.getString("payment_method_name"));
        order.setPaymentMethod(paymentMethod);

        return order;
    }



    public boolean add(int uid, String recipientName, String address, int methodPaymentId, String phone, Cart cart) {
        String sql = "INSERT INTO orders(userId, recipientName, shippingAddress, paymentMethodId, phone, totalAmount, status) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";
        String insertOrderItemsSql = "INSERT INTO order_items (orderId, productVariantId, sizeId, quantity, price) VALUES (?, ?, ?, ?, ?)";

        try {
            jdbi.useTransaction(handle -> {
                int orderId = handle.createUpdate(sql)
                        .bind(0, uid)
                        .bind(1, recipientName)
                        .bind(2, address)
                        .bind(3, methodPaymentId)
                        .bind(4, phone)
                        .bind(5, cart.getTotalPrice())
                        .bind(6, "Đang xử lý")
                        .executeAndReturnGeneratedKeys("id")
                        .mapTo(int.class)
                        .one();

                for (CartProduct item : cart.getList()) {
                    handle.createUpdate(insertOrderItemsSql)
                            .bind(0, orderId)
                            .bind(1, item.getId())
                            .bind(2, item.getSize().getSize().getId())
                            .bind(3, item.getQuantity())
                            .bind(4, item.getPrice())
                            .execute();
                }
            });
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

}
