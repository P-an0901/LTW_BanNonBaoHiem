package helmet.vn.ltw_bannonbaohiem.dao;

import helmet.vn.ltw_bannonbaohiem.dao.cart.Cart;
import helmet.vn.ltw_bannonbaohiem.dao.cart.CartProduct;
import helmet.vn.ltw_bannonbaohiem.dao.db.JdbiConnect;
import helmet.vn.ltw_bannonbaohiem.dao.model.*;
import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.core.statement.Update;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.sql.Date;
import java.time.LocalDateTime;
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
        Order order = new Order();
        order.setId(rs.getInt("id"));
        order.setRecipientName(rs.getString("recipientName"));
        order.setShippingAddress(rs.getString("shippingAddress"));
        order.setPhone(rs.getString("phone"));
        order.setTotalAmount(rs.getDouble("totalAmount"));
        order.setStatus(rs.getString("status"));
        order.setCreatedAt(rs.getTimestamp("createdAt").toLocalDateTime());
        order.setUpdatedAt(rs.getTimestamp("updatedAt").toLocalDateTime());
        order.setEstimatedDelivery(rs.getDate("estimatedDelivery").toLocalDate());
        Date deliveryDate = rs.getDate("deliveryDate");
        if (deliveryDate != null) {
            order.setDeliveryDate(deliveryDate.toLocalDate());
        } else {
            order.setDeliveryDate(null);
        }

        User user = new User();
        user.setId(rs.getInt("userId"));
        user.setFullName(rs.getString("user_name"));
        order.setUser(user);

        PaymentMethod paymentMethod = new PaymentMethod();
        paymentMethod.setId(rs.getInt("paymentMethodId"));
        paymentMethod.setName(rs.getString("payment_method_name"));
        order.setPaymentMethod(paymentMethod);

        return order;
    }
    public boolean add(int uid, String recipientName, String address, int methodPaymentId, String phone, Cart cart, String note, LocalDate estimatedDeliveryDate) {
        String sql = "INSERT INTO orders(userId, recipientName, shippingAddress, paymentMethodId, phone, totalAmount, status, note, estimatedDelivery) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
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
                        .bind(7, note != null ? note : null)
                        .bind(8, estimatedDeliveryDate)
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

    public void updateStatus(int oid, String status) {
        StringBuilder sqlBuilder = new StringBuilder("UPDATE orders SET status = :status");
        if ("Đã giao".equalsIgnoreCase(status)) {
            sqlBuilder.append(", deliveryDate = :date");
        }
        sqlBuilder.append(" WHERE id = :oid");

        try {
            jdbi.useHandle(handle -> {
                var update = handle.createUpdate(sqlBuilder.toString())
                        .bind("status", status)
                        .bind("oid", oid);
                if ("Đã giao".equalsIgnoreCase(status)) {
                    update.bind("date", LocalDate.now());
                }
                update.execute();
            });
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public int countOrder() {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT COUNT(*) FROM orders WHERE status NOT LIKE 'Đã giao' ")
                        .mapTo(int.class)
                        .one()
        );
    }

    public double revenueMonth() {
        String sql = "SELECT SUM(totalAmount) FROM orders " +
                "WHERE MONTH(deliveryDate) = MONTH(CURRENT_DATE()) AND YEAR(deliveryDate) = YEAR(CURRENT_DATE())";

        // Sử dụng JDBI để thực thi truy vấn
        return jdbi.withHandle(handle -> {
            return handle.createQuery(sql)
                    .mapTo(Double.class)
                    .findOne()
                    .orElse(0.0);
        });
    }

    public int countVariantSell() {
        String sql = "SELECT oi.quantity " +
                "FROM order_items oi " +
                "JOIN orders o ON oi.orderId = o.id " +
                "WHERE o.status = 'Đã giao'";

        return jdbi.withHandle(handle -> {
            return handle.createQuery(sql)
                    .mapTo(Integer.class)
                    .reduce(0, (total, quantity) -> total + quantity);
        });
    }

    public Order getDetailOrder(int oid) {
        String orderSql = "SELECT o.*, p.name AS payment_method_name FROM orders o " +
                "JOIN payment_methods p ON o.paymentMethodId = p.id WHERE o.id = :orderId";

        Order order = jdbi.withHandle(handle -> {
            return handle.createQuery(orderSql)
                    .bind("orderId", oid)
                    .map((rs, ctx) -> {
                        Order orderObj = new Order();
                        orderObj.setId(rs.getInt("id"));
                        orderObj.setRecipientName(rs.getString("recipientName"));
                        orderObj.setShippingAddress(rs.getString("shippingAddress"));
                        orderObj.setPhone(rs.getString("phone"));
                        orderObj.setTotalAmount(rs.getDouble("totalAmount"));
                        orderObj.setStatus(rs.getString("status"));
                        orderObj.setNote(rs.getString("note"));

                        orderObj.setEstimatedDelivery(rs.getObject("estimatedDelivery", LocalDate.class));
                        orderObj.setDeliveryDate(rs.getObject("deliveryDate", LocalDate.class));

                        orderObj.setCreatedAt(rs.getObject("createdAt", LocalDateTime.class));
                        orderObj.setUpdatedAt(rs.getObject("updatedAt", LocalDateTime.class));

                        String paymentMethodName = rs.getString("payment_method_name");
                        PaymentMethod paymentMethod = new PaymentMethod();
                        paymentMethod.setName(paymentMethodName);

                        orderObj.setPaymentMethod(paymentMethod);

                        return orderObj;
                    })
                    .findOne()
                    .orElse(null);
        });
        if (order != null) {
            String itemsSql = "SELECT oi.id, oi.quantity, oi.price, pv.name AS variant_name, pv.image AS variant_image," +
                    "s.name AS size_name, s.id AS sid  " +
                    "FROM order_items oi " +
                    "JOIN product_variants pv ON oi.productVariantId = pv.id " +
                    "JOIN sizes s ON oi.sizeId = s.id " +
                    "WHERE oi.orderId = :orderId";

            List<OrderItem> items = jdbi.withHandle(handle -> handle.createQuery(itemsSql)
                    .bind("orderId", oid)
                    .map((rs, ctx) -> {
                        OrderItem orderItem = new OrderItem();
                        orderItem.setId(rs.getInt("id"));
                        orderItem.setQuantity(rs.getInt("quantity"));
                        orderItem.setPrice(rs.getDouble("price"));

                        String variantName = rs.getString("variant_name");
                        String variantImage = rs.getString("variant_image");

                        ProductVariant productVariant = new ProductVariant();
                        productVariant.setName(variantName);
                        productVariant.setImage(variantImage);

                        String sizeName = rs.getString("size_name");

                        Sizes size = new Sizes();
                        size.setId(rs.getInt("sid"));
                        size.setName(sizeName);

                        orderItem.setProVariant(productVariant);
                        orderItem.setSize(size);

                        return orderItem;
                    })
                    .list());

            order.setListItem(items);
        }
        return order;
    }

}
