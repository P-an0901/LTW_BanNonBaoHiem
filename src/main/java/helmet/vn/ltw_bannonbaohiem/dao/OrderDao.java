package helmet.vn.ltw_bannonbaohiem.dao;

import helmet.vn.ltw_bannonbaohiem.dao.db.JdbiConnect;
import helmet.vn.ltw_bannonbaohiem.dao.model.Order;
import helmet.vn.ltw_bannonbaohiem.dao.model.PaymentMethod;
import helmet.vn.ltw_bannonbaohiem.dao.model.User;
import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.core.statement.Update;

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
                    .map((rs, ctx) -> {
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

                        User user = new User();
                        user.setId(rs.getInt("userId"));
                        user.setFullName(rs.getString("user_name"));
                        order.setUser(user);

                        PaymentMethod paymentMethod = new PaymentMethod();
                        paymentMethod.setId(rs.getInt("paymentMethodId"));
                        paymentMethod.setName(rs.getString("payment_method_name"));
                        order.setPaymentMethod(paymentMethod);

                        return order;
                    })
                    .list();
        });
    }

    public boolean add(int id, String recipientName, String address, int methodPaymentId, String phone, double totalPrice) {
        String sql = "INSERT INTO orders(id, recipientName, address, methodPaymentId, phone, totalAmount, status)" +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try{
            return jdbi.withHandle(handle -> {
                Update update = handle.createUpdate(sql);
                update.bind(0, id);
                update.bind(1, recipientName);
                update.bind(2, address);
                update.bind(3, methodPaymentId);
                update.bind(4, phone);
                update.bind(5, totalPrice);
                update.bind(6, "Đang xử lý");
                int rowsAffected = update.execute();
                return rowsAffected > 0;
            });
        }catch (Exception e ){
            e.printStackTrace();
            return false;
        }
    }
}
