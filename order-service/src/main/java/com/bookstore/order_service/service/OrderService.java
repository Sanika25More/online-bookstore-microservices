package com.bookstore.order_service.service;

import com.bookstore.order_service.client.BookClient;
import com.bookstore.order_service.client.PaymentClient;
import com.bookstore.order_service.client.UserClient;
import com.bookstore.order_service.client.UserResponse;
import com.bookstore.order_service.dto.PaymentRequest;
import com.bookstore.order_service.dto.PaymentResponse;
import com.bookstore.order_service.entity.Order;
import com.bookstore.order_service.repository.OrderRepository;
import jakarta.persistence.Column;
import jakarta.persistence.PrePersist;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class OrderService {

    private final OrderRepository orderRepository;
    private final PaymentClient paymentClient;
    private final UserClient userClient;
    private final BookClient bookClient;

    public OrderService(OrderRepository orderRepository,
                        PaymentClient paymentClient,
                        UserClient userClient,
                        BookClient bookClient) {
        this.orderRepository = orderRepository;
        this.paymentClient = paymentClient;
        this.userClient = userClient;
        this.bookClient = bookClient;
    }

    public Order placeOrder(Order order) {
        // 1. Validate user
        UserResponse userResponse = userClient.getUserById(order.getUserId());
        if (userResponse == null) {
            throw new RuntimeException("User not found with ID " + order.getUserId());
        }

        // 2. Save initial order
        Order savedOrder = orderRepository.save(order);

        // 3. Call Payment Service
        PaymentRequest paymentRequest = new PaymentRequest(
                savedOrder.getId(),
                savedOrder.getTotalPrice(),
                "CREDIT_CARD"
        );

        PaymentResponse paymentResponse = paymentClient.makePayment(paymentRequest);

        // 4. Update order status
        if ("SUCCESS".equalsIgnoreCase(paymentResponse.getStatus())
                || "SUCCESSFUL".equalsIgnoreCase(paymentResponse.getStatus())) {

            savedOrder.setStatus("CONFIRMED");

            // ✅ Reduce stock after successful payment
            bookClient.reduceStock(order.getBookId(), order.getQuantity());

        } else {
            savedOrder.setStatus("FAILED");
        }

        return orderRepository.save(savedOrder);
    }


    public List<Order> getAllOrders() {
        return orderRepository.findAll();
    }

    public Optional<Order> getOrderById(Long id) {
        return orderRepository.findById(id);
    }

    public List<Order> getOrdersByUser(Long userId) {
        return orderRepository.findByUserId(userId);
    }

    public Order updateOrderStatus(Long id, String status) {
        Optional<Order> optionalOrder = orderRepository.findById(id);
        if (optionalOrder.isPresent()) {
            Order order = optionalOrder.get();
            order.setStatus(status);
            return orderRepository.save(order);
        }
        throw new RuntimeException("Order not found with id " + id);
    }

    public void deleteOrder(Long id) {
        orderRepository.deleteById(id);
    }

    @Column(name = "order_date")
    private LocalDateTime orderDate;

    @PrePersist
    public void prePersist() {
        this.orderDate = LocalDateTime.now();
    }
}
